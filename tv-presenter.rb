require "watir"
require "webdrivers"

class TvPresenter

	def initialize(duration = 10)
		@duration = duration.to_i
	end

	def present
		slide_paths = get_slide_paths
		start_presentation_with(slide_paths)
	end

	private

	def get_slide_paths
		slides = Dir.glob("slides/*.{jpg,jpeg,png,gif}").map do |file| 
			File.expand_path(file, __dir__)
		end
		slides.compact
	end

	def start_presentation_with(slide_paths)
		raise "No images found in ./slides directory" if slide_paths.empty?

		# Cycle through slides indefinitely
		slide_paths.cycle do |path|
			browser.goto "file://#{path}"
			sleep(@duration)
		end

	end


	def browser
		# Start browser in kiosk mode with no visible UI
		args 	= ["--start-fullscreen", "--kiosk"]
		options = {args: args, "excludeSwitches" => ["enable-automation"]}
		@browser ||= Watir::Browser.new(:chrome, options: options)
	end

end

duration = ARGV[0] || 10
tv 		 = TvPresenter.new(duration)
tv.present
