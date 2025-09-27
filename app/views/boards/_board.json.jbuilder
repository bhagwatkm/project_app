json.extract! board, :id, :project_id, :name, :position, :created_at, :updated_at
json.url board_url(board, format: :json)
