Rails.application.routes.draw do

  resources :workplaces do
    collection do
      post :confirm
    end
  end

end
