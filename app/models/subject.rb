class Subject < ActiveRecord::Base

    has_many :active_participations, class_name:  "Participation",
                                     foreign_key: "Subject_id",
                                    dependent:   :destroy
    has_many :participating_users,  through:     :active_participations,
                                    source:      :participating_user
    validates :name,         presence: true, length: { maximum: 50  }
    validates :description,  presence: true, length: { maximum: 250  }
end
