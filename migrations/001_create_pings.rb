# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:pings) do
      primary_key :id
      String :ip, null: false
      Integer :delay
      DateTime :created_at, null: false
      index %i[ip created_at]
    end
  end
end
