Rails.application.routes.draw do

  get 'landing/index'
  root "landing#index"
  resources :messages, only: [:new, :create]
   
  #------chart ---------
  namespace :admin do
    resources :users do
      collection do
        get 'chart'
      end
    end
  end
  #---sidekiq------
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  #-------active admin----------
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #-----ckeditor--------
  mount Ckeditor::Engine => '/ckeditor'

  #----------currency/convertor--------
  get 'currency/convertor'

#----------jwt---------
  resources :users
  get "verify_otp", to: "users#verify_otp"
  get "generate_qr_code", to: "users#generate_qr_code"

  get '/auth/login', to: 'authentication#new'
  post '/auth/login', to: 'authentication#create'

#----------forget password---------
  post 'passwords/forgot', to: 'passwords#forgot'
  get 'passwords/new', to: 'passwords#new'
  post 'passwords/reset', to: 'passwords#reset'

  
  #------language routes----------------
  resources :lang
  get "/current_language", to: "lang#current_language"
  put "/update_current_language", to: "lang#update_current_language"


  #-------spend analysis routes-----------

  resources :spend do
    collection do
      get :recent_spends
      get :transactions
    end
  end

  #--------chatgpt---------
  post '/chatbot', to: 'chatbot#chat'
  #-------logodesign-------
  resources :logodesign
end
