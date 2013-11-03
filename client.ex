defmodule Client do

	# debug...
	def strm() do
		start_client({10,0,0,3},8491)
	end

	def start_client() do
		dest_ip = list_to_tuple(Enum.map((String.split (IO.gets "IP to connect to ? "), "."), (fn (s) -> case String.to_integer s do { n, _ } -> n end end)))
		{ dest_port, _ } = String.to_integer (IO.gets "Which port ? ")
		start_client(dest_ip, dest_port)
	end

	def start_client(dest_ip, dest_port) do
		port = (Settings.get_setting :port) + 1
		IO.puts "Connecting… "
		{ ok, socket } = :gen_udp.open(port)
		loop(socket, dest_ip, dest_port)
	end

	defp loop(socket, ip, port) do 
		ask = IO.gets "load> "
		case ask do
			"end\n" ->
				send_msg socket, ip, port, "end"
			_ ->
				send_msg socket, ip, port, ("{\"cmd\":\"load\",\"res\":\""<>ask<>"\"}")
				wait_for_response socket
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
				IO.puts "Timeout"
		end
	end

	defp send_msg(socket, ip, port, msg) do
		:gen_udp.send(socket, ip, port, msg)
	end
end