class MiscellaneousController < ApplicationController
  include Commons::Authentication::AuthenticateByJWT
  # always include your handlers first in order to preserve last priority
  # https://stackoverflow.com/a/9121054/3287738
  include DefaultHandling
  include Commons::Errors::DefaultHandling

  before_action :authorize_jwt!

  def application_parameters
    render json: [{}]
  end
end
