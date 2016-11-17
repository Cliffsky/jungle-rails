class User < ActiveRecord::Base

  has_many :reviews

  has_secure_password
  auto_strip_attributes :email
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    user = self.find_by(email: email)
      if user && user.authenticate(password)
        user
      else
        nil
      end
  end
end
