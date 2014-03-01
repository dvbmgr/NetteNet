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

defmodule EJSON do
	def read_file(name) do
		if not File.exists?(name) do
			File.write!(name, "[]")
		end 
		decode(File.read!(name))
	end

	def write_file(name, datas) do
		File.write!(name, encode(datas))
	end

	def decode(content) do
		{ :ok, ctnt } = :json.decode(String.replace (to_string content), "\n", "")
		clean(ctnt)
	end 

	def encode(content) do 
		encode_(content)
	end
	
	defp encode_(content) when is_bitstring(content) do 
		"\"" <> content <> "\""
	end

	defp encode_(content) when is_number(content) do 
		to_string content
	end 

	defp encode_(content) when is_list(content) do 
		ctnt = Enum.join(Enum.map(content, fn (x) -> to_string(encode_(x)) end), ",")
		if (Enum.all?(content, fn (x) -> is_tuple x end)) do
			"{#{ctnt}}"
		else
			"[#{ctnt}]"
		end
	end

	defp encode_({key, value}) when is_atom(key) do 
		encode_({(to_string key), value})
	end

	defp encode_({key, value}) do
		(encode_ key) <> ":" <> (encode_ value)
	end

	defp encode_(content) do 
		encode_ (to_string content)
	end

	def search_for(content, key) do 
		Keyword.get content, key
	end

	defp clean({ n }) when is_list(n) do
		Enum.map(n, fn { a, b } -> (
			if is_binary(a) do
				{ binary_to_atom(a), clean(b) } 
			else
				{ list_to_atom(a), clean(b) } 
			end)
		end)
	end

	defp clean(n) when is_list(n) do
		Enum.map(n, fn (x) -> clean x end)
	end

	defp clean(n) do 
		n
	end
end