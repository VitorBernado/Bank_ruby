module Generation_number

    def generation_number_account
        number_random = rand(0000000..999999)
        number_format = sprintf('%06d', number_random) 
        number_with_dash = number_format.insert(4, '-')
        return number_with_dash
    end

end