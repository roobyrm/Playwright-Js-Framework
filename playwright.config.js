// @ts-check
const { defineConfig, devices } = require("@playwright/test");
require("dotenv").config();

const RPconfig = {
  apiKey:
    "wdio_oLuoAuHiT9O3vTjVXVVvwAABaFc7y1a8KjFOq1N8gEiexEfv0kebxFbhZNl27_FM",
  endpoint: "http://localhost:8080/api/v2",
  project: "WebdriverIO_automation_framework",
  launch: "Test launch",
  attributes: [
    {
      key: "key",
      value: "value",
    },
    {
      value: "value",
    },
  ],
  description: "Playwright-js automation tests",
};

/**
 * Read environment variables from file.
 * https://playwright.dev/docs/test-configuration
 */
const config = {
  /* Test directory and execution settings */
  testDir: "./tests",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  workers: process.env.CI ? 1 : undefined,
  retries: process.env.CI ? 2 : 0,

  /* Test timeout settings */
  timeout: 30000,
  expect: {
    timeout: 5000,
  },

  /* Reporter configuration */
  reporter: [
    ["html", { outputFolder: "playwright-report", open: "never" }],
    ["line"],
    ["@reportportal/agent-js-playwright", RPconfig],
  ],

  /* Global test settings */
  use: {
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
    video: "retain-on-failure",
  },

  /* Configure projects for different environments */
  projects: [
    /* UI Testing - Chrome */
    {
      name: "ui-chrome",
      testMatch: /.*\.spec\.js/,
      testDir: "./tests/ui/",
      use: {
        ...devices["Desktop Chrome"],
        channel: "chrome",
        headless: true,
        viewport: { width: 1920, height: 1080 },
        ignoreHTTPSErrors: true,
        baseURL: process.env.UI_BASE_URL || "http://localhost:8000",
        launchOptions: {
          args: ["--start-maximized"],
        },
        screenshot: "only-on-failure",
        trace: "retain-on-failure",
        video: "retain-on-failure",
      },
      reporter: [["html", { outputFolder: "playwright-report/ui" }], ["line"]],
    },

    /* API Testing - HerokuApp Environment */
    {
      name: "api-heroku",
      testMatch: /.*\.spec\.js/,
      testDir: "./tests/api/heroku",
      use: {
        baseURL:
          process.env.HEROKU_API_BASE_URL ||
          "https://restful-booker.herokuapp.com",
        extraHTTPHeaders: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      },
      reporter: [["html", { outputFolder: "playwright-report/api" }], ["line"]],
    },
  ],

  /* Folder for test artifacts */
  outputDir: "test-results/",

  /* Web server configuration for local testing */
  webServer: process.env.CI
    ? undefined
    : {
        command: "npm run start",
        url: process.env.UI_BASE_URL || "http://localhost:8000",
        reuseExistingServer: true,
        timeout: 120 * 1000,
      },
};

module.exports = defineConfig(config);
