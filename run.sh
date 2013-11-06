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

CC=iex

JSON="json/ebin/"

SETTINGS="helpers/settings.ex"
EJSON="helpers/ejson.ex"
COLORS="helpers/colors.ex"

RSA="crypto/rsa.ex"

HANDLER="server/handler.ex"

CLIENT="client/client.ex"
SERVER="server/server.ex"

CLIENT_REQUIREMENTS="-pa $JSON -r $SETTINGS -r $EJSON -r $COLORS -r $CLIENT"
SERVER_REQUIREMENTS="-pa $JSON -r $SETTINGS -r $EJSON -r $COLORS -r $HANDLER -r $SERVER"


if [ "$1" == "client" ]; then
	eval "$CC $CLIENT_REQUIREMENTS client/start.ex"
elif [ "$1" == "server" ]; then
	eval "$CC $SERVER_REQUIREMENTS server/start.ex"
fi