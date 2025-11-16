class UserOrganization < ApplicationRecord
       belongs_to :user 
         belongs_to :organization
            validates :role, presence: true, inclusion: { in: %w[member admin owner] }
            validates :user_id, uniqueness: { scope: :organization_id, message: "is already a member of this organization" }
            enum :role, { member: 'member', admin: 'admin', owner: 'owner' }
             

end
