class User
  attr_reader :name, :email, :uid, :provider

  def initialize(uid, name, email, provider)
    @uid = uid
    @name = name
    @email = email
    @provider = provider
  end
end
