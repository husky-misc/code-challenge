json.extract! stat, :id, :player, :kills, :death, :created_at, :updated_at
json.url stat_url(stat, format: :json)
