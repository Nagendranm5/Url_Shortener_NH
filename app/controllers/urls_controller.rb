class UrlsController < ApplicationController
    include UrlHelper

    def index
        @url = Url.new
    end

    def create
        if url_params[:original_url].present?
            generated_url = generate_new_url
            @url = Url.create(original_url: url_params[:original_url], generated_url: generated_url, active: true)
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
        # redirect_to myurl_path(params[:generated_url])
        redirect_to "#{@main_url.original_url}", allow_other_host: true
    end

    private
    def url_params
        params.require(:url).permit(:original_url)
    end
end