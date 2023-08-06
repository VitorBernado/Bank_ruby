module Lists

    def list_states
        states = States.where(:id).all

        puts 'Nenhum estado encontrado.' if states.empty?

        states.each do |state|
            puts "ID: #{state[:id]}, Estado: #{state[:state].capitalize}, UF: #{state[:uf].upcase}"
        end
    end

    def list_cities
        cities = States.join(:cities, state_id: :id).all

        puts 'Nenhum cidade encontrado.' if cities.empty?

        cities.each do |city|
            puts "ID: #{city[:id]}, Cidade: #{city[:city].capitalize}, Estado: #{city[:state].capitalize}, UF: #{city[:uf].upcase}"
        end
    end
end