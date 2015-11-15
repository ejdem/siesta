class Subject < ActiveRecord::Base
    validates :name,         presence: true, length: { maximum: 50  }
    validates :description,  presence: true, length: { maximum: 250  }
end
