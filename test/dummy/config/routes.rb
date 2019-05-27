Rails.application.routes.draw do
  mount Amco::Cas::Engine => "/amco-cas"
end
