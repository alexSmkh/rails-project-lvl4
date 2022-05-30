# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :web do
    get 'repositories/index'
    get 'repositories/create'
    get 'repositories/show'
  end
  scope module: 'web' do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    get 'sessions/new', as: 'new_session'
    delete 'sessions', to: 'sessions#destroy', as: 'session'

    resources :repositories, only: %i[index new create show] do
      resources :checks, only: %i[create], module: 'repositories'
    end

    root 'welcome#index'
  end
end
