defmodule EJSON do
	def read_file(name) do
		case File.read(name) do 
			{ :ok, content } ->
				decode(content)
		end
	end

	def decode(content) do
		{ :ok, ctnt } = :json.decode(content)
		clean(ctnt)
	end 

	def search_for(content, key) do 
		Enum.at (Keyword.get_values content, key), 0
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

	defp clean(n) do 
		n
	end
end