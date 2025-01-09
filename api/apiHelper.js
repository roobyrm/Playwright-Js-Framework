const { expect } = require("@playwright/test");

class APIHelper {
  constructor(baseURL) {
    this.baseURL = baseURL || "https://restful-booker.herokuapp.com";
    this.basePath = "/booking";
  }

  async createToken(request) {
    const response = await request.post(`${this.baseURL}/auth`, {
      data: {
        username: process.env.API_USERNAME,
        password: process.env.API_PASSWORD,
      },
    });

    const body = await response.json();
    return body.token;
  }

  async getAllBookings(request) {
    const response = await request.get(`${this.baseURL}${this.basePath}`);
    expect(response.ok()).toBeTruthy();
    return await response.json();
  }

  async getBooking(request, bookingId) {
    const response = await request.get(
      `${this.baseURL}${this.basePath}/${bookingId}`
    );
    expect(response.ok()).toBeTruthy();
    return await response.json();
  }

  async createBooking(request, bookingData) {
    const response = await request.post(`${this.baseURL}${this.basePath}`, {
      data: bookingData,
    });
    expect(response.ok()).toBeTruthy();
    return await response.json();
  }

  async updateBooking(request, bookingId, bookingData, token) {
    const response = await request.put(
      `${this.baseURL}${this.basePath}/${bookingId}`,
      {
        headers: {
          Cookie: `token=${token}`,
        },
        data: bookingData,
      }
    );
    expect(response.ok()).toBeTruthy();
    return await response.json();
  }

  async deleteBooking(request, bookingId, token) {
    const response = await request.delete(
      `${this.baseURL}${this.basePath}/${bookingId}`,
      {
        headers: {
          Cookie: `token=${token}`,
        },
      }
    );
    return response.status();
  }
}

module.exports = APIHelper;
