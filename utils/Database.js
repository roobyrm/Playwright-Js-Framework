const mysql = require("mysql2/promise");
require("dotenv").config();

class Database {
  constructor() {
    this.connection = null;
  }

  async connect() {
    try {
      if (
        !process.env.DB_HOST ||
        !process.env.DB_USER ||
        !process.env.DB_PASSWORD ||
        !process.env.DB_DATABASE
      ) {
        throw new Error("Missing database configuration. Check .env file");
      }

      this.connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        port:
          process.platform === "darwin"
            ? process.env.DB_PORT_MACOS || 3306
            : process.env.DB_PORT || 3306,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DATABASE,
      });

      console.log("Successfully connected to database");
    } catch (error) {
      console.error("Database connection error:", error);
      throw error;
    }
  }
  async query(sql, params = []) {
    return await this.connection.execute(sql, params);
  }

  async disconnect() {
    if (this.connection) {
      await this.connection.end();
    }
  }

  async clearCart(userId) {
    try {
      console.log(`Clearing cart data for user ID: ${userId}...`);

      // First verify user exists
      const [userCheck] = await this.query(
        `SELECT ID FROM wp_users WHERE ID = ?`,
        [userId]
      );

      if (!userCheck.length) {
        throw new Error(`User ID ${userId} not found`);
      }

      // Get current session key for the user
      const [sessions] = await this.query(
        `SELECT session_key FROM wp_woocommerce_sessions WHERE session_key LIKE ?`,
        [`%${userId}%`]
      );

      // Clear sessions using actual session key
      if (sessions && sessions.length > 0) {
        for (const session of sessions) {
          await this.query(
            `DELETE FROM wp_woocommerce_sessions WHERE session_key = ?`,
            [session.session_key]
          );
        }
      }

      // Rest of cleanup queries
      const queries = [
        {
          sql: `DELETE FROM wp_usermeta WHERE user_id = ? AND meta_key LIKE ?`,
          params: [userId, "%_woocommerce_persistent_cart%"],
        },
        {
          sql: `DELETE FROM wp_options WHERE option_name LIKE ? OR option_name LIKE ? OR option_name LIKE ?`,
          params: ["_wc_session_%", "%wc_fragments_%", "_transient%wc%"],
        },
        {
          sql: `INSERT INTO wp_usermeta (user_id, meta_key, meta_value)
                     VALUES (?, '_woocommerce_persistent_cart_1', 'a:0:{}')
                     ON DUPLICATE KEY UPDATE meta_value = 'a:0:{}'`,
          params: [userId],
        },
      ];

      for (const { sql, params } of queries) {
        const [result] = await this.query(sql, params);
        console.log(`Query affected ${result.affectedRows} rows`);
      }

      // Verify cart is empty
      const [cartVerify] = await this.query(
        `SELECT meta_value FROM wp_usermeta 
             WHERE user_id = ? AND meta_key = '_woocommerce_persistent_cart_1'`,
        [userId]
      );

      if (!cartVerify.length || cartVerify[0].meta_value !== "a:0:{}") {
        throw new Error("Cart verification failed");
      }

      console.log("Cart cleared successfully");
    } catch (error) {
      console.error("Error clearing cart:", error);
      throw error;
    }
  }
}

module.exports = new Database();
