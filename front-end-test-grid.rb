require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for(
    :remote,
    url: 'http://selenium-hub:4444/wd/hub',
    desired_capabilities: :firefox)
end

def teardown
    @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get 'http://the-internet.herokuapp.com'
  expect(@driver.title).to eq('The Internet')
end
