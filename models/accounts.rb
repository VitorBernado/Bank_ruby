class Accounts < Sequel::Model
    include Generation_number
    include Fees
    include Transfer
    plugin :validation_helpers

    one_to_many :customers
    many_to_one :extracts

    def validate
        super
        validates_presence %i[number]
        validates_unique :number
        validates_format /^\d{4}-\d{2}$/, :number
    end
    

    def add
        number_account = generation_number_account

        print 'Informe o CPF/CNPJ para vincular a conta: '
        document = gets.chomp.to_s.downcase 

        if !Customers.where(document: document).empty?
            customers = Customers.where(document: document).first
            id = "#{customers[:id]}".to_i
            Accounts.create(number: number_account, customer_id: id)

            puts Rainbow('Conta criado com sucesso.').green
            puts Rainbow("Número da conta: #{number_account}").green
        else
            puts Rainbow('CPF/CNPJ não cadastrado.').yellow
        end
    end

    def delete
        print 'Informe o número da conta que deseja excluir: '
        account = gets.chomp.to_s.downcase

        if !Accounts.where(number: account).empty?
            Accounts.where(number: account).delete
            puts Rainbow('Conta excluido com sucesso.').green
          else
            puts Rainbow('Esse conta não existe.').yellow
        end
    end

    def withdraw(number_account)
        print 'Informe o valor que deseja sacar: '
        amount = gets.chomp.to_f
        account = Accounts.where(number: number_account).first
      
        if amount > 0
            if account
                if account.balance >= amount
                    account.update(balance: account.balance - amount)
                    Extracts.create(type: 'Saque', value: amount, account_id: account.id)
                    puts Rainbow("Saque de #{amount} realizado com sucesso. Novo saldo: #{account.balance}").green
                    account.update(active_check: nil)
    
                elsif account.balance >= amount - 100
                    puts "Você está entrando no cheque especial, e será cobrado uma #{Rainbow('taxa de 0,23% ').yellow}ao dia. Deseja continuar?"
                    puts '1 - Sim'
                    puts '2 - Não'
                    choice = gets.chomp.to_i
    
                    if choice == 1
                        Extracts.create(type: 'Saque', value: amount, account_id: account.id)
                        account.update(balance: account.balance - amount)
                        account.update(active_check: Sequel::CURRENT_TIMESTAMP)
                        puts Rainbow("Saque de #{amount} realizado com sucesso. Novo saldo: #{account.balance}").green
                    end
                else
                    puts Rainbow("Saldo insuficiente para realizar o saque de #{amount}. Saldo disponível: #{account.balance}").red
                end
            else
                puts "Conta não encontrada."
            end
        else
            puts 'Não e possivel sacar valor negativo' 
        end
    end

    def deposit(number_account)
        fees(number_account)
        print 'Informe o valor que deseja depositar: '
        amount = gets.chomp.to_f

        account = Accounts.where(number: number_account).first
        
        if amount > 0
            if account
                if account.balance < 0
                    puts "Será cobrado o juros do cheque especial"
                    puts "Juros: #{Rainbow(account.overdraft).yellow}."
                    puts "Cheque especial: #{Rainbow(account.balance).yellow}"
                    if account.overdraft <= amount
                        account.update(overdraft: 0.0)
                        account.update(active_check: nil)
                        account.update(balance: account.balance + amount)
                        Extracts.create(type: 'Depósito', value: amount, account_id: account.id)
                        puts Rainbow("Deposito de #{amount} realizado com sucesso.").green
                    else
                        account.update(overdraft: amount - account.overdraft)
                        account.update(balance: account.balance + amount)
                        Extracts.create(type: 'Depósito', value: amount, account_id: account.id)
                        puts Rainbow("Deposito de #{amount} realizado com sucesso.").green
                        account.update(active_check: nil)
                    end
                else
                    account.update(balance: account.balance + amount)
                    Extracts.create(type: 'Depósito', value: amount, account_id: account.id)
                    puts Rainbow("Depósito de #{amount}, foi realizado com sucesso.").green  
                end
            end
        else
            puts Rainbow('Não e possivel depósitar valor negativo' ).red
        end
    end 

    def consult
        print 'Informe o CPF/CNPJ do cliente: '
        document = gets.chomp

        customer = Customers.where(document: document).first
        accounts = Accounts.where(customer_id: customer.id)
        accounts.each do |account|
            puts "Name: #{customer[:name].capitalize}, Documento: #{customer[:document]}, Número da conta : #{Rainbow("#{account[:number]}").magenta}"
        end
       
    end 

    def show_balance(number_account)
        account = Accounts.where(number: number_account).first
        customer = Customers.where(id: account.customer_id).first

        puts Rainbow("Olá, #{customer[:name].capitalize}").cyan
        puts Rainbow('-').black
        puts Rainbow("Saldo: R$ #{account[:balance]}").green if account.balance > 0 
        puts Rainbow("Saldo: R$ #{account[:balance]}").red if account.balance < 0
        puts Rainbow('-').black

    end

    def login
        loop do
          puts Rainbow('-').black
          puts Rainbow('Faça seu login!').magenta
          puts Rainbow('-').black
          print Rainbow('Digite o número da conta: ').cyan
          number_account = gets.chomp.to_s
      
          if !Accounts.where(number: number_account).empty?
            return number_account
          else
            puts Rainbow('Conta não existente.').red
          end
        end
    end
    
end