Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :home, only: :index
      resources :users, only: :index
      put :sign_in, to: 'sessions#create'
      delete :sign_out, to: 'sessions#destroy'
      resources :sites, only: [:index, :create, :update] do
        resources :contracts, only: [:show, :create, :update]
        resources :projects, only: [:show, :create, :update]
      end
      resources :customers, only: [:index, :create, :update]
      resources :appointments, only: [:index, :create, :update]
    end
  end

  devise_for :users, controllers: { sessions: 'sessions', registrations: "registrations" }

  devise_scope :user do
    get 'users/sign_out', to: 'sessions#destroy'
    authenticated :user do
      ActiveAdmin.routes(self) if !ARGV.grep(/assets:precompile/).any? && !ARGV.grep(/db:migrate/).any?
    end

    unauthenticated do
      # Role.pluck(:name).each do |role|
      [:admin, :office_staff].each do |role|
        get "/#{role}", to: 'sessions#new', type: "#{role}"
        get "/#{role}/sign_in", to: 'sessions#new', type: "#{role}", as: "new_#{role}_session"
        post "/#{role}/sign_in", to: "sessions#create", type: "#{role}", as: "#{role}_session"
      end
    end
  end

  namespace :admin do
    resources :sites do
      get :photos
    end
  end

  root to: 'roles#home_page'
  get '*unmatched_route', to: redirect('/')
end
