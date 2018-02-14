  'use strict';
  var {defineSupportCode} = require('cucumber');
  var  webdriver = require('selenium-webdriver');
  var assert = require('assert');

  var driver = new webdriver.Builder()
      .forBrowser('chrome')
      .build();

  defineSupportCode(function({Given, Then, When}) {

    Given(/^I navigate to Sock Shop web page$/, function () {
      driver.get('https://www.google.com/');
    });

    When(/^I should see WeaveSocks page title$/, function () {
      driver.findElement(webdriver.By.name('title'));
    });
  });
