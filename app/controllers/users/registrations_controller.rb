class Users::RegistrationsController < Devise::RegistrationsController
  # Disable CSRF protection
  skip_before_action :verify_authenticity_token

  # Be sure to enable JSON.
  respond_to :html, :json
end
