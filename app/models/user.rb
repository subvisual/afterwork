relative_require 'status_update'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]
  has_many :attendees
  has_many :availabilities, dependent: :destroy

  validates :name, presence: true

  acts_as_taggable_on :interests

  accepts_nested_attributes_for :availabilities

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.image = auth.info.image
    end
  end

  def email_required?
    super && provider.blank?
  end

  def self.user_name(user_id)
    User.find(user_id).name
  end

  def self.image_profile(user_id)
    User.find(user_id).image
  end

end
