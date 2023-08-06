O aplicativo é dividido em duas partes, Administrativa e as funcionalidade das contas.

    1 - States
        add : Essa funcionalida verifica se o o estado existe, se não ele cadatrada o estado pedindo como argumentos o nome do estado e a UF.

        list_states : Essa função lista todos os estados cadastrados.

        delete : Essa função lista todos os estados cadastrados, e deleta o estado selecionado e deleta ele.

    2 - Cities
        add : Essa funcionalida verifica se o o estado existe, se não ele cadatrada o estado pedindo como argumentos o nome do estado e a UF, ele lista os estado para vincular a cidade.

        list_cities : Essa função lista todos os cidades cadastrados.

        delete : Essa função lista todos os cidades cadastrados, e deleta o cidades selecionado e deleta ele.

    3 - Customers 
        add : Essa função criar um cliente caso seu cpf ou cnpj não estiverem em uso.

        consult : Essa funcionalidade pega o documento do cliente e verifica se existe alguém registo com ele e informa.

        delete : Essa função pede o documento do cliente e deleta ele, caso ele exista.

    4 - Accounts
        add : Pede o documento do cliente e gerar uma conta, pode ser registrado mais de uma conta no mesmo cpf

        delete : pode o número de conta e deleta dela.

        consult : Pode o documento pesquisa e exibe todas as contas registrada no mesmo documento.

        login : Pede o número da conta verifica se a conta existe, e retorna o número dela pra ser usada em outras funçãos.

        withdraw : Verifica o saldo da conta, verifica se não é necessario entra no cheque especial, e faz o saque

        deposit : Verifica de não está no cheque especial, se estiver ele cobrar o valor devedor e deposita o resto na conta.

        ted : Verifica de a conta é do mesmo dono, faz a tranferêcia sem cobrar taxas, caso não seja cobra uma taxa de 1% do valor transferido.

        pix : Transferê para outra conta sem cobrar juros.

        show_balance : Mostrar o saldo e o nome do dano da conta.

    5 - Extracts
        extracts : Exibe todas movimentações feita pela conta, e da o opção de imprimir em formato CSV OU JSON.

    6 - Generation_number
        generation_number : gerar um número aleatorio para a criação da conta.

    7 - Fees
        fees : Faz o calculo da taxa do cheque especial.

