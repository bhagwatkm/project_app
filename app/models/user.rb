class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar # Active Storage for avatar upload
has_many :user_organizations
has_many :organizations, through: :user_organizations
has_many :projects, through: :organizations
has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id'

def member_of?(organization)
  return unless organization
  user_organizations.exists?(organization_id: organization.id, role: 'member')
end

def admin_of?(organization)
  return unless organization
  user_organizations.exists?(organization_id: organization.id, role: 'admin') 
end

def viewer_of(organization)
  return unless organization
  user_organizations.exists?(organization_id: organization_id, role: 'viewer')      
end
end
