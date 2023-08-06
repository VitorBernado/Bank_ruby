class Customers < Sequel::Model
  include Lists
  plugin :validation_helpers

  one_to_many :cities
  many_to_one :accounts

  def validate
    validates_presence %i[name document public_place number neighborhood]
    validates_unique :document
    validates_format /(^\d{3}\.\d{3}\.\d{3}\-\d{2}$)|(^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$)/, :document
  end

  def add
    print 'Informe o nome do cliente: '
    name = gets.chomp.to_s.downcase

    print 'Informe o CPF/CNPJ: '
    document = gets.chomp.to_s.downcase

    print 'Informe o logradouro: '
    public_place = gets.chomp.to_s.downcase

    print 'Informe o numero da domicilio: '
    number = gets.chomp.to_i

    print 'Informe o bairro: '
    neighborhood = gets.chomp.to_s.downcase

    puts '-'
    list_cities
    puts '-'

    print 'Informe a cidade com as Opção exibidas acima: '
    city_id = gets.chomp.to_i

    Customers.create(name: name, document: document, public_place: public_place, number: number, neighborhood: neighborhood, city_id: city_id)
    puts 'Cliente registrado com secesso.'
  rescue Sequel::ValidationFailed
    puts 'Dados inválidos, confira os dados e certifique-se se o documentos não foi cadastrado.'
  end


  def delete
    print 'Informe o CPF/CNPJ do cliente e deseja excluir: '
    customer = gets.chomp.to_s.downcase
  
    if !Customers.where(document: customer).empty?
      Customers.where(document: customer).delete
      puts 'Cliente excluido com sucesso.'
    else
      puts 'Esse CPF/CNPJ não está cadastrado.'
    end
  end

  def consult
    print 'Informe o CPF/CNPJ do cliente: '
    document = gets.chomp


    customer = Customers.where(document: document).first
    if customer
      city = Cities.where(id: customer.city_id).first
      puts "Nome: #{customer[:name].capitalize}, Documento: #{Rainbow(customer[:documentos]).magenta}, Cidade: #{city[:city]}"
    else
      puts Rainbow('Cliente não encontrado.').red
    end
  end
   
end 
