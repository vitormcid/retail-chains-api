class User < ApplicationRecord
	has_secure_password
	has_many :assignments  
	has_many :roles, through: :assignments  
	belongs_to :chain, optional: true

	has_one_attached :featured_image

	validates :name , presence: true
  	validates :username, presence: true, uniqueness: true
  	validates :password,
        length: { minimum: 6 },
        if: -> { new_record? || !password.nil? }

	after_create :add_default_role
	
	def add_default_role
		unless roles.present?
			roles << Role.find_by_name("user")
			self.save
		end
	end

	def role?(role) 
		roles.any? { |r| r.name.underscore.to_sym == role }  
	end  
end
