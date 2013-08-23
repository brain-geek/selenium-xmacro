require "selenium-webdriver"
require 'pry'
require 'pry-nav'

require "xdo/keyboard"
require "xdo/mouse"
require "xdo/xwindow"
require 'headless'

actions = proc do 
	initial_text = "Hello WebDriver!"

	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to "http://google.com"

	puts driver.title
	puts driver.current_url

	element = driver.find_element(:name, 'q')
	element.send_keys initial_text
	element.submit

	sleep 3
	
	win = XDo::XWindow.from_title(/Hello WebDriver!/)
	puts "Window size", win.size
	puts 'Abs position', win.abs_position

	win.resize(960,740)

	puts 'resized'

	puts "Window size", win.size
	puts 'Abs position', win.abs_position

	puts driver.title
	puts driver.current_url

	sleep 3

	#clicking google images link
	XDo::Mouse.move(230, 160, 1)
	XDo::Mouse.click

	sleep 3

	#clicking google input field
	XDo::Mouse.move(420, 205, 1)
	XDo::Mouse.click

	sleep 1

	# deleting text in the search box
	XDo::Keyboard.simulate("{BS}"*initial_text.length)

	XDo::Keyboard.simulate("Hello. I am XDO. Lets do some tests!{NUM_ENTER}")

	sleep 3

	puts driver.title
	puts driver.current_url

	driver.quit
end

if (ENV['HEADLESS'] == 'false')
	actions.call
else
	Headless.ly &actions
end
