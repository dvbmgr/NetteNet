defmodule Handler do
	def error(n) do 
		case n do 
			404 -> 
				EJSON.encode([status: 404, content: "Not found"])
			_ ->
				EJSON.encode([status: n, content: "Not found"])
		end
	end

	def answer(address, port, msg) do
		request = EJSON.decode msg
		case EJSON.search_for request, :cmd do 
			"load" ->
				case File.read (Path.basename(String.strip (EJSON.search_for request, :res))) do 
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