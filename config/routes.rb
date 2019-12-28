Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    # api routes here
  end

  root 'application#index'
  get '/*path', to: 'application#index' 
end
