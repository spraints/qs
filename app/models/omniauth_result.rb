class OmniauthResult
  def initialize(options)
    @auth = options.fetch(:omniauth)
  end

  # Public: The user associated with the omniauth auth hash.
  def user
    @user ||=
      User.where(:provider => @auth.provider, :username => @auth.info.email).first_or_initialize.tap do |user|
        user.uid = @auth.uid
        user.enabled = false
        user.save!
      end
  end
end
