Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      get 'bitcoin_price', to: 'bitcoin_price#show'

      get 'transactions/users/:user_id', to: 'transactions#user_transactions'
      get 'transactions', to: 'transactions#index'
      get 'transactions/:id', to: 'transactions#show', as: 'transaction'

      post 'transactions', to: 'transactions#create'
    end
  end

  root to: redirect('/api-docs')
end
