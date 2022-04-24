Rails.application.routes.draw do
  namespace :deputy do
    post :submit_csv
  end
end
