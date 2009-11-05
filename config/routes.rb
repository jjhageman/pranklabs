ActionController::Routing::Routes.draw do |map|
  map.resources :invitations

  map.resources :videos

  # map.resources :comments

  map.resources :albums

  map.resources :images
  
  map.resources :categories
  
  map.resources :tags

  map.resources :pranks do |prank|
    prank.resources :comments
    prank.resources :images, :controller => 'prank_images' do |image|
      image.resources :comments
    end
    prank.resources :albums do |album|
      album.resources :images, :controller => 'album_images' do |image|
        image.resources :comments
      end
    end
    prank.resources :videos do |video|
      video.resources :comments
    end
  end
  
  map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete } do |user|
    user.resources :image, :controller => 'user_image'
    user.resources :pranks
    user.resources :video
  end
  
  map.resource :sessions
  
  map.join '/join', :controller => 'invitations', :action => 'join'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.signup '/signup/:invitation_token', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:id', :controller => 'users', :action => 'reset_password'
  map.photos 'prank/:id/photos', :controller => 'photos', :action => 'index'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "pranks"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
