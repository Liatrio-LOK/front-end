"user strict";
var webdriver = require("selenium-webdriver"),
driver = new webdriver.Builder().
  usingServer(/* service address here */).
  withCapabilities({'browserName': 'firefox'}).
  build();
