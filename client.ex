defmodule Client do

	def start_client() do
		dest_ip = list_to_tuple(Enum.map((String.split (to_string (IO.gets "IP to connect to ? ")), "."), (fn (s) -> case String.to_integer s do { n, _ } -> n end end)))
		{ dest_port, _ } = String.to_integer (to_string (IO.gets "Which port ? "))
		start_client(dest_ip, dest_port)
	end

	def start_client(dest_ip, dest_port) do
		start_client(dest_ip, dest_port, (Settings.get_setting :port) + 1)
	end

	def start_client(dest_ip, dest_port, local_port) do
		IO.puts ("Trying to start client on port " <> to_string local_port)
		case :gen_udp.open(local_port) do 
			{ :ok, socket } ->
				IO.puts "Started."
				loop(socket, dest_ip, dest_port)
			_ -> 
				IO.puts "Failed."
				start_client(dest_ip, dest_port, local_port+1)
		end 
	end


	defp loop(socket, ip, port) do 
		ask = String.split (String.strip (to_string (IO.gets "> ")))
		case Enum.at ask, 0 do
			"load" ->
				send_wait_loop socket, ip, port, [cmd: "load", res: (Enum.at ask, 1)]
			"end" ->
				IO.puts "Goodbye."
				exit :normal
			_ ->
				IO.puts "Invalid query."
				loop socket, ip, port
		end

	end

	defp wait_for_response(socket) do 
		receive do
			{ udp, socket, address, port, msg } ->
				IO.puts msg
			_ ->
				wait_for_response socket
		after
			20000 ->
				IO.puts "Sorry, timeout."
				exit :lostconnexion
		end
	end

	defp send_wait_loop(socket, ip, port, message) do 
		send_msg socket, ip, port, EJSON.encode(message)
		wait_for_response socket
		loop socket, ip, port
	end

	defp send_msg(socket, ip, port, msg) do
		:gen_udp.send(socket, ip, port, msg)
	end
	
end