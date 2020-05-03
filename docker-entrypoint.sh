#!/bin/bash
set -e

check_database() {
	#check if userdatabase exist
	if [ ! -f "/config/$USERDB" ]; then
		# creating userdb
		# /opt/calibre/calibre-server --userdb /config/$USERDB --manage-users
		echo "Creating userdatabase"
		sqlite3 -batch /config/$USERDB "CREATE TABLE if not exists users (
				id INTEGER PRIMARY KEY,
				name TEXT NOT NULL,
				pw TEXT NOT NULL,
				timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
				session_data TEXT NOT NULL DEFAULT \"{}\",
				restriction TEXT NOT NULL DEFAULT \"{}\",
				readonly TEXT NOT NULL DEFAULT \"n\",
				misc_data TEXT NOT NULL DEFAULT \"{}\",
				UNIQUE(name)
			);
			PRAGMA user_version=1;"
		# add user
		echo "Add user $AUTH_USER to /config/$USERDB"
		sqlite3 -batch /config/$USERDB "INSERT INTO users (name, pw, readonly) VALUES (\"$AUTH_USER\", \"$AUTH_PASSWORD\", \"n\");"
	fi
}

calibre --version
if [ "$AUTH" = "enable-auth" ]; then
	check_database
	exec /opt/calibre/calibre-server --ban-after=$BANAFTER --ban-for=$BANFOR --ajax-timeout=$AJAXTIMEOUT --timeout=$TIMEOUT --num-per-page=$NUMPERPAGE --max-opds-items=$MAXOPDS --url-prefix=$PREFIX --userdb /config/$USERDB --$AUTH $OTHERPARAM --port=$PORT $LIBRARY 
else
	exec /opt/calibre/calibre-server --ban-after=$BANAFTER --ban-for=$BANFOR --ajax-timeout=$AJAXTIMEOUT --timeout=$TIMEOUT --num-per-page=$NUMPERPAGE --max-opds-items=$MAXOPDS --url-prefix=$PREFIX $OTHERPARAM --port=$PORT $LIBRARY 
fi
