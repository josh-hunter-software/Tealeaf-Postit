class User < ActiveRecord::Base
  include Sluggable
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    account_sid = 'AC36a7e547c9e4ea2bfd568d1e3cf972ed' 
    auth_token = 'cbef0eb6911fc999e8dea60760450d60' 
 
    # set up a client to talk to the Twilio REST API 
    
    client = Twilio::REST::Client.new account_sid, auth_token 
    
    
    msg = "Hi, please input this pin to continue login: #{self.pin}"
    account = client.account
    message = account.sms.messages.create({:from => '+14692919122', :to => '2145790365', :body => msg})
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
end