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
			redirect_to "#{@main_url.original_url}", allow_other_host: true
		else
			render 'invalid_url_page'
		end
	end

	def generate_qr_code
		# Url.generate_qr_code2(params[:generated_url])
	end

	private
	def url_params
		params.require(:url).permit(:original_url)
	end
end
