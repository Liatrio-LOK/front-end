  'use strict';
  var {defineSupportCode} = require('cucumber');
  var webdriver = require('selenium-webdriver');
  var assert = require('assert');
  var selenium = "http://" + process.argv[5] + ":30002/wd/hub"


  var driver = new webdriver.Builder().forBrowser('chrome').usingServer(selenium).build();

  defineSupportCode(function({Given, Then, When}) {

    Given(/^I navigate to Sock Shop web page$/, function (callback) {
      driver.get('https://www.google.com/');
      callback();
    });

    When(/^I should see WeaveSocks page title$/, function (callback) {
      console.log("start");
      console.log(driver.getTitle());
      console.log(driver.getCurrentUrl());
      console.log("finish");
      callback();
    });
  });
