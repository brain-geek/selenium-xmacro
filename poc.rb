require "selenium-webdriver"
require 'pry'
require 'pry-nav'

require "xdo/keyboard"
require "xdo/mouse"
require 'headless'

Headless.ly do 
	initial_text = "Hello WebDriver!"

	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to "http://google.com"

	puts driver.title
	puts driver.current_url

	element = driver.find_element(:name, 'q')
	element.send_keys initial_text
	element.submit

	sleep 3

	puts driver.title
	puts driver.current_url

	sleep 3

	XDo::Mouse.move(280, 270)

	XDo::Mouse.click

	XDo::Keyboard.simulate("{BS}"*initial_text.length)

	XDo::Keyboard.simulate("Hello. I am XDO. Lets do some tests!{NUM_ENTER}")

	sleep 3

	puts driver.title
	puts driver.current_url

	driver.quit
end