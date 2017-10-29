Rails.application.routes.draw do

  get 'worktime_aggregates/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :workplaces do
    resources :constructions do
      get 'get_construction'
      get 'consttime'
      get 'consttime_detail'
    end
    post :confirm ,on: :collection
  end

  resources :users,only:[:index,:show]

  resources :attendances do
    get 'detail'
    post :confirm ,on: :collection
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine,at:'/letter_opener'
  end

  authenticated :user do                                                 # Userがログイン中はtopic一覧をtop画面とする設定
    root :to => "workplaces#index", :as => "user_authenticated_root"
  end

  devise_scope :user do                                                  # User非ログイン中はサインアップ画面をtop画面とする設定
    root :to => "users/registrations#new"                                # RegistrationsControllerのnew.html.erbに飛ばしている
  end

end
