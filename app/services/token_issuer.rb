# frozen_string_literal: true

require 'json_web_token'

class TokenIssuer
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  def user
    user = Admin.find_by(email: @email)
    return user if user&.authenticate(@password)
    nil
  end
end
