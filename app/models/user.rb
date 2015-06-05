class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook, 'google-oauth2']


  has_many :authentications, :dependent => :destroy

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def update_with_password(params, *options)
    update_attributes(params, *options)
  end


end
