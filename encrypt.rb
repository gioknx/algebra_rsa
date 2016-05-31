require 'prime'
require 'openssl'


def mdc_ext(a, b)
    r, r_ = b, a
    x, x_ = 0, 1
    y, y_ = 1, 0
    while(r != 0) 
        q = r_ / r
        r_, r = r, r_ - (q * r)
        x_, x = x, x_ - (q * x)
        y_, y = y, y_ - (q * y)
    end
    if x_ < 0
        x_ += b
    end

    return [r_, x_, y_]
end


def get_rand_prime
	Prime.take(9999)[Random.rand(999..9999)]
end

def gera_valores
	p = get_rand_prime
	p "P #{p}"
	q = get_rand_prime
	p "Q #{q}"
	# Assegura que os números são diferentes
	while q == p
		q = get_rand_prime
	end
	phi_n = (p-1)*(q-1)
	# Achamos um E valido invertivel mod phi_n
	while 1
		e = Random.rand(3..phi_n-1)
		# Caso E seja invertivel mod phi_n saimos do loop
		if mdc_ext(e, phi_n)[0] == 1
			break
		end
	end

	d = mdc_ext(e, phi_n)[1]
	return p*q, e, d
end

def encrypt mensagem, n, e
	lista_cifras = []
	mensagem.each_byte do |b|
		lista_cifras << b.to_bn.mod_exp(e, n).to_i
	end
	lista_cifras
end

n,e,d = gera_valores
p "Chave publica: n => #{n}   e => #{e}"
p "Chave privada: n => #{n}   d => #{d}"

mensagem = gets.chomp

p encrypt(mensagem, n, e)
