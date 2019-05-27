Amco::Cas::Engine.routes.draw do
  delete "/logout" => "user_sessions#destroy", as: "logout"
end
