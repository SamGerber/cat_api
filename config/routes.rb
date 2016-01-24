Rails.application.routes.draw do
  resources :cats do
    resources :toys, only: [:index]
  end

  resources :toys, only: [:create, :show, :update, :destroy]
end
