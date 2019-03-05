# == Schema Information
#
# Table name: posts
#
#  id        :bigint(8)        not null, primary key
#  title     :string           not null
#  url       :string
#  content   :text
#  author_id :integer          not null
#

class Post < ApplicationRecord

  validates :title, presence: true 

  

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id, 
    class_name: :User 
  
  has_many :comments
  
  has_many :subposts,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: :PostSub,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :subposts

  def comments_by_parent_id
    comments = self.comments 
    hash = Hash.new {|h,k| h[k] = []}
    comments.each do |comment|
      hash[comment.parent_id] << comment 
    end
    hash
  end
end
