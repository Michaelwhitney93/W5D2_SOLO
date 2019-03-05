# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint(8)        not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
  validates :post_id, uniqueness: { scope: :sub_id }

  belongs_to :sub, 
    foreign_key: :sub_id,
    primary_key: :id,  
    class_name: :Sub 

  belongs_to :post, 
    foreign_key: :post_id,
    primary_key: :id,   
    class_name: :Post 

  
end
