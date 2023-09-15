# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :memberships, only: %i[show create] do
      member do
        get :role
      end
    end

    resources :roles, only: %i[index show create]
  end
end
