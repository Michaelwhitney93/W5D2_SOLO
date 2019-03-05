# == Schema Information
#
# Table name: subs
#
#  id          :bigint(8)        not null, primary key
#  title       :string           not null
#  description :string           not null
#  moderator   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, presence: true 
  


  belongs_to :user_moderator,
    foreign_key: :moderator,
    primary_key: :id,
    class_name: :User 
  
  has_many :subposts,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: :PostSub,
    dependent: :destroy,
    inverse_of: :sub
    
  has_many :posts,
    through: :subposts 
end 
