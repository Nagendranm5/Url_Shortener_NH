module UrlHelper

	def generate_new_url
		loop do
			@new_url = SecureRandom.hex(4)
			@exist_checking = Url.find_by(generated_url: @new_url)
			if @exist_checking.nil?
				break
			end
		end
		return @new_url
	end

	def convert_valid_url(original_url)
		original_url = original_url
		if !original_url.starts_with?("http")
			original_url = "http://" + original_url + "/"
		end
		return original_url
	end

end
