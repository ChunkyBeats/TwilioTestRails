class User < ActiveRecord::Base

  validates_presence_of :password, :on => :create
  validates_presence_of :email, format: { with: /\A.+@.+$\Z/}
  validates_uniqueness_of :email
  validates_presence_of :phone_number

  before_create :auth_user
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
      self.role ||= :user
  end



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def auth_user
    authy = Authy::API.register_user(
      email: this.email,
      phone: this.phone_number,
    )
    this.update(authy_id: authy.id)

    Authy::API.request_sms(id: this.authy_id)
  end

end
