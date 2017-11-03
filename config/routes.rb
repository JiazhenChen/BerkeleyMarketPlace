Rails.application.routes.draw do
  
  # root
  root 'application#index'

  # resources
  resources :posts, except: [:destroy]
  resources :users, except: [:destroy]
  resources :sessions, only: [:create, :destroy]
  
  # authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy', as: 'logout'
  
  # superuser
  get '/admin', to: 'users#admin', as: 'admin'
  get '/admin/check_application', to: 'users#admin_check_application', format: 'json'
  get '/admin/check_users', to: 'users#admin_check_users', format: 'json'
  get '/admin/check_posts', to: 'users#admin_check_posts', format: 'json'
  get '/admin/check_subscriptions', to: 'users#admin_check_subscriptions', format: 'json'
  
  # ajax calls
  get "/filter" => 'application#filter', as: 'filter', format: 'js'
  get "/update_form_subcategory" => 'posts#update_form_subcategory', as: 'update_form_subcategory', format: 'js'
  
  get "/user/profile", to:"users#profile"
  get "/user/mypost", to:"users#mypost"

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
