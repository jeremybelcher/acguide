class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :city, :provider, :uid, :image
  # attr_accessible :title, :body

def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(name:auth.extra.raw_info.first_name,
                        provider:auth.provider,
                        uid:auth.uid,
                        email:auth.info.email,
                        city:auth.info.location,
                        image:auth.info.image,
                        password:Devise.friendly_token[0,20]
                         )
  end
  user
end

end

