class Post < ApplicationRecord
	STATUSES = %w[draft published deleted]
	before_validation :default_values
	
	def default_values
    	self.status ||= 'draft'
 	end

	validates :status, inclusion: STATUSES
end
