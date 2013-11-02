iex -pa json/ebin/ -r ejson.ex -r settings.ex -r handler.ex -r client.ex -e "Client.start_client({10,0,0,7},8491)"
