Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get :home, to: "home#index"

  scope :user do
    get :sign_in, to: "user#sign_in"
    post :sign_in_user, to: "user#sign_in_user"
    get :sign_up, to: "user#sign_up"
    post :create_user, to: "user#create_user"
  end

  scope :product do
    get :create, to: "product#create"
    post :create, to: "product#create_product"
    get "edit/:product_id", to: "product#edit"
    put :edit, to: "product#edit_product"
    delete :delete, to: "product#delete_product"
  end
end
