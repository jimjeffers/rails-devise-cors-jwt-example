require 'jwt'

module AuthToken
  def AuthToken.issue_token(payload)
    payload['exp'] = 24.hours.from_now.to_i # Set expiration to 24 hours.
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end
