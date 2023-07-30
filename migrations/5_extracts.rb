require 'sequel'

Sequel.migration do
    change do
        create_table(:extracts) do
            primary_key :id
            foreign_key :account_id, :accounts
            String :type, null: false
            Float :value, null: false
            String :origin
            String :destiny
            DateTime :create_at, default: Sequel::CURRENT_TIMESTAMP
        end
    end
end