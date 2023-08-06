class Cities < Sequel::Model
    include Lists
    plugin :validation_helpers

    one_to_many :customers
    many_to_one :states

    def validate
        super
        validates_presence %i[city]
        validates_unique :city
        validates_max_length 100, :city
    end

    def add
        print 'Informe a Cidade: '
        city = gets.chomp.to_s.downcase

        list_states
        puts '-'
        print 'Informe o UF com o ID: '
        id_state = gets.chomp.to_s.downcase

        if Cities.where(city: city, state_id: id_state).empty?
            Cities.create(city: city, state_id: id_state)
            puts 'Cidade cadrastrado com secesso!'
        else 
            puts 'Cidade já está cadrastrado.'
        end
    rescue Sequel::ValidationFailed
        puts "Cidade ou Estado está inválido."
    end


    def delete
        list_cities

        puts '-'
        print 'Escolha o Estado que deseja excluir: '
        city_delete = gets.chomp.to_i

        if !Cities.where(id: city_delete).empty?
            Cities.where(id: city_delete).delete
            puts 'Cidade excluido com sucesso.'
        else
            puts 'ID informado não existe no sistema.'
        end
    end
end