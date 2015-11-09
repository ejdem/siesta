class User < ActiveRecord::Base
    attr_accessor :remember_token, :activation_token
    before_save { email.downcase! }
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name,  presence: true, length: { maximum: 50  }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrpyt::Pasword.create(string, cost: cost)
    end
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribure(:remember_digest, User.digest(remember_token))
    end
    
    def authenticated?(remember_token)
        BCrpyt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    private
    
    def downcase_email
        self.email = email.downcase
    end
end
