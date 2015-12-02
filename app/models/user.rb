class User < ActiveRecord::Base
    has_many :active_participations,  class_name:  "Participation",
                                      foreign_key: "user_id",
                                      dependent:   :destroy
    has_many :participated_subjects, through:     :active_participations,
                                     source:      :participated_subject
    has_many :notes
    has_many :microposts, dependent: :destroy
    has_many :received_messages, class_name:  "Message",
                                 foreign_key: "receiver_id"
    has_many :sended_messages,   class_name:  "Message",
                                 foreign_key: "sender_id"
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save   :downcase_email
    after_save    :check_if_tutor
    before_create :create_activation_digest
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name,  presence: true, length: { maximum: 50  }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    def listing_notes
        @notes = notes.all
        @subject_ids = []
        @notes.each do |n|
            @subject_ids << n.subject_id
        end
        @subject_ids.uniq!
    end
    
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
    
    def participating?(s_id)
        #active_participations.include?(subject)
        active_participations.find_by(subject_id: s_id).nil?
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
