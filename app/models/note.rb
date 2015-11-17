class Note < ActiveRecord::Base
    belongs_to :user
    belongs_to :subjects
    validates :user_id, presence: true
end
