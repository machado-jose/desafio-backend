Rails.application.routes.draw do
  namespace :deputy do
    get :index
    post :submit_csv
    get :rank
  end

  root to: "deputy#index"
end
