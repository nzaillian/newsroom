class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable

  before_create :generate_api_key

  validate :only_one

  def email_required?
    false
  end

  def password_required?
    persisted?
  end

  def self.instance
    @instance ||= (User.first || User.create!)
  end  

  private

  def only_one
    if (User.count > 0 && User.all.pluck(:id) != [id])
      self.errors[:base] << "Attempt to create second user account"
    end
  end

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end