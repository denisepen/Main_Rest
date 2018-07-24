class User < ApplicationRecord
  has_secure_password
  has_many :trips
  has_many :reviews

  before_save :named

    validates_uniqueness_of :email
    validates :email, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i }
    validates_presence_of :first_name, :last_name, :email, :password
    validates :first_name, :last_name,  length: { minimum: 3 }
    validates :password,  length: { in: 6..20 }

    def named
      if self.first_name
        "#{self.first_name.titleize} #{self.last_name.titleize}"
      else
        self.name
      end
    end


    private

    # def make_title_case
    #   if self.name
    #   self.name = self.name.titleize
    # else
    #   self.name =self.first_name.titleize
    # end

  end
