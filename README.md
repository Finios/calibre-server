# calibre-server

Docker build with Ubuntu 20.04 and Calibre.

[EN] This container containes a calibre-server from [calibre-ebook.com](https://calibre-ebook.com), running one or multible libraries. You can add an user-authentication by enable the AUTH paramether (User: root PW: root). <br>
[DE] Dieser Container enthält den calibre-server von [calibre-ebook.com](https://calibre-ebook.com), welcher eine oder mehrere Calibre-Bibliotheken zur Verfügung stellen kann. Du kannst die Nutzerauthentifizierung einschalten indem du den AUTH Parameter auf enable setzt (User: root PW: root).

* -v /path/to/calibre/library(s):/calibre-lib
* -v /path/to/config:/calibre-config
* -e PREFIX=/calibre
* -e LIBRARY=/calibre-lib | /calibre-lib/lib1 /calibre-lib/lib2
* -e AUTH=enable-auth | disable-auth
* -e USERDB=server-users.sqlite
* -e AUTH_USER=root
* -e AUTH_PASSWORD=root
* -e BANAFTER 5
* -e BANFOR 30
* -e AJAXTIMEOUT 60
* -e TIMEOUT 120
* -e NUMPERPAGE 50
* -e MAXOPDS 30
* -e PORT 8080
* -e OTHERPARAM <see [calibre-server options](https://manual.calibre-ebook.com/generated/en/calibre-server.html)>
* -e CALIBRE_OVERRIDE_LANG=en
* -e CALIBRE_CONFIG_DIRECTORY=/calibre-config/calibre

## Examples

### docker

Example 1: Single Library and Prefix <br>
```docker run -d -p 8082:8080 -v /Calibre:/calibre-lib -e PREFIX=/calibre --name calibre-server finios/calibre-server```

Example 2: Multiple Librarys <br>
```docker run -d -p 8082:8080 -v /Calibre:/calibre-lib -e LIBRARY=/calibre-lib/test1 /calibre-lib/test2 --name calibre-server finios/calibre-server```

### docker-compose

Example: Single Library and authentication enabled <br>
```
---
version: "3"  
services:  
    calibre-server:
      image: finios/calibre-server
      restart: unless-stopped
      ports:
        - 8082:8080
      environment:
        - LIBRARY=/calibre-lib
        - AUTH=enable-auth
      volumes:  
        - <path to library(s)>:/calibre-lib:rw
        - <path to config>:/calibre-config:rw
```

## FAQ:

__[EN] Can I edit the server-users.sqlite inside the running dockercontainer? [DE] Kann ich die server-users.sqlite innerhalb des dockercontainers editieren?__

[EN] No, you can't run calibre-server twice in the container and if you stop the calibre-process, the container stops too.
But you can edit it from your host, if you have mounted the file. <br>
[DE] Nein, man kann calibre-server nicht mehrfach innerhalb des Containers starten und wenn man den Prozess beendet wird auch der container gestopt. Die sqlite Datenbank kann allerdings auf der Hostmaschiene editiert werden sofern sie nach ausen gemounted ist.

__[EN] Where can I find the server-users.sqlite?[DE] Wo kann ich die server-users.sqlite finden?__

[EN] The database is created in the folder ```/calibre-config/server-users.sqlite```, if you enable authentication (environment variable ```AUTH=enable-auth```). You can change the location and name by editing the environment variable ```USERDB``` (e.g. if ```USERDB=database/db.sqlite``` you can find it here: ```/calibre-config/database/db.sqlite```) <br>
[DE] Die Datenbank wird unter ```/calibre-config/server-users.sqlite``` erzeugt, wenn die Variable ```AUTH=enable-auth``` gesetzt ist. Du kannst Speicherort und den Namen durch die Variable ```USERDB``` ändert (z.B. wenn ```USERDB=database/db.sqlite``` findest du sie hier: ```/calibre-config/database/db.sqlite```)

__[EN] Username and Password? [DE] Nutzername und Passwort?__

Username: root <br>
Password: root

__[EN] Can I change the initial password? [DE] Kann ich das initiale Passwort ändern?__

[EN] On first run (with ```AUTH=enable-auth```) you can set the username and password using the variables ```AUTH_USER``` and ```AUTH_PASSWORD```. After that you can only change it via the web interface or directly via the database. <br>
[DE] Beim ersten Starten (mit ```AUTH=enable-auth```), kannst du den Nutzernamen und das Passwort mit den Variablen ```AUTH_USER``` und ```AUTH_PASSWORD``` ändern. Danach kannst du es nur noch über die Weboberfläche oder die Datenbank direkt ändern.

__[EN] Description of the Environment variables [DE] Beschreibung der Variablen__

[Calibre Manual: calibre-server](https://manual.calibre-ebook.com/generated/en/calibre-server.html) <br>
[Calibre Manual: Customizing calibre](https://manual.calibre-ebook.com/customize.html)

## Changes:

* 30.20.2020:
  * update Dockerfile
  * update docker-entrypoint.sh

* 03.05.2020: 
  * rewrite/update Dockerfile
  * add docker-entrypoint.sh
  * add dynamic server-users.sqlite creation
  * remove static server-users.sqlite file
  * update README.md
