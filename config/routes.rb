Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    root :to => "homes#top"
    resources :customers, only: [:index,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :orders, only: [:show,:update] 
    resources :order_items, only: [:update]
  end
  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    resources :customers, only: [:show,:edit,:update]
    get "check" => "customers#check"
    patch "withdrawal" => "customers#withdrawal"
    resources :items, only: [:index,:show]
    resources :cart_items, only: [:index,:update,:destroy,:create]
    delete "destroy_all" => "cart_items#destroy_all"
    post "/orders/confirm" => "orders#confirm"
    get "/orders/complete" => "orders#complete"
    resources :orders, only: [:new,:show,:index, :create]
    resources :shipping_addresses, only: [:index,:edit,:update,:create,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
