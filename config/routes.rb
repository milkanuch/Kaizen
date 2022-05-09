Rails.application.routes.draw do
  resources :posts
  
  root to:"login#index",as:"login"

  post "/signin",to: "login#signin"
  post "/signup",to: "login#signup"
  post "/signout",to: "login#signout"
  post "/update_user/:id",to: "profile#update_user",as:"update_user"
  post "/follow",to: "main#follow", as:"follow"
  post "/unfollow",to: "main#unfollow", as:"unfollow"

  get "/profile/:id",to: "profile#index", as:"profile"
  get "/edit_profile/",to: "profile#edit", as:"edit"
  get "/messages",to: "messages#index", as:"messages"

  get "/",to: "login#index"
  get "/home",to: "main#index"
end
