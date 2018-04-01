Rails.application.routes.draw do
  require 'resque/server'

  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :sensors do
    resources :data, only: %i(index), module: 'sensors'
  end
  resources :actuators
  resources :control_loops do
    resource :reference, only: %i(show create), module: 'control_loops'
    resources :data, only: %i(index), module: 'control_loops'
    resources :reference_trackings, only: %i(index create destroy), module: 'control_loops'
  end

  root to: "sensors#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  authenticate :user do
    mount Resque::Server, at: '/jobs'
  end
end
