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

defmodule Server do
	def start_server() do
		port = Settings.get_setting :port
		ip = Settings.get_setting :ip
		Inform.warning "Starting server on #{Enum.join(Enum.map(ip, fn (x) -> integer_to_binary x end), ".")}:#{inspect port}"
		{ :ok, socket } = :gen_udp.open(port, [{ :ip, list_to_tuple(ip) }])
		loop(socket)
	end

	defp loop(socket) do 
		receive do
			{ udp, socket, address, port, msg } ->
				case handle(socket, address, port, msg) do 
					{ :ok, ctnt } ->
						Inform.log_ok "#{msg} => #{ctnt}"
					{ :error, ctnt } ->
						Inform.log_error "#{msg} => #{ctnt}"
				end
				loop(socket)
			_ ->
				loop(socket)
		end
	end

	defp handle(socket, address, port, msg) do
		answer = Handler.answer(address, port, msg)
		case answer do 
			{ _, ctnt } ->
				:gen_udp.send(socket, address, port, to_string ctnt)
		end
		answer
	end
	
end