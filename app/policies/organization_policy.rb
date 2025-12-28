class OrganizationPolicy < ApplicationPolicy
    def index?
        user.present?
    end
    def show?
        user.present? || user.member_of?(record)
    end
    
    def create?
        user.present?
    end
    
    def new?    
        create?
    end

    def update?
        user.present? && user.admin_of?(record)
    end

    def edit?
        update?
    end 

    def can_create_project?
        return true if record.user_organizations.empty?
        user.present? && (user.admin_of?(record) || user.member_of?(record))
    end
    
    def destroy?
        user.present? && user.admin_of?(record)
    end

    class Scope < ApplicationPolicy::Scope
        def resolve
            if user.present?
            scope.left_joins(:user_organizations)
            .where(
              user_organizations: { user_id: user.id }
            ).or(
              scope.left_joins(:user_organizations)
                  .where(user_organizations: { id: nil })
            ).distinct            else
                scope.none
            end
        end
    end
end