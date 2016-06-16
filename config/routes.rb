Rails.application.routes.draw do
  get 'users/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :works
  #resources :categories
  devise_for :users, :controllers => { :registrations => 'user_registrations' }

  devise_scope :user do
    get 'users/myworks' => 'works#user_works', as: :user_works
    get 'users/register' => 'users#register', as: :user_register

    get 'participant/sign_up' => 'user_registrations#new', :user => { :meta_type => 'participant' }, as: :new_participant
    get 'jury/sign_up' => 'user_registrations#new', :user => { :meta_type => 'jury' }, as: :new_jury
  end

  resources :users, only: :show

  get '/works/:id/rating' => 'works#set_rating', as: :rating
  post '/works/:id/rating' => 'works#set_rating', as: :ratingpost
  get '/cat/:category_id' =>  'works#update_works', as: :fetch_items
  get '/categories/:category_id' => 'categories#show', as: :categories
  get '/top/(:category_id)' => 'works#top', as: :top
  get '/works/:id/detailed_rating' => 'works#detailed_rating', as: :detailed

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # You can have the root of your site routed with "root"
  root 'application#index'
  get 'juries' => 'application#juries', as: :juries_list

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
