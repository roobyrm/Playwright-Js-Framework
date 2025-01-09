const { faker } = require("@faker-js/faker");

class BookingFactory {
  static createBooking({
    firstName = faker.person.firstName(),
    lastName = faker.person.lastName(),
    totalPrice = faker.number.int({ min: 100, max: 1000 }),
    depositPaid = faker.datatype.boolean(),
    checkIn = "2024-01-01",
    checkOut = "2024-01-10",
    additionalNeeds = faker.lorem.sentence(),
  } = {}) {
    return {
      firstname: firstName,
      lastname: lastName,
      totalprice: totalPrice,
      depositpaid: depositPaid,
      bookingdates: {
        checkin: checkIn,
        checkout: checkOut,
      },
      additionalneeds: additionalNeeds,
    };
  }
}

module.exports = BookingFactory;
