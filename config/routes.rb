Apidocs::Engine.routes.draw do
  root "apidocs#index"
  get '/flush' => 'apidocs#flush' ,as: :flush
end
