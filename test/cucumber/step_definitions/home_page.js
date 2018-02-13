var {Then, When} = require('cucumber');
var assert = require('assert');
var fs = require('fs');
var mzFs = require('mz/fs')
var seleniumWebdriver = require('selenium-webdriver');


When(/^I navigate to Sock Shop web page/, function (callback) {
           callback(null, 'pending');
});

Then(/I should see WeaveSocks page title/, function (callback) {
           callback(null, 'pending');
});