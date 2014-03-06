class User < ActiveRecord::Base
  def to_s
    username
  end
end
