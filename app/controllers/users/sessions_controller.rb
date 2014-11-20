# This is an example of how to extend the devise sessions controller
# to support JSON based authentication and issuing a JWT.
class Users::SessionsController < Devise::SessionsController
  # Require our abstraction for encoding/deconding JWT.
  require 'auth_token'

  # Disable CSRF protection
  skip_before_action :verify_authenticity_token

  # Be sure to enable JSON.
  respond_to :html, :json

  # POST /resource/sign_in
  def create

    # This is the default behavior from devise - view the sessions controller source:
    # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb#L16
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    # Here we're deviating from the standard behavior by issuing our JWT
    # to any JS based client.
    token = AuthToken.issue_token({ user_id: resource.id })
    respond_with resource, location: after_sign_in_path_for(resource) do |format|
      format.json { render json: {user: resource.email, token: token} }
    end

    # The default behavior would have been to simply fire respond_with:
    # respond_with resource, location: after_sign_in_path_for(resource)
  end

end
