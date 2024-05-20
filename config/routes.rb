Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "dogs#index"
  post 'fetch_dog_image', to: 'dogs#fetch_dog_image'
end
