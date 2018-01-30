"user strict";
var webdriver = require("selenium-webdriver"),
driver = new webdriver.Builder().
  usingServer('http://selenium-hub:4444/').
  withCapabilities({'browserName': 'firefox'}).
  build();
