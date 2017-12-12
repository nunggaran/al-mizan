Rails.application.routes.draw do
  
  
  
  
  # namespace :api do
  # 	namespace :v1 do
  # 		resources :price
  # 		# get '/price/insert', to: 'price#insert'
  # 		# put '/profilesV2/update/:id', to: 'profiles_v2#update'
  # 	end
  # end

  scope '(:locale)', locale: /en|id|sa/  do 
    devise_for :users, :path => "alumni", controllers: {
      :sessions           => 'users/sessions',
      :registrations      => 'users/registrations',
      # :omniauth_callbacks => "users/omniauth_callbacks" ,
      :invitations        => 'users/invitations'
    }
    resources :articles
    devise_scope :user do
      delete 'logout', to: 'devise/sessions#destroy'
      get 'resetpassword', to: 'users/passwords#new'
      # get 'signup', to: 'devise/registrations#new'
      # get 'login', to: 'devise/sessions#new'
    end
    # resources :contacts
    post 'contacts' => 'contacts#create'
    get 'sejarah-al-mizan', to: 'pages#sejarah', as: :sejarah
    get 'visi-misi-al-mizan', to: 'pages#visi', as: :visi_misi
    get 'fasilitas-al-mizan', to: 'pages#facility', as: :facility
    get 'hubungi-kami', to: 'pages#contact_us', as: :contact
    get 'ekstrakurikuler', to: 'pages#ekskul', as: :ekskul
    	# mount Monologue::Engine, at: '/blog', :as => :blog	
	  root 'pages#index'
	  
  end
end
