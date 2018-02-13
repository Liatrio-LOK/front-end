require 'selenium-webdriver'
require 'minitest/autorun'

describe 'Sock-Shop' do
  before do
    @driver = Selenium::WebDriver.for(
        :remote,
        url: "http://#{ARGV[0]}:30002/wd/hub",
        desired_capabilities: :chrome)
    @driver.navigate.to "http://#{ARGV[0]}:#{ARGV[1]}"
  end

  after do
    @driver.quit
  end

  describe 'test title' do
    it 'should show WeaveSocks title' do
      assert @driver.title == 'WeaveSocks'
    end
  end

end
