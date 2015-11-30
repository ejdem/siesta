class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  validates  :user_id,    presence: true
  #validates  :subject_id, presence: true
  validates  :content,    presence: true
  
  def find_author(micropost)
    User.find(micropost.user_id)
  end
  
  def author_name(micropost)
    u = User.find(micropost.user_id)
    u.name    
  end
end
