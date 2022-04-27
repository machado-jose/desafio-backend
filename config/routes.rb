Rails.application.routes.draw do
  namespace :deputy do
    get :index
    post :submit_csv
    get :rank
    get :details
  end

  root to: "deputy#index"
end
