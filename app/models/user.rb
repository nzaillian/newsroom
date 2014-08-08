class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable

  validate :only_one

  def email_required?
    false
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
end