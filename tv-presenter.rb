require "watir"
require "webdrivers"

class TvPresenter

	def initialize(duration = 10)
		@duration = duration.to_i
	end

	def present
		slide_paths = load_slides
		start_browser_with(slide_paths)
	end

	private

	def load_slides
		slides = Dir.glob("slides/*.{jpg,jpeg,png,gif}").map do |file| 
			File.expand_path(file, __dir__)
		end
		slides.compact
	end

	def start_browser_with(slide_paths)
		raise "No images found in ./slides directory" if slide_paths.empty?

		# Open browser in full-screen mode
		browser.driver.manage.window.full_screen

		# Cycle through slides indefinitely
		slide_paths.cycle do |path|
			browser.goto "file://#{path}"
			sleep(@duration)
		end

	end

	def browser
		@browser ||= Watir::Browser.new(:chrome, options: {"excludeSwitches" => ["enable-automation"]})
	end

end

duration = ARGV[0] || 10
tv 		 = TvPresenter.new(duration)
tv.present
