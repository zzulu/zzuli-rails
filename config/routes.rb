Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root to: 'urls#new'

  # devise_for :users
  
  resources :urls, only:[:new, :create]

  get ':shortened', to: 'urls#redirect', as: :redirect
  # get ':shortened/p', to: 'urls#preview', as: :preview
  # get ':shortened/s', to: 'urls#statistic', as: :statistic
end
