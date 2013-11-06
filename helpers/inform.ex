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

defmodule Inform do
	
	def ok() do 
		ok("Ok.")
	end

	def error() do 
		error("Error.")
	end

	def warning() do
		warning("Warning!")
	end

	def ok(msg) do 
		IO.puts Colors.color(:green, msg)
	end

	def error(msg) do 
		IO.puts Colors.color(:red, msg)
	end

	def warning(msg) do 
		IO.puts Colors.color(:yellow, msg)
	end

	def log_ok(msg) do 
		IO.puts "[#{prepare_log}] #{Colors.color :green, "ok"}: #{msg}"
	end

	def log_error(msg) do 
		IO.puts "[#{prepare_log}] #{Colors.color :red, "error"}: #{msg}"
	end

	def log_warning(msg) do 
		IO.puts "[#{prepare_log}] #{Colors.color :yellow, "warning"}: #{msg}"
	end

	defp prepare_log() do 
		{{ year, month, day }, { hour, minute, second }} = :erlang.localtime
		"#{inspect day}/#{inspect month}/#{inspect year} #{inspect hour}:#{inspect minute}:#{inspect second}"
	end
end