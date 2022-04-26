Rails.application.routes.draw do
  namespace :deputy do
    get :index
    post :submit_csv
  end

  root to: "deputy#index"
end
