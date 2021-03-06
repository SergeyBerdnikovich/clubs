Clubs::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root :to => 'static_pages#welcome'

  devise_for :users
  ActiveAdmin.routes(self)

  resources :static_pages, :only => [:show]
  resources :videos
  resources :users, :only => [:show]
  resources :galleries
  resources :articles
  resources :comments
  resources :categories, :only => [:show]
  resources :roles, :only => []
  resources :categorizations, :only => [:create, :destroy]
  resources :articles_categories, :only => [:destroy]

end
