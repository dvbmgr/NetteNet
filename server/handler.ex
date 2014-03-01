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
	
	def answer(address, port, msg) do
		request = EJSON.decode msg
		#user = Users.get_username(EJSON.search_for request, :sessiontoken)
		user = "dab"
		case EJSON.search_for request, :cmd do 
			"load" ->
				case File.read ("#{Settings.get_setting :publicdir}#{(Path.basename(String.strip (EJSON.search_for request, :res)))}") do 
					{ :ok, lol } ->
						output user, :ok, [status: 200, content: lol]
					_ ->
						error user, 404
				end
			"login" ->
				case Users.authenticate((EJSON.search_for request, :sessiontoken), (EJSON.search_for request, :username), (EJSON.search_for request, :password)) do 
					{ :ok } ->
						output user, :ok, [status: 200, content: "Successfully authenticated"]
					{ :error, :unvalidlogin } ->
						error user, 401
					{ :error, :alreadyauthenticated} ->
						error user, 400
				end
			_ ->
				error user, 404
		end
	end

	defp error(user, n) do 
		error(user, n,
			case n do 
				400 ->
					"Already authtenticated"
				401 ->
					"Login failed"
				404 -> 
					"Not found"
				500 ->
					"Internal error"
				_ ->
					"Unknown error"
			end)
	end

	defp error(user, status, message) do 
		output user, :error, [status: status, message: message]
	end

	defp output(user, is_ok, message) do 
		message = Keyword.update(message, :notifications, Notify.get_notifications(user))
		{ is_ok, EJSON.encode message }
	end
	
end