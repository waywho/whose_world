Rails.application.routes.draw do
 
	namespace :api do
		namespace :v1 do
		end
	end

	namespace :admin do
		post 'user_token' => 'user_token#create', defaults: {format: :json}
		post 'sign_up', to: 'users#create', defaults: {format: :json}
		resources :users, defaults: {format: :json}, only: [:update, :show, :index, :destroy] do
			resources :tenants
		end

	end
	
	get 'tenants/index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	root 'tenants#index'
	get '/*path', to: 'tenants#index' 
end
