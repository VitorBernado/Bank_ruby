require 'sequel'

Sequel.migration do
    change do
        create_table(:states) do
            primary_key :id
            String :state, size: 100, null: false, uniq: true
            String :uf, size: 2, null: false, uniq: true
        end
    end
end