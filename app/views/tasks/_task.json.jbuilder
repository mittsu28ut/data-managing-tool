json.extract! task, :id, :name, :details, :priority, :due, :created_at, :updated_at
json.url task_url(task, format: :json)
