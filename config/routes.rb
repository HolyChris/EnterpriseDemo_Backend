Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :home, only: :index
      resources :users, only: :index
      put :sign_in, to: 'sessions#create'
      delete :sign_out, to: 'sessions#destroy'
      post 'users/password', to: 'passwords#create'
      put 'users/password', to: 'passwords#update'
      resources :sites, only: [:index, :create, :update, :show] do
        resources :assets, only: [:index, :create, :update, :show]
        resources :documents, only: [:index, :create, :update, :show]
        resources :images, only: [:index, :create, :update, :show]
        resource :contract, only: [:show, :create, :update]
        resource :project, only: [:show, :create, :update]
      end
      resources :customers, only: [:index, :create, :update, :show]
      resources :appointments, only: [:index, :create, :update]
    end
  end

  resources :sites, only: [] do
    resources :assets, only: [:create, :update, :index]
  end

  resources :attachments

  [:admin, :office_staff, :sales_rep].each do |role|
    namespace role do
      resources :sites do
        get :autocomplete_site_customer, on: :collection
      end
    end
  end

  devise_for :users, controllers: { sessions: 'sessions', registrations: "registrations" }

  devise_scope :user do
    get 'users/sign_out', to: 'sessions#destroy'
    authenticated :user do
      ActiveAdmin.routes(self) if !ARGV.grep(/assets:precompile/).any? && !ARGV.grep(/db:migrate/).any? && !ARGV.grep(/db:seed/).any?
    end

    root to: 'sessions#new'
  end

  get '*unmatched_route', to: redirect('/')
end
