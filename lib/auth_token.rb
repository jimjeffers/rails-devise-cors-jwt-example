require 'jwt'

module AuthToken
  def AuthToken.issue_token(payload)
    # Set expiration to 24 hours.
    JWT.encode(payload, Rails.application.secrets.secret_key_base, claims: { exp: 86400 })
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end
