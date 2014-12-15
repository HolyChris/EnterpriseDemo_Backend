Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }
  devise_scope :user do
    get 'users/sign_out', to: 'sessions#destroy'
    authenticated :user do
      ActiveAdmin.routes(self)
    end

    unauthenticated do
      Role.pluck(:name).each do |role|
        get "/#{role}", to: 'sessions#new', type: "#{role}"
        get "/#{role}/sign_in", to: 'sessions#new', type: "#{role}", as: "new_#{role}_session"
        post "/#{role}/sign_in", to: "sessions#create", type: "#{role}", as: "#{role}_session"
      end
    end
  end

  root to: 'roles#home_page'
  get '*unmatched_route', to: redirect('/')
end
