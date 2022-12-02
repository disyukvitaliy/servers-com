Sequel.migration do
  change do
    create_table(:pings) do
      primary_key :id
      String :ip, null: false
      Integer :delay
      DateTime :created_at, null: false
      index [:ip, :created_at]
    end
  end
end
