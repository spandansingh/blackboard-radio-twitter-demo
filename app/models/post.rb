class Post < ApplicationRecord
	mount_uploader :link, VideoUploader
	belongs_to :user
	belongs_to  :parent, class_name: 'Post', optional: true
	has_many    :comments, class_name: 'Post', foreign_key: :parent_post_id, dependent: :destroy
	has_many :likes, class_name: 'Like', foreign_key:'post_id', dependent: :destroy

	STATUSES = %w[draft published deleted]
	before_validation :default_values
	
	def default_values
    	self.status ||= 'draft'
 	end

	validates :status, inclusion: STATUSES

	def is_liked?(user_id)
	    self.likes.each do |like|
	      return true if like.user_id.to_i == user_id
	    end
	    return false
 	end

 	def liked_id(user_id)
	    self.likes.each do |like|
	      return like.id if like.user_id.to_i == user_id
	    end
	    return false
 	end
end
