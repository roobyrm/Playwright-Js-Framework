const { expect } = require("@playwright/test");
const Helpers = require("../utils/helpers");

exports.MyAccountPage = class MyAccountPage {
  constructor(page) {
    this.helpers = new Helpers(page);
    this.page = page;
    // Locators
    this.inputUsernameField = page.locator("#username");
    this.inputPasswordField = page.locator("#password");
    this.submitButton = page.locator(".woocommerce-form-login__submit");
    this.registerUsernameField = page.locator("#reg_username");
    this.registerEmailField = page.locator("#reg_email");
    this.registerPasswordField = page.locator("#reg_password");
    this.registerButton = page.locator('button[name="register"]');
    this.loginErrorMessage = page.locator(".woocommerce-error");
    this.logoutLink = page.locator(".woocommerce-MyAccount-navigation-link--customer-logout");
    this.contentSection = page.locator(".woocommerce-MyAccount-content");
  }

  async goto() {
    await this.page.goto("/my-account/");
    await this.inputUsernameField.waitFor({ state: "visible", timeout: 5000 });
  }

  async login(username, password) {
    await this.inputUsernameField.fill(username);
    await this.inputPasswordField.fill(password);
    await this.helpers.scrollAndClick(this.submitButton);
  }

  async register(username, email, password) {
    await this.registerUsernameField.fill(username);
    await this.registerEmailField.fill(email);
    await this.registerPasswordField.fill(password);
    await this.registerButton.waitFor({ state: "visible", timeout: 5000 });
    await this.helpers.jsClickElement(this.registerButton);
  }

  async checkUserIsOnMyAccountLoginPage() {
    await this.inputUsernameField.waitFor({ state: "visible", timeout: 5000 });
  }

  async waitForLoginError() {
    await this.loginErrorMessage.waitFor({ state: "visible", timeout: 5000 });
  }

  async getLoginErrorText() {
    return await this.loginErrorMessage.textContent();
  }

  async waitForLogoutButton() {
    await this.logoutLink.waitFor({ state: "visible", timeout: 10000 });
  }

  async getContentText() {
    await this.contentSection.waitFor({ state: "visible" });
    return await this.contentSection.textContent();
  }

  async clickLogoutButton() {
    await this.helpers.scrollAndClick(this.logoutLink);
  }
};