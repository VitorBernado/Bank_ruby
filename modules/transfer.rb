module Transfer

    def ted(account)

        print 'Informe o número da conta que deseja fazer a transferência: '
        account_number = gets.chomp

        print 'Qual o valor que deseja transferência: '
        amount = gets.chomp.to_f

        account_transfer = Accounts.where(number: account_number).first
        account_origen = Accounts.where(number: account).first

        if amount > 0
            if account_transfer
                if account_origen.balance >= -100
                    if  account_origen.customer_id == account_transfer.customer_id
                        account_origen.update(balance: account_origen.balance - amount)
                        account_transfer.update(balance: account_transfer.balance + amount)
        
                        Extracts.create(type: 'TED', value: amount, origin: account_origen.number, destiny: account_transfer.number, account_id: account_origen.id)
                        puts Rainbow("TED realizado com secesso para a conta #{account_transfer.number}").green
                    
                    else
                        puts "Será cobrado uma #{Rainbow('taxa de 1% ').yellow}do valor transferido. Continuar?"
                        puts '1 - Sim'
                        puts '2 - Não'
                        option = gets.chomp.to_i
        
                        if option == 1
                            account.update(balance: account.balance - (amount_origen * 0.01 + amount))
                            account_transfer.update(balance: account_transfer.balance + amount)
                            Extracts.create(type: 'TED', value: amount, origin: account_origen.number, destiny: account_transfer.number)
                            puts Rainbow("TED realizado com secesso para a conta #{account_transfer.number}").green
                        end
                    end
                else
                    puts Rainbow("Saldo insuficiente para realizar o tranferência de #{amount}. Saldo disponível: #{account_origen.balance}").red
                end
            else
                puts Rainbow("Conta #{number_account} não encontrada.").red
            end
        else
            puts Rainbow('Não e possivel transferir esse valor.').red
        end
    end

    def pix(account)
        print 'Informe o número da conta que deseja fazer a transferência: '
        account_number = gets.chomp

        print 'Qual o valor que deseja transferência: '
        amount = gets.chomp.to_f

        account_transfer = Accounts.where(number: account_number).first
        account_origen = Accounts.where(number: account).first

        if amount > 0
            if account_transfer
                if account_origen.balance >= -100
                    account_origen.update(balance: account_origen.balance - amount)
                    account_transfer.update(balance: account_transfer.balance + amount)
                    Extracts.create(type: 'PIX', value: amount, origin: account_origen.number, destiny: account_transfer.number, account_id: account_origen.id)
                    puts Rainbow("Pix realizado com secesso para a conta #{account_transfer.number}").green
                else
                    puts Rainbow("Saldo insuficiente para realizar o tranferência de #{amount}. Saldo disponível: #{account_origen.balance}").red
                end
            else
                puts Rainbow("Conta #{number_account} não encontrada.").red
            end
        else
            puts Rainbow('Não e possivel transferir esse valor.').red
        end
    end 
end