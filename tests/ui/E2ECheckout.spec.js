const { test, expect } = require("@playwright/test");
const { HomePage } = require("../../pages/homepage");
const { CartPage } = require("../../pages/cartPage");
const { CheckoutPage } = require("../../pages/checkoutPage");
const { faker } = require("@faker-js/faker");
const { MyAccountPage } = require("../../pages/myAccountPage");
const database = require("../../utils/Database");

test.describe("E2E Checkout Flow", () => {
  let homepage;
  let cartPage;
  let checkoutPage;
  let myAccountPage;

  // Test data
  const testData = {
    isRegisteredUser: true,
    username: process.env.TEST_USER,
    password: process.env.TEST_PASSWORD,
    registeredEmail: process.env.TEST_EMAIL,
    country: "United Kingdom",
    postcode: "SW1A 1AA",
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    email: faker.internet.email(),
    phone: "+447822031221",
    address: faker.location.streetAddress(),
    city: "London",
    state: faker.location.state(),
    couponCode: "friends100", // Replace with your actual coupon code
  };

  test.beforeAll(async ({ browser }) => {
    const context = await browser.newContext();
    const page = await context.newPage();
    homepage = new HomePage(page);
    cartPage = new CartPage(page);
    checkoutPage = new CheckoutPage(page);
    myAccountPage = new MyAccountPage(page);
  });

  test.afterEach(async ({ page }) => {
    console.log("Cleaning up test data...");

    await page.context().clearCookies();

    if (testData.isRegisteredUser) {
      await database.connect();
      console.log("Connected to database");

      // Get user ID
      const [user] = await database.query(
        `SELECT ID FROM wp_users WHERE user_login = ?`,
        [testData.username]
      );

      if (user.length > 0) {
        const userId = user[0].ID;

        // This now handles all session clearing internally
        await database.clearCart(userId);

        // Clear user meta - removed session deletion since it's handled in clearCart
        await database.query(
          `DELETE FROM wp_usermeta WHERE user_id = ? AND meta_key = 'session_tokens'`,
          [userId]
        );
      }

      // Clear all transients
      await database.query(
        `DELETE FROM wp_options 
             WHERE option_name LIKE '%_transient%' 
             OR option_name LIKE '%wc_fragments_%'`
      );

      await database.disconnect();
    }

    await homepage.goto();
    await page.reload();
    await page.waitForTimeout(1000);
  });

  test("WooCommerce registered user checkout flow", async () => {
    // Login first
    await myAccountPage.goto();
    await myAccountPage.login(testData.username, testData.password);
    await myAccountPage.waitForLogoutButton();

    // Shop and cart
    await homepage.goto();
    await homepage.clickRandomAddToCartButton();
    await homepage.waitForCartHeaderCount(1);
    await homepage.clickCartHeader();

    // Apply coupon in cart
    await cartPage.waitForCartItemsCount(1);
    await cartPage.applyCoupon(testData.couponCode);
    await cartPage.checkDiscountCodeApplied(testData.couponCode);

    // Shipping selection if physical product
    const isVirtual = await cartPage.checkProductDescriptionContainsVirtual(0);
    if (!isVirtual) {
      await cartPage.clickFreeShippingRadio();
    }
    await cartPage.clickProceedToCheckout();

    // Registered users only need to confirm pre-filled info
    await checkoutPage.placeOrder();
    await checkoutPage.waitForOrderReceivedMessage();

    // Verify order in database
    const orderNumber = await checkoutPage.getOrderNumber();
    await database.connect();

    // Check order details
    const [orders] = await database.query(
      `SELECT * FROM wp_wc_orders 
         WHERE id = ? 
         AND customer_id = (
            SELECT ID FROM wp_users 
            WHERE user_login = ?)`,
      [orderNumber, testData.username]
    );

    expect(orders.length).toBe(1);
    expect(orders[0].billing_email).toBe(testData.registeredEmail);

    await database.disconnect();
  });

  test("Complete checkout as guest user", async () => {
    testData.isRegisteredUser = false;
    // Start from homepage
    await homepage.goto();

    // Add product to cart
    await homepage.clickRandomAddToCartButton();
    await homepage.waitForCartHeaderCount(1);
    await homepage.clickCartHeader();

    // Cart page actions
    await cartPage.waitForCartItemsCount(1);
    await cartPage.applyCoupon(testData.couponCode);
    await cartPage.checkDiscountCodeApplied(testData.couponCode);

    // Check if product is virtual and proceed accordingly
    const isVirtual = await cartPage.checkProductDescriptionContainsVirtual(0);

    if (!isVirtual) {
      await cartPage.clickFreeShippingRadio();
    }
    await cartPage.clickProceedToCheckout();

    // Checkout page actions
    await checkoutPage.fillCheckoutForm(
      isVirtual,
      testData.firstName,
      testData.lastName,
      testData.email,
      testData.phone,
      testData.address,
      testData.city,
      testData.postcode,
      testData.country,
      testData.state
    );

    // Place order and verify
    await checkoutPage.placeOrder();
    await checkoutPage.waitForOrderReceivedMessage();

    // Get order number (if needed for verification)
    const orderNumber = await checkoutPage.getOrderNumber();
    expect(orderNumber).toBeTruthy();
    await database.connect();
    const [rows] = await database.query(
      `SELECT * FROM wp_wc_orders WHERE id = ?`,
      [orderNumber]
    );
    const billingEmail = rows[0].billing_email;
    expect(billingEmail).toBe(testData.email);
    await database.disconnect();
  });
});
