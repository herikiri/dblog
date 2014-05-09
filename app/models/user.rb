class User < ActiveRecord::Base
	#before_create :build_default_blog

	TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  #validates_format_of :name, with: /^[a-z0-9_]+$/, multiline: true, message: "must be lowercase alphanumerics only"
	validates_length_of :name, maximum: 32, message: "exceeds maximum of 32 characters"
	validates_exclusion_of :name, in: ['www', 'mail', 'ftp'], message: "is not available"

	has_one :blog, dependent: :destroy
	has_one :picture, as: :imageable
  has_many :comments

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    if user.nil?

      # Get the existing user from email if the OAuth provider gives us an email
      user = User.where(:email => auth.info.email).first if auth.info.email

      # Create the user if it is a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: auth.info.email.blank? ? TEMP_EMAIL : auth.info.email,
          password: Devise.friendly_token[0,20]
        )
        #user.skip_confirmation!
        user.save!
      end

      # Associate the identity with the user if not already
      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end

  private
  	def build_default_blog
  		build_blog(attributes = {
  			name: self.name.capitalize + "'s Blog"
  			} )
  		true
  	end
end
