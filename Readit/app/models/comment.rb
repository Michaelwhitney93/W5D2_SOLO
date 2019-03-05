# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :string           not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,   
    class_name: :User 

  belongs_to :post

  belongs_to :parent_comment,
    foreign_key: :parent_id,
    primary_key: :id,   
    class_name: :Comment,
    optional: true 

  has_many :child_comments,
    foreign_key: :parent_id,
    primary_key: :id,   
    class_name: :Comment 
end
