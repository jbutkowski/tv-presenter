require "watir"
require "webdrivers"
require_relative "lib/graceful-quit"

class TvPresenter

	def initialize(duration = 10)
		@duration = duration.to_i
	end

	def present
		slide_paths = get_slide_paths
		start_presentation_with(slide_paths)
	end

	private

	def week_day_name
		# Return abbreviated weekday name 
		Date.today.strftime("%a")
	end

	def new_day?
		# Compare 'week_day_name' with the same, X seconds ago
		seconds_ago    = @duration * 3
		week_day_name != (Time.now - seconds_ago).strftime("%a")
	end

	def get_slide_paths
		slides = Dir.glob("slides/#{week_day_name}/*.{jpg,jpeg,png,gif}").map do |file| 
			File.expand_path(file, __dir__)
		end
		slides.compact
	end

	def start_presentation_with(slide_paths)
		raise "No images found in ./slides directory" if slide_paths.empty?

		GracefulQuit.enable

		# Cycle through slides indefinitely
		slide_paths.cycle do |path|
			browser.goto "file://#{path}"
			sleep(@duration)
			GracefulQuit.check

			# Break if new day & restart
			break if new_day?
		end

		# Restart
		present
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
