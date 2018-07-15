class User < ApplicationRecord
  has_secure_password
  has_many :trips
  has_many :reviews

    # validates_uniqueness_of :email
    # validates_presence_of :first_name, :last_name, :email, :password_confirmation
    # validates :first_name, :last_name,  length: { minimum: 3 }
    # validates :password,  length: { in: 6..20 }

    def named
      if self.first_name
        "#{self.first_name} #{self.last_name}"
      else
        self.name
      end
    end

  end
