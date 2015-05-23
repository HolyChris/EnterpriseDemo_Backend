Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :home, only: :index
      resources :users, only: :index
      put :sign_in, to: 'sessions#create'
      delete :sign_out, to: 'sessions#destroy'
      resources :sites, only: [:index, :create, :update, :show] do
        resources :assets, only: [:index, :create, :update, :show]
        resources :documents, only: [:index, :create, :update, :show]
        resources :images, only: [:index, :create, :update, :show]
        resources :contracts, only: [:show, :create, :update]
        resources :projects, only: [:show, :create, :update]
      end
      resources :customers, only: [:index, :create, :update]
      resources :appointments, only: [:index, :create, :update]
    end
  end

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

    unauthenticated do
      # Role.pluck(:name).each do |role|
      [:admin, :office_staff, :sales_rep].each do |role|
        get "/#{role}", to: 'sessions#new', type: "#{role}"
        get "/#{role}/sign_in", to: 'sessions#new', type: "#{role}", as: "new_#{role}_session"
        post "/#{role}/sign_in", to: "sessions#create", type: "#{role}", as: "#{role}_session"
      end
    end
  end

  root to: 'roles#home_page'
  get '*unmatched_route', to: redirect('/')
end
