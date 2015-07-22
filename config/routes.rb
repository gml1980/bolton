Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  namespace :forum do
    resources :forum_categories, :forums, :forum_posts, :forum_replies
  end
end
