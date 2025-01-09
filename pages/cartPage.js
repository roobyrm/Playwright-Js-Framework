const { expect } = require("@playwright/test");
const Helpers = require("../utils/helpers");

exports.CartPage = class CartPage {
  constructor(page) {
    this.page = page;
    this.helpers = new Helpers(page);
    // Locators
    this.cartItemsRows = page.locator(".wc-block-cart-items__row");
    this.discountCodeText = page.locator(".wc-block-components-chip__text");
    this.addCouponBtn = page.locator(".wc-block-components-totals-coupon-link");
    this.couponInput = page.locator(
      "#wc-block-components-totals-coupon__input-0"
    );
    this.applyCouponBtn = page.locator(
      ".wc-block-components-totals-coupon__button"
    );
    this.checkoutBtn = page.locator(
      ".wp-block-woocommerce-cart .wc-block-cart__submit-button"
    );
    this.freeShippingRadio = page.locator("#radio-control-0-free_shipping\\:4");
    this.productDescriptions = page.locator(
      ".wc-block-components-product-metadata__description"
    );
  }

  async goto() {
    await this.page.goto("/cart/");
    await this.cartItemsRows
      .first()
      .waitFor({ state: "visible", timeout: 5000 });
  }

  async waitForCartItemsCount(count) {
    await expect(this.cartItemsRows).toHaveCount(count, { timeout: 5000 });
  }

  async applyCoupon(coupon) {
    await this.helpers.scrollAndClick(this.addCouponBtn);
    await this.couponInput.fill(coupon);
    await this.helpers.scrollAndClick(this.applyCouponBtn);
  }

  async waitForCartPageToLoad() {
    await this.addCouponBtn.waitFor({ state: "visible", timeout: 5000 });
  }

  async clickProceedToCheckout() {
    await this.page
      .getByRole("link", { name: "Proceed to Checkout" })
      .first()
      .click();
  }

  async checkDiscountCodeApplied(coupon) {
    await expect(this.discountCodeText).toHaveText(coupon, { timeout: 5000 });
  }

  async clickFreeShippingRadio() {
    await this.helpers.scrollAndClick(this.freeShippingRadio);
  }

  async checkProductDescriptionContainsVirtual(index) {
    const descriptions = await this.productDescriptions.all();
    if (index < descriptions.length) {
      const text = await descriptions[index].textContent();
      return text.includes("virtual");
    }
    return false;
  }
};
