require 'sequel'

Sequel.migration do
    change do
        create_table(:customers) do
            primary_key :id
            foreign_key :city_id, :cities
            String :name, size: 100, null: false
            String :document, size: 15, null: false, uniq: true
            String :public_place, null: false
            Integer :number, size: 10, null: false
            String :neighborhood, null: false
            DateTime :create_at, default: Sequel::CURRENT_TIMESTAMP
        end
    end
end