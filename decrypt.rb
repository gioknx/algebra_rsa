require 'openssl'

def decrypt dict, d,n
	resultado = []
	dict.each do |b|
		resultado << b.to_bn.mod_exp(d, n).to_i.chr
	end
	p resultado.join("")
end


p "D:"
d = gets.chomp
p "N:"
n = gets.chomp
mensagem_criptografa = eval(gets.chomp)

decrypt(mensagem_criptografa, d.to_i,n.to_i)

