require 'selenium-webdriver'
require 'minitest/autorun'

describe 'Sock-Shop' do
  before do
    @driver = Selenium::WebDriver.for(
        :remote,
        url: 'http://selenium-hub:4444/wd/hub',
        desired_capabilities: :chrome)
    @driver.navigate.to 'http://front-end:8079'
    #@driver.manage.timeouts.implicit_wait = 30
  end

  after do
    @driver.quit
  end

  describe 'test title' do
    it 'should show WeaveSocks title' do
      assert @driver.title == 'WeaveSocks'
    end
  end

  describe 'test title' do
    it 'should not show Google as the title' do
      assert @driver.title == 'Google'
    end
  end
end
