require 'test_helper'

class OmniauthResultTest < ActiveSupport::TestCase
  def test_user_exists
    existing_user = FactoryGirl.create :user, provider: "google", username: "spraints@gmail.com"
    user = make_result.user
    assert_equal existing_user, user
    assert_equal "spraints@gmail.com", user.username
    refute user.changed?
  end

  def test_user_does_not_exist
    user = make_result.user
    assert user.persisted?
    assert_equal "google", user.provider
    assert_equal uid, user.uid
    refute user.enabled
    assert_equal "spraints@gmail.com", user.username
    refute user.changed?
  end

  private

  def make_result
    OmniauthResult.new(omniauth: auth_hash)
  end

  def auth_hash
    OmniAuth::AuthHash.new({
      "provider"=>"google",
      "uid"=>uid,
      "info"=>{
        "name"=>"Matt Burke",
        "email"=>"spraints@gmail.com",
        "first_name"=>"Matt",
        "last_name"=>"Burke",
        "image"=> "https://lh4.googleusercontent.com/-3KxHFJXGatM/AAAAAAAAAAI/AAAAAAAAA90/et5mPDKK-3Y/photo.jpg?sz=50",
        "urls"=>{"Google"=>"https://plus.google.com/116644164965850406883"},
      },
      "credentials"=>{
        "token"=> token,
        "expires_at"=>1419695790,
        "expires"=>true,
      },
      "extra"=>{
        "id_token"=>id_token,
        "raw_info"=>{
          "kind"=>"plus#personOpenIdConnect",
          "gender"=>"male",
          "sub"=>"116644164965850406883",
          "name"=>"Matt Burke",
          "given_name"=>"Matt",
          "family_name"=>"Burke",
          "profile"=>"https://plus.google.com/116644164965850406883",
          "picture"=> "https://lh4.googleusercontent.com/-3KxHFJXGatM/AAAAAAAAAAI/AAAAAAAAA90/et5mPDKK-3Y/photo.jpg?sz=50",
          "email"=>"spraints@gmail.com",
          "email_verified"=>"true",
          "locale"=>"en",
        },
      },
    })
  end

  def uid
    "116644164965850406883"
  end

  def id_token
    "todo" # shouldn't need this. It's a huge, signed string.
  end

  def token
    "todo" # shouldn't need this either. It's shorter, but I'm not going to put my real token in.
  end
end
