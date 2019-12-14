Rails.application.routes.draw do
  # ==================================
  # Miscellaneous
  #   - GET   misc/application_parameters
  # ==================================
  resource :misc, only: [], controller: :miscellaneous do
    get :application_parameters
  end
end
