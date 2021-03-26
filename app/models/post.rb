class Post < ApplicationRecord
	belongs_to :user
	belongs_to  :parent, class_name: 'Post', optional: true
	has_many    :comments, class_name: 'Post', foreign_key: :parent_post_id, dependent: :destroy

	STATUSES = %w[draft published deleted]
	before_validation :default_values
	
	def default_values
    	self.status ||= 'draft'
 	end

	validates :status, inclusion: STATUSES
end
