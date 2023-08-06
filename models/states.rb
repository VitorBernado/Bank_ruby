class States < Sequel::Model
    include Lists
    plugin :validation_helpers

    one_to_many :cities

    def validate
        super
        validates_presence %i[state uf]
        validates_unique %i[state uf]
        validates_type String, %i[state uf]
        validates_max_length 2, :uf
        validates_max_length 100, :state
    end

    def add
        print 'Informe o estado: '
        state = gets.chomp.to_s.downcase

        print 'Informe o UF: '
        uf = gets.chomp.to_s.downcase

        if States.where(state:state, uf:uf).empty?
            States.create(state:state, uf:uf)
            puts 'Estado cadrastrado com secesso!'
        else 
            puts 'Estado já está cadrastrado.'
        end
    rescue Sequel::ValidationFailed
        puts "Estado ou UF inválido."
    end

    def delete
        list_states

        puts '-'
        print 'Escolha o Estado que deseja excluir: '
        state_delete = gets.chomp.to_i

        if !States.where(id: state_delete).empty?
            States.where(id: state_delete).delete
            puts 'Estado excluido com sucesso.'
        else
            puts 'ID informado não existe no sistema.'
        end
    end
end 