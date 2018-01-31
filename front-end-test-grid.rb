#require 'headless'
require 'selenium-webdriver'
require 'minitest/autorun'

describe 'Sock-Shop' do
  before do
    #@headless = Headless.new
    #@headless.start

    @driver = Selenium::WebDriver.for(
      :remote,
      url: 'http://standalone-firefox:4444/wd/hub',
      desired_capabilities: :firefox) # look into desired_capabilities. browserName?
    @driver.navigate.to 'http://front-end:8079'
    #@driver.manage.timeouts.implicit_wait = 30
  end

  after do
    #@headless.destroy
    @driver.quit
  end

  describe 'when homepage is available' do
    it 'should show correct page title' do
      assert @driver.title == 'WeaveSocks'
    end
  end
end
