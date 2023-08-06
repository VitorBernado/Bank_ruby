class Extracts< Sequel::Model
    plugin :validation_helpers

    one_to_many :accounts

    def validate
        super
        validates_presence %i[account_id type value]
        validates_integer %i[account_id]
    end

    def extracts(number_account)
        account = Accounts.where(number: number_account).first
        extracts = Extracts.where(account_id: account.id)
        extracts.each do |extract|
            puts "Tipo: #{extract[:type]}, Valor: #{extract[:value]}, Data: #{Rainbow(format_time(extract[:create_at])).blue}"
            puts "Origem: #{Rainbow(extract[:origin]).blue}" if extract.origin
            puts "Destino #{Rainbow(extract[:destiny]).blue}" if extract.destiny
            puts Rainbow('-').black
        end

        puts 'Deseja gerar um arquivo com essa informações?'
        puts '1 - Gerar em CSV.'
        puts '2 - Gerar em JSON.'
        option = gets.chomp.to_i

        case option
        when 1
            CSV.open('Extracts/extracts.csv', 'w') do |csv|
                csv << ['Tipo', 'Valor', 'Data', 'Origem', 'Destino']
                extracts.each do |extract|
                  csv << [extract.type, extract.value, format_time(extract.create_at)]
                end
            end
          
        when 2
            json_data = extracts.map do |extract|
                { 'Tipo' => extract.type, 'Valor' => extract.value, 'Data' => format_time(extract.create_at), 'Origem' => extract.origin, 'Destino' => extract.destiny }
            end
            
              File.open('Extracts/extracts.json', 'w') do |file|
                file.write(JSON.pretty_generate(json_data))
              end
        
        end
    
    end 

    def format_time(time)
        time.strftime('%Y-%m-%d %H:%M:%S')
    end
    
end