Rails.application.routes.draw do
  resources :urls
  get 'info/:generated_url', to: 'urls#show', as: 'myurl'
  get '/io/:generated_url', to: 'urls#get_original_url'
  root 'urls#index'
end
