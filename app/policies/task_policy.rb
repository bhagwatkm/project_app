class TaskPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && (
      user.admin_of?(record.project.organization) ||
      user.member_of?(record.project.organization) ||
      user.viewer_of?(record.project.organization)
    )
  end

  def create?
    # binding.pry
    # user.present? && (record.is_a?(Class)  && user
    user.present? && (
      user.admin_of?(record.project.organization) ||
      user.member_of?(record.project.organization)
    )
  end

  def new?
    create?
  end

  def update?
    user.present? && (
      user.admin_of?(record.project.organization) ||
      user.member_of?(record.project.organization)
    )
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.admin_of?(record.project.organization)
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
        scope.joins(project: { organization: :user_organizations })
             .where(user_organizations: { user_id: user.id })
             .where(user_organizations: { role: ['admin', 'member', 'viewer'] })
             .distinct
      else
        scope.none
      end
    end
  end
end