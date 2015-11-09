class Student < ActiveRecord::Base
    attr_accessor :remember_token
    before_save { email.downcase! }
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name,  presence: true, length: { maximum: 50  }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    
    def Student.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrpyt::Pasword.create(string, cost: cost)
    end
    
    def Student.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember_token
        self.remember_token = Student.new_token
        update_attribure(:remember_digest, Student.digest(remember_token))
    end
    
    def authenticated?(remember_token)
        BCrpyt::Password.new(remember_digest).is_password?(remember_token)
    end
end
