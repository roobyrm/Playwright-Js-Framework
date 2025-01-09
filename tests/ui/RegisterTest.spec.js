const { test, expect } = require("@playwright/test");
const { HomePage } = require("../../pages/homepage");
const { MyAccountPage } = require("../../pages/myAccountPage");
const faker = require("@faker-js/faker").faker;

const username = faker.internet.username();
const email = faker.internet.email();
const password = faker.internet.password();

// Configure browser context to be reused
// Use describe.serial to run tests in sequence
test.describe.serial("User Registration and logout tests", () => {
  let homepage;
  let myAccountPage;

  // Setup shared context
  test.beforeAll(async ({ browser }) => {
    const context = await browser.newContext();
    const page = await context.newPage();
    homepage = new HomePage(page);
    myAccountPage = new MyAccountPage(page);
  });

  test("Test Register User", async () => {
    await myAccountPage.goto();
    await myAccountPage.register(username, email, password);
    await myAccountPage.waitForLogoutButton();
    await expect(await myAccountPage.getContentText()).toContain(username);
  });

  test("Test Logout User", async () => {
    await myAccountPage.clickLogoutButton();
    await myAccountPage.checkUserIsOnMyAccountLoginPage();
  });

  test("Should not login with invalid credentials", async () => {
    const invalidUsername = faker.internet.username();
    const invalidPassword = faker.internet.password();

    await myAccountPage.goto();
    await myAccountPage.login(invalidUsername, invalidPassword);
    await myAccountPage.waitForLoginError();

    const errorText = await myAccountPage.getLoginErrorText();
    await expect(errorText).toContain(
      `Error: The username ${invalidUsername} is not registered on this site. If you are unsure of your username, try your email address instead.`
    );
  });
});
