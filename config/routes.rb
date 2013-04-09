Clubs::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root :to => 'static_pages#welcome'

  devise_for :users
  ActiveAdmin.routes(self)

  resources :static_pages, :only => [:show]
  resources :videos
  resources :galleries
  resources :articles
  resources :comments
  resources :categories, :only => [:show]
  resources :roles, :only => []
  resources :categorizations, :only => [:create]
  resources :articles_categories, :only => [:destroy]

end
