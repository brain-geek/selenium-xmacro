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

	sleep 5
	
	win = XDo::XWindow.from_title(/Hello WebDriver!/)
	puts "Window size", win.size
	puts 'Abs position', win.abs_position

	win.move(0, 0) #This move call simply hangs
	win.resize(960,740)

	puts 'resized'

	puts "Window size", win.size
	puts 'Abs position', win.abs_position

	puts driver.title
	puts driver.current_url

	sleep 3

	offset = (ENV['MODE']=='mint') ? 50 : 0

	#clicking google images link
	XDo::Mouse.click(135 + offset, 220)

	sleep 10

	#clicking google input field
	XDo::Mouse.click(225 + offset, 300)

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