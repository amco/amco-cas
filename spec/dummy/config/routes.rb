Rails.application.routes.draw do
  mount Amco::Cas::Engine, at: 'amco_cas'
end
