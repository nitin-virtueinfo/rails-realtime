ProjectApp::Application.routes.draw do
  # Here namespace admin belongs to super admin role
  namespace :admin do
    resources :users, :settings, :footer_pages, :contacts, :languages, :email_templates, :schools
    get '/updateschool/:id' => 'schools#updateschool', :as => :updateschool
  end

  resources :user_sessions

  get 'logout' => 'user_sessions#destroy', :as => :logout
  get 'login' => 'user_sessions#new', :as => :login
  match 'signup(/:registration_key)' => 'user_sessions#signup', :as => :signup, via: [:get, :post, :patch]

  match '/forgot_password' => 'fronts#forgot_password', :as => :forgot_password, via: [:get, :post]
  match '/change_password' => 'fronts#change_password', :as => :change_password, via: [:get, :post, :patch]
  get 'dashboard' => 'fronts#dashboard', :as => :dashboard
  match 'activate/:activation_key' => 'fronts#user_activation', :as => :activation_link, via: [:get]
  match '/profile' => 'fronts#profile', :as => :profile, via: [:get, :post, :patch]
  get '/show_search_box/:toggle/:model/:pm' => 'fronts#show_search_box', :as => :show_search_box
  match 'contact_us' => 'fronts#contact_us', :as => :contact_us, via: [:get, :post, :patch]
  get '/other/:page_id' => 'fronts#other', :as => :other

  # user schools
  get '/schools' => 'schools#index', :as => :schools

  # You can have the root of your site routed with "root"
  root 'fronts#dashboard'

end
