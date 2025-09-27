json.extract! list, :id, :board_id, :name, :position, :wip_limit, :created_at, :updated_at
json.url list_url(list, format: :json)
