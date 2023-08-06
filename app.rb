#!/usr/bin/env ruby
# frozen_string_literal: true
require 'sqlite3'
require 'sequel'
require 'rainbow/refinement'
require 'csv'
require 'json'

Sequel.sqlite('DB/bank.db')

require_relative 'modules/generation_number'
require_relative 'modules/fees'
require_relative 'modules/transfer'
require_relative 'modules/lists'
require_relative 'models/states'
require_relative 'models/cities'
require_relative 'models/customers'
require_relative 'models/accounts'
require_relative 'models/extracts'

states = States.new
cities = Cities.new
customers = Customers.new
accounts = Accounts.new
extracts = Extracts.new

loop do
    puts Rainbow('Bem vindo ao RubyBank!').cyan
    puts Rainbow('-').black
    puts '1 - Administrativo'
    puts '2 - Acessar uma conta'
    puts '3 - Encerrar'
    puts Rainbow('-').black
    print Rainbow('Digite uma opção acima: ').cyan
    option = gets.chomp.to_i

    case option
    when 1
        loop do
            puts Rainbow('Central Administrativa').cyan
            puts Rainbow('-').black
            puts '1 - Conta'
            puts '2 - Cliente'
            puts '3 - Cidade'
            puts '4 - Estado'
            puts '5 - Voltar ao Menu anterior'
            puts Rainbow('-').black
            print Rainbow('Digite uma opção acima: ').cyan
            option = gets.chomp.to_i

            case option
            when 1

                loop do
                    puts Rainbow('-').black
                    puts Rainbow('Central de Contas').cyan
                    puts Rainbow('-').black
                    puts '1 - Consultar contas'
                    puts '2 - Criar conta'
                    puts '3 - Deletar conta'
                    puts '4 - Voltar ao Menu anterior'
                    puts Rainbow('-').black
                    print Rainbow('Digite uma opção acima: ').cyan
                    option = gets.chomp.to_i

                    case option
                    when 1
                        accounts.consult
                    when 2
                        accounts.add
                    when 3
                        accounts.delete
                    when 4
                        puts Rainbow('Voltando ao menu anterior.').cyan
                        break
                    else
                        puts Rainbow('Opção inválida.').red
                    end
                end

            when 2

                loop do
                    puts Rainbow('-').black
                    puts Rainbow('Central de Clientes').cyan
                    puts Rainbow('-').black
                    puts '1 - Consultar cliente'
                    puts '2 - Cadastrar cliente'
                    puts '3 - Deletar cliente'
                    puts '4 - Voltar ao Menu anterior'
                    puts Rainbow('-').black
                    print Rainbow('Digite uma opção acima: ').cyan
                    option = gets.chomp.to_i
                

                    case option
                    when 1
                        customers.consult
                    when 2 
                        customers.add
                    when 3
                        customers.delete
                    when 4
                        puts Rainbow('Voltando ao menu anterior.').cyan
                        break
                    else
                        puts Rainbow('Opção inválida.').red
                    end

                end

            when 3

                loop do
                    puts Rainbow('-').black
                    puts Rainbow('Gerenciamento de Cidades').cyan
                    puts Rainbow('-').black
                    puts '1 - Consultar Cidades'
                    puts '2 - Cadastrar Cidades'
                    puts '3 - Deletar Cidades'
                    puts '4 - Voltar ao Menu anterior'
                    puts Rainbow('-').black
                    print Rainbow('Digite uma opção acima: ').cyan
                    option = gets.chomp.to_i

                    case option
                    when 1
                        cities.list_cities
                    when 2 
                        cities.add
                    when 3
                        cities.delete
                    when 4
                        puts Rainbow('Voltando ao menu anterior.').cyan
                        break
                    else
                        puts Rainbow('Opção inválida.').red
                    end

                end
            when 4
                loop do
                    puts Rainbow('-').black
                    puts Rainbow('Central de Contas').cyan
                    puts Rainbow('-').black
                    puts '1 - Consultar Estados'
                    puts '2 - Cadastrar Estado'
                    puts '3 - Deletar Estado'
                    puts '4 - Voltar ao Menu anterior'
                    puts Rainbow('-').black
                    print Rainbow('Digite uma opção acima: ').cyan
                    option = gets.chomp.to_i

                    case option
                    when 1
                        states.list_states
                    when 2
                        states.add
                    when 3
                        states.delete
                    when 4
                        puts Rainbow('Voltando ao menu anterior.').cyan
                        break
                    else
                        puts Rainbow('Opção inválida.').red
                    end
                end
            when 5
                puts Rainbow('Voltando ao menu anterior.').cyan
                break
            else
                puts Rainbow('Opção inválida.').red
            end
        end
    
    when 2
        number_account = accounts.login
        
        loop do
            accounts.show_balance(number_account)
            puts '1 - Sacar'
            puts '2 - Depositar'
            puts '3 - Transferéncia'
            puts '4 - Extrato'
            puts '5 - Voltar ao Menu anterior'
            puts Rainbow('-').black
            print Rainbow('Digite uma opção acima: ').cyan
            option = gets.chomp.to_i

            case option
            when 1
                accounts.withdraw(number_account)
            when 2
                accounts.deposit(number_account)
            when 3
                loop do
                    puts Rainbow('-').black
                    puts '1 - TED'
                    puts '2 - PIX'
                    puts '3 - Voltar ao Menu anterior'
                    puts Rainbow('-').black
                    print Rainbow('Digite uma opção acima: ').cyan
                    option = gets.chomp.to_i

                    case option
                    when 1
                        accounts.ted(number_account)
                    when 2
                        accounts.pix(number_account)
                    when 3
                        puts Rainbow('Voltando ao menu anterior.').cyan
                        break
                    else
                        puts Rainbow('Opção inválida.').red
                    end
                end
            when 4
                extracts.extracts(number_account)
            when 5
                puts Rainbow('Voltando ao menu anterior.').cyan
                break
            else
                puts Rainbow('Opção inválida.').red
            end
        end

    when 3
        puts Rainbow('Encerrando..').cyan
        break
    else
        puts Rainbow('Opção inválida.').red
    end
end
