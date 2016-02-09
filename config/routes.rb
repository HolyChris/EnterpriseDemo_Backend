Rails.application.routes.draw do
  
  post "twilio_tokens" => "twilio_tokens#create"
  get "chat" => "chat#show"


  namespace :api, defaults: { format: 'json' } do

    namespace :v2 do
      jsonapi_resources :sites, only: [:index, :show, :update]
    end

    namespace :v1 do
      namespace :customer_portal do
        resource :customer, only: [:show]
      end

      post 'opportunities' => 'opportunities#create'

      get 'adjustor_portal', to: 'adjustor_portal/adjustors#show'

      resources :home, only: :index
      resources :users, only: :index do
        get 'me' => 'users#show', on: :collection
      end
      put :sign_in, to: 'sessions#create'
      put :users, to: 'registrations#update'
      delete :sign_out, to: 'sessions#destroy'
      post 'users/password', to: 'passwords#create'
      put 'users/password', to: 'passwords#update'
      resources :sites, only: [:index, :create, :update, :show, :destroy] do
        resources :assets, only: [:index, :create, :update, :show, :destroy]
        resources :documents, only: [:index, :create, :update, :show]
        resources :insurance_adjustors, only: [:show, :create, :update]
        resources :images, only: [:index, :create, :update, :show]
        resource :project, only: [:show, :create, :update]
        resources :billings, only: [:create, :update, :show]
        resources :productions, only: [:create, :update, :show]
        resource :contract, only: [:show, :create, :update] do
          post :send_to_customer
          post :send_to_insurance_adjustor
        end
      end
      resources :customers, only: [:index, :create, :update, :show, :destroy]
      resources :appointments, only: [:index, :create, :update, :show, :destroy]
      resource :customer_session, only: [:new, :create, :destroy]
    end
  end

  resources :sites, only: [] do
    resources :assets, only: [:create, :update, :index, :destroy]
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
