Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home", as: :home
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "about", to: "pages#about", as: :about
  # get "sign_out", to: "/users/sign_out"
  # Defines the root path route ("/")
  # root "posts#index"

  #projects
  resources :projects, only: [:index, :show, :new, :destroy, :create]

  # benefits
  get "benefits/new", to: "benefits#new", as: :benefits
  post "benefits", to: "benefits#create", as: :selected_benefits

  # spaces
  get "spaces/new", to: "spaces#new", as: :spaces
  post "spaces", to: "spaces#create", as: :selected_spaces
end
