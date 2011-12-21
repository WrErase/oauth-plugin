# Dummy implementation
class ClientApplication
  attr_accessor :key

  def self.find_by_key(key)
    ClientApplication.new(key)
  end

  def self.find(which, conditions_hash)
    case conditions_hash[:conditions].keys.first
    when :key
      ClientApplication.new(conditions_hash[:conditions][:key])
    end
  end

  def initialize(key)
    @key = key
  end

  def tokens
    @tokens||=[]
  end

  def secret
    "secret"
  end
end

class OauthToken
  attr_accessor :token
  attr_accessor :authorized_at

  def self.find(which, conditions_hash)
    case conditions_hash[:conditions][:token]
    when "not_authorized", "invalidated"
      nil
    else
      OauthToken.new(conditions_hash[:conditions][:token])
    end
  end

  def initialize(token)
    @token = token
    @authorized_at = Time.now if token == 'valid_token'
  end

  def secret
    "secret"
  end
end

class Oauth2Token < OauthToken ; end
class Oauth2Verifier < OauthToken ; end
class AccessToken < OauthToken ; end
class RequestToken < OauthToken ; end

class OauthNonce
  # Always remember
  def self.remember(nonce,timestamp)
    true
  end
end
