class Helpers {
  constructor(page) {
    this.page = page;
  }

  async jsClickElement(locator) {
    const element = await locator;
    await this.page.evaluate((el) => {
      el.scrollIntoView(true);
      el.click();
    }, await element.elementHandle());
  }

  async scrollAndClick(locator) {
    await locator.scrollIntoViewIfNeeded();
    await locator.click();
  }
}

module.exports = Helpers;
