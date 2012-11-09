DailyTip::Application.routes.draw do
  get "subscriptions/index"

  root to: "tips#home"

  resources :tips do
    collection do
      get "tagged/:tag" => "tips#tagged", as: "tagged"
      get "popular" => "tips#popular", as: "popular"
    end

    resources :votes, only: :create
  end

  resource :user, except: :all do
    resources :subscriptions, except: [:new, :show, :edit]
  end

  get "readability/:id" => "readability#show"
  devise_for :users

end
