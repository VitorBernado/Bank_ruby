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

# state1 = States.new(state: 'rio de janeiro', uf: 'RJ')
# puts state1.valid?
# state1.save

# estados = States.all
# p estados

# cidade = Cities.new(city: 'Copacabana', state_id: 1)
# puts cidade.valid?

# if cidade.valid?
#     cidade.save
#     p Cities.all
# end

# p Cities.join(:States, id: :state_id).all

# Customers.create(name: 'vitor', document: '12.345.678/0001-90', public_place: 'a', number: 23, neighborhood: 'sd', city_id: 1)

# p Customers.join(:Cities, id: :city_id).all

# Accounts.create(number: 100556, customer_id: 1)

# p Accounts.join(:customers, id: :customer_id).all

# Extracts.create(account_id: 2, type: 'deposito', value: 234.45)

# p Extracts.join(:accounts, id: :account_id).all

# products = Extracts.where(account_id: 2)
# products.each do |product|
#   puts product.type
#   puts product.value
# end

# conta = Accounts.new

# conta.add

# a = Customers.new
# a.consult

e = Accounts.new
# e.show_balance('6348-37')
# e.consult
# e.pix

u = Extracts.new
u.extracts('6348-37')
