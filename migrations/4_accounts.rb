require 'sequel'

Sequel.migration do
    change do
        create_table(:accounts) do
            primary_key :id
            foreign_key :customer_id, :customers, null: false
            String :number, size: 8, null: false, uniq: true
            Float :balance, default: 0
            Float :overdraft, default: 0
            DateTime :create_at, default: Sequel::CURRENT_TIMESTAMP
            DateTime :active_check
        end
    end
end