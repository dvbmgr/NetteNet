# The MIT License (MIT)

# Copyright (c) 2013 David Baumgartner

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

defmodule RSA do

	def generateNumbers() do 
		p = randomPrime
		q = randomPrime
		n = p * q
		m = (p - 1) * (q - 1)
		c = randomPrimeWith(m)
		{ p, q, n, m, c }
	end


	def getPrivateNumbers({ p, q, n, m, c }) do 
		{ u, n }
	end

	defp random() do 
		:random.uniform(round 1.0e300)
	end

	defp randomPrime() do 

	end

	defp randomPrimeWith(n) do 

	end

	defp findU(c, m) do 
		{ _, u, _ } = extendedEuclidean(c, m)
		if 2 < z < m do 
			u
		else
			k = div u, m
			u - k * m 
		end
	end

	defp extendedEuclidean(a, b) do 
		extendedEuclidean(a,1,0,b,0,1)
	end

	defp extendedEuclidean(r, u, v, 0, u_, v_) do 
		{ r, u, v }
	end

	defp extendedEuclidean(r, u, v, r_, u_, v_) do
		extendedEuclidean(r_, u_, v_, r - (div r, r_) * r_, u - (div r, r_) * u_, v - (div r, r_) * v_)
	end

	defp isPrime(n) do
		isPrime(n, 2, :math.sqrt(n))
	end

	defp isPrime(n, s, sq) do 
		if s <= sq do
			if not (is_integer (n / s)) do
				isPrime(n, s+1, sq)
			end
		else
			true
		end
		false
	end

	defp isPrimeWith(n, m) do 
		gcd(n, m) == 1
	end

	defp gcd(a, 0) do 
		a
	end

	defp gcd(a, b) do 
		gcd b, (rem a, b)
	end

	defp getPublicNumbers({ p, q, n, m, c }) do
		{ n, c }
	end

end