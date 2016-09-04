Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # filter :locale

  root 'index#index'
  get 'index' => 'index#index'
  get 'index/:id' => 'index#show'
  get 'about' => 'index#about'
  get 'concerts/roio_details/:id' => 'concerts#roio_details'
  get 'roios' => 'roios#index'
  get 'roios/:id' => 'roios#show'
  get 'bands' => 'bands#index'
  get 'bands/:id' => 'bands#show'
  get 'countries' => 'countries#index'
  get 'countries/:id' => 'countries#show'
  get 'venues' => 'venues#index'
  get 'venues/:id' => 'venues#show'
  get 'review/:id' => 'review#testui_comments'
  get 'testui' => 'testui#index'
  get 'testui/:id' => 'testui#show'
  get 'suggest' => 'suggest#index'
  get 'bibliography/new' => 'bibliography#new'
  get 'bibliography' => 'bibliography#index'
  get 'bibliography/:id' => 'bibliography#show'

  get '/login' => 'login#index'
  get 'login/logout' => 'login#logout'
  get 'login/login' => 'login#login'
  get 'login/check_cookies' => 'login#check_cookies'
  get 'login/show_cookies' => 'login#show_cookies'

  #admin type functions
  get 'albums' => 'albums#index'
  get 'users/change_language/:id' => 'users#change_language'

  resources :concerts
  resources :concert
  resources :venues
  resources :venue_name
  resources :bibliography
  resources :albums
  resources :bands
  resources :tours
  resources :users
  resources :members
  resources :language
  resources :years


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
