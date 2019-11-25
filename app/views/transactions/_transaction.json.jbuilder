json.extract! transaction, :id, :name, :value, :due_date, :block_hash, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
