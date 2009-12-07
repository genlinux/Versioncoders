ActionController::Routing::Routes.draw do |map|
 #Since we want this action to be available only to members of the newsletter resource, we
 #declare it with the parameter :member. If we wanted to declare an action that was available to a
 #collection of newsletter resources as a whole, we would use the parameter :collection.

  map.resources :newsletters ,:member => {:sendmails => :put}

  map.resources :photos
  
  map.resources :tags
  
  map.resources :comments
  
  #map.resources :entries
  #map.resources :posts
  #map.resources :topics
  #map.resources :forums
  #For more info in nested routes
  
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
    end
  end
  
  #map.resources :forums,:has_many=>:topics
  # forum.resources :topics,:has_many=>[ :posts ]
  #end
  
  map.resources :categories,:collection=>{:admin=>:get} do |categories|
    categories.resources :articles,:name_prefix=>'category_'
  end
  
  map.resources :articles,:collection=>{:admin=>:get}
  
  #map.resources :roles
  
  map.resources :users, :member=>{:enable=>:put} do |users|
    users.resources :roles
    users.resources :entries ,:has_many=>[ :comments ]
    users.resources :tags, :name_prefix => 'user_',:controller => 'user_tags'

    users.resources :photos, :name_prefix => 'user_',:member => { :add_tag =>:put,:remove_tag => :delete }

    users.resources :friends
  end
  
  map.resources :pages
  map.resources :blogs
  
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
  # map.root :controller => "welcome"
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.index '/',:controller=>'pages',:action => 'show', :id => '1-welcome-page'
  map.show_user '/user/:username',:controller=>'users',:action=>'show_by_username'
  map.resources :users, :member=>{:enable=>:put}
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
