class DashboardController < ApplicationController
    def index
    @user=current_user
    @organizations=@user.organizations
  # Get all projects from user's organizations
    @projects = Project.joins(:organization)
                      .where(organization_id: @organizations.pluck(:id))
    
    # Get all tasks from user's projects
    @all_tasks = Task.joins(project: :organization)
                    .where(projects: { organization_id: @organizations.pluck(:id) })

    @total_organizations=@organizations.count
    @total_projects=@projects.count
    @total_tasks=@all_tasks.count
    
    # project statistics
    @active_projects = @projects.active.count
    @completed_projects = @projects.completed.count
    
    # Task statistics
    @tasks_not_started = @all_tasks.not_started.count
    @tasks_in_progress = @all_tasks.in_progress.count
    @tasks_completed = @all_tasks.completed.count
    
    # User-specific task statistics
    @my_tasks = @all_tasks.assigned_to(@user)
    @my_tasks_count = @my_tasks.count
    @my_tasks_not_started = @my_tasks.not_started.count
    @my_tasks_in_progress = @my_tasks.in_progress.count
    @my_tasks_completed = @my_tasks.completed.count
    
    # Overdue and upcoming tasks
    @overdue_tasks = @all_tasks.overdue
    @due_today_tasks = @all_tasks.due_today
    @due_this_week_tasks = @all_tasks.due_this_week
    
    # Recent activity
    @recent_tasks = @all_tasks.recent(10)
    @recent_projects = @projects.recent(5)
    
    # Priority breakdown
    @high_priority_tasks = @all_tasks.where(priority: 'high').not_completed.count
    @medium_priority_tasks = @all_tasks.where(priority: 'medium').not_completed.count
    @low_priority_tasks = @all_tasks.where(priority: 'low').not_completed.count
    end
end
