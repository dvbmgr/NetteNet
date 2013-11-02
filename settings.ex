defmodule Settings do
	def read_settings() do
		EJSON.read_file("settings.config")
	end

	def get_setting(key) do 
		EJSON.search_for read_settings(), key
	end 
end