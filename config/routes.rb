Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  get 'welcome/index'
  get 'my_roster', to: 'rosters#index'

end
