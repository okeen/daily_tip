require "subdomain"

DailyTip::Application.routes.draw do
  get "subscriptions/index"

  constraints Subdomain do
    resources :categorized_tips, path: "tips" do
      collection do
        get "tagged/:tag" => "categorized_tips#tagged", as: "tagged"
        get "category/:category" => "categorized_tips#categorized", as: "category"
        get "popular" => "categorized_tips#popular", as: "popular"
      end

    end
    root to: "categorized_tips#index"
  end

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
