defmodule Handler do
	def error(n) do 
		case n do 
			404 -> "{\"status\":404,\"content\":\"Not found\"}"
			_ -> "{\"status\":"++integer_to_binary(n)++",\"content\":\"Error\"}"
		end
	end

	def answer(address, port, msg) do
		request = EJSON.decode msg
		case EJSON.search_for request, :cmd do 
			"load" ->
				case File.read (Path.basename(String.strip (EJSON.search_for request, :res))) do 
					{ :ok, lol } ->
						"{\"status\":200,\"content\":\"" <> to_string lol <> "\"}"
					_ ->
						error(404)
				end
			_ ->
				error(404)
		end
	end
end