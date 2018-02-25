# calibre-server

Docker build with Ubuntu 16.04 and Calibre.

[EN] This container containes a calibre-server from [calibre.com](https://calibre-ebook.com), running one or multible libraries. You can add an user-authentication by enable the AUTH paramether (User:root PW:root). [DE] Dieser Container enthält den calibre-server von [calibre.com](https://calibre-ebook.com), welcher eine oder mehrere Calibre-Bibliotheken zur Verfügung stellen kann. Du kannst die Nutzerauthentifizierung einschalten indem du den AUTH Parameter auf enable setzt (User:root PW:root).

- -v /path/to/calibre/library(s):/calibre-lib
- -v /path/to/server-users.sqlite:/users.sqlite
- -e PREFIX=/calibre
- -e LIBRARY=/calibre-lib | /calibre-lib/lib1 /calibre-lib/lib2
- -e AUTH=enable-auth | disable-auth
- -e BANAFTER 5
- -e BANFOR 30
- -e AJAXTIMEOUT 60
- -e TIMEOUT 120
- -e NUMPERPAGE 50
- -e MAXOPDS 30

## Examples
Example 1. Single Library and Prefix
```docker run -d -p 8082:8080 -v /Calibre:/calibre-lib -e PREFIX=/calibre --name calibre-server finios/calibre-server```

Example 2: Multiple Librarys
```docker run -d -p 8082:8080 -v /Calibre:/calibre-lib -e LIBRARY=/calibre-lib/test1 /calibre-lib/test2 --name calibre-server finios/calibre-server```

## FAQ:
__[EN] How can I create a server-user.sqlite? [DE] Wie kann ich eine server-users.sqlite erstellen__

[EN] Open Calibre on your host, go to Preferences, go to Share over the net, go to User accounts. Here you can add users and allow access to your libraries (only if you have mounted your librarys in calibre).
Now you can find the server-users.sqlite in your Calibre-folder "/path/to/Calibre/Calibre Settings/"
Alternative: Run "calibre-server --userdb /path/to/calibre/server-users.sqlite --manage-users"
[DE] Öffne Calibre auf deiner Hostmaschiene, wechsle in die Einstellungen, Netzwerkserver, Benutzerkonten. Hier kannst du Nutzer anlegen und Berechtigungen für die Bibliotheken vergeben (sofern du deine Bibliothek in Calibre eingebunden hast).

__[EN] Can I edit the server-users.sqlite inside the running dockercontainer? [DE] Kann ich die server-users.sqlite innerhalb des dockercontainers editieren?__
[EN] No, you can't run calibre-server twice in the container and if you stop the calibre-process, the container stops too.
But you can edit it from your host, if you have mounted the file.
[DE] Nein, man kann calibre-server nicht mehrfach innerhalb des Containers starten und wenn man den Prozess beendet wird auch der container gestopt. Die sqlite Datenbank kann allerdings auf der Hostmaschiene editiert werden sofern sie nach ausen gemounted ist.

__[EN] On which system had you tested it? [DE] Auf welchem System hast du es bisher getestet?__
[EN] I tested it on Synology DSM 6.1.4 (Docker-Package: 17.05.0-0367)
[DE] Ich habe es auf einer Synology DSM 6.1.4 (Docker-Packet: 17.05.0-0367) getestet.

__[EN] Username and Password? [DE] Nutzername und Passwort?__
User: root
PW: root

__[EN] Description of the Parameter [DE] Beschreibung der Parameter__
[Calibre Manual](https://manual.calibre-ebook.com/generated/en/calibre-server.html)
