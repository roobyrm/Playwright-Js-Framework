const { expect } = require("@playwright/test");
const Helpers = require("../utils/helpers");

exports.HomePage = class HomePage {
  constructor(page) {
    this.page = page;
    this.helpers = new Helpers(page);
    this.addToCartButtons = page.locator(".ajax_add_to_cart");
    this.cartHeader = page.locator("#site-header-cart");
    this.cartHeaderCount = page.locator("#site-header-cart .count");
  }

  // Actions
  async waitForCartHeaderCount(expectedItemCount) {
    const expectedText = expectedItemCount === 1 ? "1 item" : `${expectedItemCount} items`;
    await this.cartHeaderCount.waitFor();
    await expect(this.cartHeaderCount).toHaveText(expectedText, { timeout: 5000 });
  }

  async clickAddToCartButton(index) {
    const buttons = await this.addToCartButtons();
    const count = await buttons.count();
    if (count > index) {
      await this.helpers.scrollAndClick(buttons.nth(index));
    } else {
      console.log("Index is out of bounds of the buttons array. Please check the index value.");
    }
  }

  async clickRandomAddToCartButton() {
    const count = await this.addToCartButtons.count();
    const index = Math.floor(Math.random() * count);
    await this.helpers.scrollAndClick(this.addToCartButtons.nth(index));
  }

  async clickCartHeader() {
    await this.helpers.scrollAndClick(this.cartHeader);
  }

  async goto() {
    await this.page.goto("/");
  }
};