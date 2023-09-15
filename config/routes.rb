# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :memberships, only: %i[show create] do
      member do
        get :role
      end
    end

    resources :roles, only: %i[index show create] do
      member do
        get :memberships
      end
    end
  end
end
