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

  describe 'test title' do
    it 'should show WeaveSocks title' do
        puts @driver.title
      assert @driver.title == 'WeaveSocks'
    end
  end
  describe 'test title' do
    it 'should not show Google as the title' do
      assert @driver.title == 'Google'
    end
  end
end
