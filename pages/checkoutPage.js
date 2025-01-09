const { expect } = require("@playwright/test");
const Helpers = require("../utils/helpers");

exports.CheckoutPage = class CheckoutPage {
  constructor(page) {
    this.page = page;
    this.helpers = new Helpers(page);

    // Contact Information
    this.emailField = page.locator("#email");

    // Billing Address
    this.billingFirstName = page.locator("#billing-first_name");
    this.billingLastName = page.locator("#billing-last_name");
    this.billingCompany = page.locator("#billing-company");
    this.billingAddress1 = page.locator("#billing-address_1");
    this.billingAddress2 = page.locator("#billing-address_2");
    this.billingCity = page.locator("#billing-city");
    this.billingState = page.locator("#billing-state");
    this.billingPostcode = page.locator("#billing-postcode");
    this.billingPhone = page.locator("#billing-phone");

    // Shipping Address
    this.shippingFirstName = page.locator("#shipping-first_name");
    this.shippingLastName = page.locator("#shipping-last_name");
    this.shippingCompany = page.locator("#shipping-company");
    this.shippingAddress1 = page.locator("#shipping-address_1");
    this.shippingAddress2 = page.locator("#shipping-address_2");
    this.shippingCity = page.locator("#shipping-city");
    this.shippingState = page.locator("#shipping-state");
    this.shippingPostcode = page.locator("#shipping-postcode");
    this.shippingPhone = page.locator("#shipping-phone");

    // Account
    this.createAccountCheckbox = page.locator("#createaccount");
    this.accountPassword = page.locator("#account_password");

    // Order Options
    this.orderNotesCheckbox = page.locator(".wc-block-checkout__add-note .wc-block-components-checkbox__input");
    this.orderNotesTextarea = page.locator(".wc-block-components-textarea");
    this.useSameAddressCheckbox = page.locator(".wc-block-checkout__use-address-for-billing .wc-block-components-checkbox__input");
    this.countrySelect = page.locator("input#components-form-token-input-0");
    this.placeOrderBtn = page.locator(".wc-block-components-checkout-place-order-button");
    this.orderNumberText = page.locator(".order strong");
    this.orderReceivedText = page.locator("p.woocommerce-notice");
  }

  async goto() {
    await this.page.goto("/checkout/");
    await this.placeOrderBtn.waitFor({ state: "visible", timeout: 10000 });
  }

  async fillCheckoutForm(
    virtualProduct,
    firstName,
    lastName,
    email,
    phone,
    address1,
    city,
    postcode,
    country,
    state
  ) {
    if (virtualProduct) {
      await this.emailField.fill(email);
      await this.billingFirstName.fill(firstName);
      await this.billingLastName.fill(lastName);
      await this.billingPhone.fill(phone);
      await this.billingAddress1.fill(address1);
      await this.billingCity.fill(city);
      await this.countrySelect.fill(country);
      await this.page.keyboard.press("Enter");
      await this.billingState.fill(state);
      await this.page.keyboard.press("Enter");
      await this.billingPostcode.fill(postcode);
    } else {
      await this.emailField.fill(email);
      await this.shippingFirstName.fill(firstName);
      await this.shippingLastName.fill(lastName);
      await this.shippingAddress1.fill(address1);
      await this.shippingCity.fill(city);
      await this.shippingPhone.fill(phone);
      await this.countrySelect.fill(country);
      await this.page.keyboard.press("Enter");
      await this.shippingState.fill(state);
      await this.page.keyboard.press("Enter");
      await this.shippingPostcode.fill(postcode);
      await this.helpers.scrollAndClick(this.useSameAddressCheckbox);
    }

    await this.helpers.scrollAndClick(this.orderNotesCheckbox);
    await this.orderNotesTextarea.fill("Please deliver before 5pm");
  }

  async waitForOrderReceivedMessage() {
    await this.orderReceivedText.waitFor({ state: "visible", timeout: 10000 });
  }

  async getOrderNumber() {
    return await this.orderNumberText.textContent();
  }

  async placeOrder() {
    await this.helpers.scrollAndClick(this.placeOrderBtn);
  }
};