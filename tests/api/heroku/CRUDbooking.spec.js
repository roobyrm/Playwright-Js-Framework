const { test, expect } = require("@playwright/test");
const APIHelper = require("../../../api/apiHelper");
const BookingFactory = require("../../../api/bookingFactory");

test.describe("Booking API Tests", () => {
  let apiHelper;
  let token;

  test.beforeAll(async ({ request }) => {
    apiHelper = new APIHelper();
    token = await apiHelper.createToken(request);
  });

  test("Get all bookings", async ({ request }) => {
    const bookings = await apiHelper.getAllBookings(request);
    console.log("\nTotal bookings found:", bookings.length);
    console.log(
      "Sample booking IDs:",
      bookings.slice(0, 3).map((b) => b.bookingid)
    );

    expect(bookings.length).toBeGreaterThan(0);
  });

  test("Get random booking details", async ({ request }) => {
    // Get all bookings first
    const bookings = await apiHelper.getAllBookings(request);
    console.log("\nTotal bookings available:", bookings.length);

    // Get random booking
    const randomBooking = bookings[Math.floor(Math.random() * bookings.length)];
    console.log("Selected random booking ID:", randomBooking.bookingid);

    const bookingDetails = await apiHelper.getBooking(
      request,
      randomBooking.bookingid
    );

    console.log("Retrieved booking details:", {
      firstname: bookingDetails.firstname,
      lastname: bookingDetails.lastname,
      totalprice: bookingDetails.totalprice,
      dates: bookingDetails.bookingdates,
    });

    expect(bookingDetails.firstname).toBeTruthy();
    expect(bookingDetails.lastname).toBeTruthy();
  });

  test("Create new booking", async ({ request }) => {
    // Create booking data
    const bookingData = BookingFactory.createBooking();
    console.log("\nNew booking data to be created:", bookingData);

    // Send create request
    const response = await apiHelper.createBooking(request, bookingData);
    console.log("Created booking response:", {
      bookingId: response.bookingid,
      details: response.booking,
    });

    // Verify response
    expect(response.booking.firstname).toBe(bookingData.firstname);
    expect(response.booking.lastname).toBe(bookingData.lastname);
    expect(response.booking.totalprice).toBe(bookingData.totalprice);
    expect(response.booking.depositpaid).toBe(bookingData.depositpaid);
    expect(response.booking.bookingdates.checkin).toBe(
      bookingData.bookingdates.checkin
    );
    expect(response.booking.bookingdates.checkout).toBe(
      bookingData.bookingdates.checkout
    );
    expect(response.booking.additionalneeds).toBe(bookingData.additionalneeds);
  });

  test("Update booking", async ({ request }) => {
    // Get all bookings and select random one
    const bookings = await apiHelper.getAllBookings(request);
    const randomBooking = bookings[Math.floor(Math.random() * bookings.length)];
    console.log("\nSelected booking ID for update:", randomBooking.bookingid);

    // Get original booking details
    const originalBooking = await apiHelper.getBooking(
      request,
      randomBooking.bookingid
    );
    console.log("Original booking details:", originalBooking);

    // Create new booking data
    const updatedBookingData = BookingFactory.createBooking();
    console.log("New booking data for update:", updatedBookingData);

    // Update booking
    const updatedBooking = await apiHelper.updateBooking(
      request,
      randomBooking.bookingid,
      updatedBookingData,
      token
    );
    console.log("Updated booking response:", updatedBooking);

    // Verify update
    expect(updatedBooking.firstname).toBe(updatedBookingData.firstname);
    expect(updatedBooking.lastname).toBe(updatedBookingData.lastname);
    expect(updatedBooking.totalprice).toBe(updatedBookingData.totalprice);
  });

  test("Delete booking", async ({ request }) => {
    // Get all bookings and select random one
    const bookings = await apiHelper.getAllBookings(request);
    const randomBooking = bookings[Math.floor(Math.random() * bookings.length)];
    console.log("\nSelected booking ID for deletion:", randomBooking.bookingid);

    // Get booking details before deletion
    const bookingDetails = await apiHelper.getBooking(
      request,
      randomBooking.bookingid
    );
    console.log("Booking to be deleted:", bookingDetails);

    // Delete booking
    const statusCode = await apiHelper.deleteBooking(
      request,
      randomBooking.bookingid,
      token
    );
    console.log("Delete operation status code:", statusCode);

    // Verify deletion
    expect(statusCode).toBe(201);

    // Verify booking no longer exists
    const response = await request.get(
      `${apiHelper.baseURL}${apiHelper.basePath}/${randomBooking.bookingid}`
    );
    console.log("Verification request status code:", response.status());
    expect(response.status()).toBe(404);
  });
});
