module Fees

    def fees(number_account)
        time_now =  Time.now
        account = Accounts.where(number: number_account).first

        if account.active_check
            past_time = ((time_now - account.active_check) / (15 * 60)).to_i 

            if past_time > 0 
                fees = account.balance * 0.0023 * past_time
                new_balence = account.balance + fees

                account.update(overdraft: fees)
                account.update(balance: new_balence)
                account.update(active_check: Sequel::CURRENT_TIMESTAMP)
            end
        end
    end 

end 
