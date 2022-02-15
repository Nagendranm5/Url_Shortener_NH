Rails.application.routes.draw do
  resources :urls
  get 'info/:generated_url', to: 'urls#show', as: 'myurl'
  get '/:generated_url', to: 'urls#get_original_url'
  get '/generate_qr_code/:generated_url', to: 'urls#generate_qr_code', as: 'generate_qr_code'
  root 'urls#index'
end
