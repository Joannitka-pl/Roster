Rails.application.routes.draw do
  resources :shifts, except: :show
end
