Rails.application.routes.draw do
  mount Apidocs::Engine => "/apidocs"
  resources :products
end
