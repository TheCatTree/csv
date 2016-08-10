Rails.application.routes.draw do
    #api
  namespace :api do
    namespace :v1 do
      resources :error_logs, :variables, only: [:index,:show,:update]
      resources :pairs, :events, only: [:index, :show]
      resources :datab, only: [:show, :create] do
        member do
          get 'variable'
          get 'event'
          get 'errorlogname'
          get 'variablename'
          get 'eventname'
        end
      end
    end
  end

  get 'password_ressets/new'

  get 'password_ressets/edit'

  get 'sessions/new'

  get 'users/new'
  
  get '/download', to: 'user_files#download'

  # The priority is based upon order of creation: first created -> highest priority.
  get '/error_logs/:id', to: 'error_logs#show', as: 'errorlog' 
  
  # See how all your routes lay out with "rake routes".
  resources :user_files do
     post 'tocsv', on: :collection
     post 'todata', on: :collection
  end
  # You can have the root of your site routed with "root"
 root 'static_pages#home'
 resources :users
 resources :account_activations, only: [:edit]
 resources :password_resets,     only: [:new, :create, :edit, :update]
  get  '/signup',    to: 'users#new'
  post '/signup',    to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  mount_ember_app :frontend, to: "/ember", controller: "ember", action: "bootstrap"
  
  #Catch every thing else and send to ember
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
