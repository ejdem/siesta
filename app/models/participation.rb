class Participation < ActiveRecord::Base
    belongs_to :participating_user,    class_name: "User"
    belongs_to :participated_subject,  class_name: "Subject"
    validates  :user_id,    presence: true
    validates  :subject_id, presence: true
end
