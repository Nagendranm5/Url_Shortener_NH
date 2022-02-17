class UrlsController < ApplicationController
	include UrlHelper
	require "rqrcode"

	def index
		@url = Url.new
	end

	def create
		if url_params[:original_url].present?
			generated_url = generate_new_url
			original_url = convert_valid_url(url_params[:original_url])
			@url = Url.create(original_url: original_url, generated_url: generated_url, active: true, qrcode: false)
			if @url.save
			   redirect_to myurl_path(generated_url)
			end
		end
	end

	def show
		@url = Url.find_by(generated_url: params[:generated_url])
	end

	def get_original_url
		@main_url = Url.find_by(generated_url: params[:generated_url])
		if @main_url.present?
			count = @main_url.try(:count).nil? ? 1 : @main_url.try(:count) + 1
			@main_url.update(count: count)
			redirect_to "#{@main_url.original_url}", allow_other_host: true
		else
			render 'invalid_url_page'
		end
	end

	def generate_qr_code
		@url = Url.find_by_id(params[:generated_url])
		@original_url = @url.original_url
		qrcode = RQRCode::QRCode.new(@original_url)
		png = qrcode.as_png(
		  bit_depth: 1,
		  border_modules: 4,
		  color_mode: ChunkyPNG::COLOR_GRAYSCALE,
		  color: "black",
		  file: nil,
		  fill: "white",
		  module_px_size: 6,
		  resize_exactly_to: false,
		  resize_gte_to: false,
		  size: 150
		)

		IO.binwrite("tmp/#{@url.generated_url}.png", png.to_s)

		blob = ActiveStorage::Blob.create_and_upload!(
			io: File.open("tmp/#{@url.generated_url}.png"),
			filename: (@url.generated_url),
			content_type: 'png',
		)

		@url.qrcodepng.attach(blob)
		@url.update(qrcode: true)
		redirect_back fallback_location: root_path
	end

	# def download_qr_code
	# 	@url = Url.find_by_id(params[:generated_url])
	# 	send_file "/home/ubuntu/Projects/url_shortener/tmp/7f4a09c0.png", :type => 'application/png', :x_sendfile => true
	# 	redirect_back fallback_location: root_path
	# end

	private
	def url_params
		params.require(:url).permit(:original_url)
	end
end
