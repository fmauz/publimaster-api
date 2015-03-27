Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', format: :json

	resources :clients
  resources :street_suffixes
  resources :client_types
  resources :segments
  resources :employees
  resources :states, only: [:index]
  resources :cities, only: [:index]
  resources :jornals
  resources :diario_oficials
  resources :materials
  resources :retrancas
	resources :publicacaos
	resources :roles, only: [:index]
end
