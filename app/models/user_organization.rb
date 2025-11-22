class UserOrganization < ApplicationRecord
       belongs_to :user 
         belongs_to :organization
            validates :role, presence: true, inclusion: { in: %w[member admin viewer] }
            validates :user_id, presence:true, uniqueness: { scope: :organization_id, message: "is already a member of this organization" }
            enum :role, { member: 'member', admin: 'admin', viewer: 'viewer' }
             

end
