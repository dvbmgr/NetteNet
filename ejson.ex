defmodule EJSON do
	def read_file(name) do
		case File.read(name) do 
			{ :ok, content } ->
				decode(content)
		end
	end

	def decode(content) do
		{ :ok, ctnt } = :json.decode(String.replace (to_string content), "\n", "")
		clean(ctnt)
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
			"{" <> ctnt <> "}"
		else
			"[" <> ctnt <> "]"
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

	def encode(content) do 
		encode_(content)
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