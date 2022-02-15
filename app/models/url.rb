class Url < ApplicationRecord
	has_one_attached :qrcodepng
	after_create :generate_qr_code3
	def generate_qr_code3
		# @url = Url.find_by_id(url)
		# @original_url = @url.original_url
		# qrcode = RQRCode::QRCode.new(@original_url)
		# png = qrcode.as_png(
		#   bit_depth: 1,
		#   border_modules: 4,
		#   color_mode: ChunkyPNG::COLOR_GRAYSCALE,
		#   color: "black",
		#   file: nil,
		#   fill: "white",
		#   module_px_size: 6,
		#   resize_exactly_to: false,
		#   resize_gte_to: false,
		#   size: 120
		# )

		# IO.binwrite("tmp/#{@url.generated_url}.png", png.to_s)

		# blob = ActiveStorage::Blob.create_and_upload!(
		# 	io: File.open("tmp/#{@url.generated_url}.png"),
		# 	filename: (@url.generated_url),
		# 	content_type: 'png',
		# )

		# qrcodepng.attach(blob)
		downloaded_image = open("tmp/9403b25c.png")
    self.qrcodepng.attach(io: downloaded_image  , filename: "foo.jpg")

		# redirect_back fallback_location: root_path
	end


end
