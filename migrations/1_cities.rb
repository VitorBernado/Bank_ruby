require 'sequel'

Sequel.migration do
    change do
        create_table(:cities) do
            primary_key :id
            String :city, size: 100, null: false, uniq: true
            foreign_key :state_id, :states
        end
    end
end