module UrlHelper

	def generate_new_url
		return SecureRandom.hex(4)
		loop do
			@new_url = SecureRandom.hex(4)
			@exist_checking = Url.find_by(generated_url: @new_url)
			if @exist_checking.nil?
				break
			end
		end
	end

end
