class Message < ActiveRecord::Base
  belongs_to :sender, class_name:   "User"
  belongs_to :receiver, class_name: "User"
  default_scope -> { order(created_at: :desc) }
end
