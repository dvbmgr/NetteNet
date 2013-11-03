defmodule Server do
	def start_server() do
		port = Settings.get_setting :port
		ip = Settings.get_setting :ip
		IO.puts ("Starting server on " <> (Enum.join(Enum.map(ip, fn (x) -> integer_to_binary x end), ".")) <> ":" <> integer_to_binary(port))
		{ ok, socket } = :gen_udp.open(port, [{ :ip, list_to_tuple(ip) }])
		loop(socket)
	end

	defp loop(socket) do 
		receive do
			{ udp, socket, address, port, "end" } ->
				IO.puts "Left"
			{ udp, socket, address, port, msg } ->
				IO.puts ("Recieved "<>to_string msg)
				handle(socket, address, port, msg)
				loop(socket)
			_ ->
				loop(socket)
		after
			50000 ->
				IO.puts "Timeout"
				loop(socket)
		end
	end

	defp handle(socket, address, port, msg) do
		:gen_udp.send(socket, address, port, to_string Handler.answer(address, port, msg))
	end
end