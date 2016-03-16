Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: APIConstraints.new(version: 1, default: true) do
      resources :orders, only: %i[index show create]
      resources :products, only: %i[index show create update destroy]
      resources :users, only: %i[show create update destroy]
      resources :sessions, only: %i[create destroy]
    end
  end
end
