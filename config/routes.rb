require "subdomain"

DailyTip::Application.routes.draw do
  get "subscriptions/index"

  resources :tips do
    collection do
      get "tagged/:tag" => "tips#tagged", as: "tagged"
      get "category/:category" => "tips#categorized", as: "category"
      get "popular" => "tips#popular", as: "popular"
    end

    resources :votes, only: :create
  end

  resource :user, except: :all do
    resources :subscriptions, except: [:new, :show, :edit]
  end

  get "readability/:id" => "readability#show"

  devise_for :users

  root to: "tips#home"

end
