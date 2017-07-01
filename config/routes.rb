Rails.application.routes.draw do
  root 'main#index'
  get '/api' => 'main#api'
end
