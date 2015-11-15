class Subject < ActiveRecord::Base
    has_many :participations
    has_many :users, :through => :participations
    validates :name,         presence: true, length: { maximum: 50  }
    validates :description,  presence: true, length: { maximum: 250  }
end
