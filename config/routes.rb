Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #----------currency/convertor--------
  get 'currency/convertor'

#----------jwt---------
  resources :users
  get "verify_otp", to: "users#verify_otp"

  post '/auth/login', to: 'authentication#login'
  
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
