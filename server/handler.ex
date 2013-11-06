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

defmodule Handler do

	def error(n) do 
		case n do 
			404 -> 
				error(n, "Not found")
			500 ->
				error(n, "Not allowed")
			_ ->
				error(n, "Unknown error")
		end
	end

	def error(status, message) do 
		EJSON.encode([status: status, message: message])
	end
	
	def answer(address, port, msg) do
		request = EJSON.decode msg
		case EJSON.search_for request, :cmd do 
			"load" ->
				case File.read ("docs/public/"<>(Path.basename(String.strip (EJSON.search_for request, :res)))) do 
					{ :ok, lol } ->
						EJSON.encode([status: 200, content: lol])
					_ ->
						error(404)
				end
			_ ->
				error(404)
		end
	end
	
end