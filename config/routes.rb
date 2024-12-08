Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/auth/:provider/callback', to: 'sessions#google_auth'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'
  root 'home#index'
  resources :companies do
    resources :employees do
      resources :reimbursement_claims
    end
  end  
end
