# Playwright Automation Framework

A comprehensive end-to-end testing framework built with Playwright, featuring UI and API testing capabilities with ReportPortal integration. The framework tests a WordPress site and the Restful-Booker API, providing detailed reporting and analysis capabilities.

## Prerequisitesasd

### Required Software
- Node.js (>= 20.0.0)
- npm (>= 10.0.0)
- Docker Desktop
- Docker Compose

## Installation

1. Clone the repository:
```bash
git clone https://github.com/cristian-robert/playwright-js.git
cd playwright-automation
```

2. Install dependencies:
```bash
npm install
```

3. Install Playwright browsers:
```bash
npx playwright install
```

## Environment Setup

### Docker Services Setup

The framework runs several interconnected services:

1. Start the Docker containers:

```bash
# For Windows/Linux
docker compose up -d

# For macOS
docker compose -f docker-compose-mac.yml up -d
```

This command starts:
- WordPress (Test application) - Available at `http://localhost:8000`
- ReportPortal (Test reporting) - Available at `http://localhost:8080`
- MySQL Database (WordPress data)
- PostgreSQL (ReportPortal data)
- Selenium Grid Hub - Available at `http://localhost:4444`
- Chrome and Firefox nodes
- RabbitMQ - Management interface at `http://localhost:15672`

2. Wait for services to initialize (approximately 3-5 minutes)

3. Initialize the database:

```bash
# For Unix-based systems (Linux/macOS)
chmod +x insert_users_db_unix.sh  # Make script executable
./insert_users_db_unix.sh

# For Windows
insert_users_db_windows.bat
```

## Project Structure

```
├── tests/                  # Test files
│   ├── api/               # API tests
│   │   └── heroku/       # Restful-Booker API tests
│   └── ui/               # UI tests
├── pages/                 # Page Object Models
│   ├── homepage.js       # Homepage interactions
│   ├── cartPage.js       # Shopping cart interactions
│   └── checkoutPage.js   # Checkout process
├── api/                   # API helpers and factories
│   ├── apiHelper.js      # API interaction methods
│   └── bookingFactory.js # Test data generation
├── utils/                 # Utility functions
│   ├── helpers.js        # Common helper functions
│   └── Database.js       # Database operations
```

## Running Tests

### Test Execution Commands

```bash
# Run all tests
npm test

# Run only UI tests
npm run test:ui

# Run only API tests
npm run test:api:heroku

# Run tests against local environment
npm run test:local

# Run tests in CI environment
npm run test:ci
```

### Test Configuration

The framework supports multiple configurations defined in `playwright.config.js`:

- UI Tests (Chrome):
  - Viewport: 1920x1080
  - Headless mode enabled
  - Screenshots on failure
  - Trace on failure
  - Video recording on failure

- API Tests:
  - Base URL: https://restful-booker.herokuapp.com
  - JSON request/response format
  - Custom headers support

## Test Reports

### ReportPortal Access
1. Access ReportPortal at `http://localhost:8080`
2. Login credentials:
   - Username: `wdio.user`
   - Password: `Pass1234!`
3. Navigate to "Launches" to view test results
4. Features available:
   - Real-time test execution monitoring
   - Detailed test logs and screenshots
   - Test failure analysis
   - Historical data comparison

### HTML Reports
Located in:
- UI Tests: `playwright-report/ui/index.html`
- API Tests: `playwright-report/api/index.html`

Features:
- Test execution timeline
- Step-by-step test breakdown
- Screenshot captures
- Trace viewer for debugging
- Network request logs

## Troubleshooting

Common issues and solutions:

1. **Docker containers won't start**
   ```bash
   # Check Docker logs
   docker compose logs -f
   
   # Restart containers
   docker compose down
   docker compose up -d
   ```

2. **Database connection issues**
   - Verify MySQL is running: `docker compose ps`
   - Check port availability (3306 Windows/Linux, 3307 macOS)
   - Confirm environment variables in `.env`

3. **Tests fail to start**
   ```bash
   # Clear Playwright browser cache
   npx playwright install --force
   
   # Update dependencies
   npm update
   ```

## Contributing

1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Follow coding standards:
   - Use ESLint configuration
   - Write tests for new features
   - Follow page object pattern for UI tests
   - Document new functions and classes

3. Submit changes:
   ```bash
   git commit -m "Description of changes"
   git push origin feature/your-feature-name
   ```

4. Create a Pull Request with:
   - Clear description of changes
   - Test evidence
   - Related issue numbers

## Support

For technical support:
1. Check troubleshooting guide
2. Review issue tracker
3. Create detailed bug report if needed

## License

This project is licensed under the ISC License - see the LICENSE file for details.
