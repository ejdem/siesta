class User < ActiveRecord::Base
    
    has_many :active_participations,  class_name:  "Participation",
                                      foreign_key: "user_id",
                                      dependent:   :destroy
    has_many :participated_subjects, through:     :active_participations,
                                     source:      :participated_subject
    
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save   :downcase_email
    after_save   :check_if_tutor
    before_create :create_activation_digest
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
        BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    def activate
        update_attribute(:activated,    true)
        update_attribute(:activated_at, Time.zone.now)
    end
    
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end
    
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end
    
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    def check_if_tutor
        if  email.split('@').last == "polsl.pl"
            update_column(:tutor, true)
        else
            update_column(:tutor, false)
        end
    end
    
    def participate(subject,user)
        active_participations.create(subject_id: subject.id, user_id: user.id)
    end
    
    def unparticipate(subject)
        active_participations.find_by(subject_id: subject.id).destroy
    end
    
    def participating?(subject)
        active_participations.each do |particip|
            if particip.subject_id == subject.id
                return true
            end
        end
    end  
    
    private
    

    
    def downcase_email
        self.email = email.downcase
    end
    
    def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
    end

end
