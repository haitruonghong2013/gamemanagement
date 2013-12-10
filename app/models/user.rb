class User < ActiveRecord::Base
  rolify
  before_save :ensure_authentication_token
  has_one :character
  has_many :scores

  #has_many :clients, :through => :client_notes
  #has_many :meetings
  #has_many :my_clients,:class_name => 'Client', :through => :meetings, :source => :client

  #has_many :owner_clients, :class_name => 'Client', :foreign_key => 'created_by'
  #has_many :owner_users, :class_name => 'User', :foreign_key => 'created_by'
  #has_many :owner_meetings, :class_name => 'Meeting', :foreign_key => 'created_by'
  #has_many :owner_major_logs, :class_name => 'MajorVarianceLog', :foreign_key => 'created_by'

  #has_many :schedules, :foreign_key => 'assigned_id'
  #has_many :own_schedules, :class_name => 'Schedule', :foreign_key => 'created_by'
  #has_many :push_notifications, :dependent => :destroy
  #has_many :client_notes
  #has_many :major_variance_logs,:class_name => 'MajorVarianceLog', :foreign_key => 'created_by'
  #has_one :push_notification
  #belongs_to :organization, :autosave => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable,
         :token_authenticatable,
         :authentication_keys => [:login]


  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessible :login
  # Setup accessible (or protected) attributes for your model
  attr_accessor :current_password
  attr_accessible :role_ids, :current_password
  #accepts_nested_attributes_for :organization
  attr_accessible :first_name,:last_name , :telephone ,:username, :email, :password, :sex,
                  :password_confirmation, :remember_me, :time_zonem, :device_id
  # attr_accessible :title, :body
  #validates :first_name, :presence => {:message => "This field is required."}
  #validates :last_name, :presence => {:message => "This field is required."}
  #validates :telephone, :presence => {:message => "This field is required."}
  #validates :username, :presence => {:message => "This field is required."}
  #validates :email, :presence => {:message => "This field is required."}
  #validates :password, :presence => {:message => "This field is required."}
  #validates :password_confirmation, :presence => {:message => "This field is required."}

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false,:message =>'user name is existing!'}

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      where(conditions).first
    end
  end

  def self.search(search)
    if search  and search.strip != ''
      where('username LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def as_json(options = {})
    {
      :address  => self.address,
      :apn_token => self.apn_token,
      :area_code => self.area_code,
      :avatar => self.avatar,
      :birthday => self.birthday,
      :city => self.city,
      :country => self.country,
      :cover => self.cover,
      :created_date => self.created_date,
      :email => self.email,
      :facebook_id  => self.facebook_id,
      :gcm_token  => self.gcm_token,
      :google_id => self.google_id,
      :language => self.language,
      :name => self.name,
      :note  => self.note,
      :phone  => self.phone,
      :sex   => self.sex,
      :twitter_id  => self.twitter_id,
      :user_type   => self.user_type,
      :avatar_thumb => self.avatar_thumb,
      :ubox_authentication_token => self.ubox_authentication_token,
      :authentication_token => self.authentication_token
    }
  end


### This is the correct method you override with the code above
### def self.find_for_database_authentication(warden_conditions)
### end
end
