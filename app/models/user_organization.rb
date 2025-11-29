class UserOrganization < ApplicationRecord
       belongs_to :user 
         belongs_to :organization
            validates :role, presence: true, inclusion: { in: %w[member admin viewer] }
            validates :user_id, uniqueness: { scope: :organization_id, message: "is already a member of this organization" }
            enum :role, { member: 'member', admin: 'admin', viewer: 'viewer' }
             
  after_create -> { Rails.logger.info("Congratulations, the callback has run!") }
  around_save :log_saving

  before_validation :set_default_role, on: :create
  before_destroy :prevent_last_admin_removal
  after_create :log_membership_addition
  after_update :log_role_change, if: :saved_change_to_role?
  after_destroy :log_membership_removal

  private
  def log_saving
    Rails.logger.info("Starting to save UserOrganization...")
    yield
    Rails.logger.info("Finished saving UserOrganization.")
  end 

  def set_default_role
    self.role ||= 'member'
  end

  def prevent_last_admin_removal
    if role == 'admin'
      if organization.user_organizations.admin.count <= 1
        errors.add(:base, "Cannot remove the last admin from the organization")
        throw(:abort)
      end
    end
  end

  def log_membership_addition
    Rails.logger.info("User #{user_id} added to Organization #{organization_id} with role #{role}")
  end

  def log_role_change
    old_role, new_role = saved_change_to_role
    Rails.logger.info("User #{user_id} role changed from #{old_role} to #{new_role} in Organization #{organization_id}")  
  end 
  def log_membership_removal  
    Rails.logger.info("User #{user_id} removed from Organization #{organization_id}")
  end   


end
