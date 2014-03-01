#!/bin/bash
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

CC="elixirc"

JSON="json/ebin/"
SHA2="sha2/ebin/"

SETTINGS="helpers/settings.ex"
EJSON="helpers/ejson.ex"
COLORS="helpers/colors.ex"
INFORM="helpers/inform.ex"
USERS="helpers/users.ex"
NOTIFY="helpers/notify.ex"

RSA="crypto/rsa.ex"

CLIENT_HANDLER="client/handler.ex"
SERVER_HANDLER="server/handler.ex"

CLIENT="client/client.ex"
SERVER="server/server.ex"

BASE_REQUIREMENTS="-pa $JSON -pa $SHA2 -r $SETTINGS -r $EJSON -r $COLORS -r $INFORM -r $USERS"
CLIENT_REQUIREMENTS="$BASE_REQUIREMENTS            -r $CLIENT_HANDLER -r $CLIENT"
SERVER_REQUIREMENTS="$BASE_REQUIREMENTS -r $NOTIFY -r $SERVER_HANDLER -r $SERVER"


if [ "$1" == "client" ]; then
	echo $CC $CLIENT_REQUIREMENTS client/start.ex
	$CC $CLIENT_REQUIREMENTS client/start.ex
elif [ "$1" == "server" ]; then
	echo $CC $SERVER_REQUIREMENTS server/start.ex
	$CC $SERVER_REQUIREMENTS server/start.ex
fi