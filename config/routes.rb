Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'
  get 'home/index'

  root 'welcome#index'
end
