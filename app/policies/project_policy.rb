class ProjectPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? 
  end

def new?    
      create?
end

def create?
  user.present? && (
    user.admin_of?(record.organization) ||
    user.member_of?(record.organization)
  )
end


def edit?
        update?
end 

def clone?
  create?
end

def update?
  user.present? && (
    user.admin_of?(record.organization) ||
    user.member_of?(record.organization)
  )
end

def destroy?
  user.present? && user.admin_of?(record.organization)
end

def can_create_task?
  user.present? && (
    user.admin_of?(record.organization) ||
    user.member_of?(record.organization)
  )
end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.present?
        scope.joins(organization: :user_organizations)
             .where(user_organizations: { user_id: user.id })
      else
        scope.none
      end
    end
  end



end