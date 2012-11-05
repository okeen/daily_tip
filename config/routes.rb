DailyTip::Application.routes.draw do
  get "subscriptions/index"

  root to: "tips#index"

  resources :tips
  resource :user, except: :all do
    resources :subscriptions, except: [:new, :show, :edit]
  end

  devise_for :users

end
