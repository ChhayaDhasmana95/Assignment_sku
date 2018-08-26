Rails.application.routes.draw do
  devise_for :users
  namespace :devise, :path => "/" do
    #Registrations
    post 'sign_up' => 'registrations#create'
     get 'confirm_email' => 'registration#confirm_email'
    

    #Sessions
    get 'login' => 'sessions#new'
    post 'login'  => 'sessions#create'

    
  end
  resources :skus
  post '/new_csv' => 'skus#new_csv'
  root :to => "devise/registrations#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
