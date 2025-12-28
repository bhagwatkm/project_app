module TasksHelper
    def sortable_header_link(column, title = nil)
    title ||= column.titleize
    current_direction = params[:direction] == "asc" ? "desc" : "asc"
    sort_params = request.params.merge(sort: column, direction: current_direction)
    
    result = link_to(title, sort_params, class: "hover:underline")
    if params[:sort] == column.to_s
      result += params[:direction] == "asc" ? " ▲" : " ▼"
    end
    result
  end
end
