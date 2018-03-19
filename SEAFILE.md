# How to install and configure Seafile server on an Ubuntu 18.04 droplet

Seafile is a private cloud such as Dropbox, except that Seafile is open source and encrypted by default, giving you added security and privacy benefits.

> Seafile is a private cloud such as Dropbox, OneDrive and others. Seafile is based on python and it is open source, so that you can create your own private cloud and it will be much more secure.

> Seafile supports encryption libraries that make your data will be more secure. To encrypt files in a library, you need to set a password when you create the library. The password won't be stored on Seafile cloud. So even the administrator of the servers cannot view your encrypted data without the password.

Introductory paragraph about the topic that explains what this topic is about and why the reader should care; what problem does it solve?

In this guide, you will [configure/set up/build/deploy][some thing]...

When you're finished, you'll be able to...

## Prerequisites

Before you begin this guide you'll need the following:

* An Ubuntu 18.04 Server with at least 2GB of RAM
* One Ubuntu 18.04 server set up by following [this Ubuntu 18.04 initial server setup tutorial](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04), including a sudo non-root user and a firewall.
* A LEMP stack installed by following this [LEMP on Ubuntu 18.04 tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04)
* A fully registered domain name. This tutorial uses `example.com` throughout. You can purchase a domain name on [Namecheap](https://namecheap.com/), get one for free on [Freenom](http://www.freenom.com/en/index.html), or use the domain registrar of your choice.
* The following DNS records set up for your server. You can follow [How To Set Up a Host Name with DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-host-name-with-digitalocean) for details on how to add them.
  - An **A** record with `example.com` pointing to your server's public IP address.
  - An **A** record with `www.example.com` pointing to your server's public IP address.
* An Nginx Server Block with Let's Encrypt configured, which can be set up by following [How To Set Up Let's Encrypt with Nginx Server Blocks on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-let-s-encrypt-with-nginx-server-blocks-on-ubuntu-16-04).

[Download the latest server package.](https://www.seafile.com/en/download)

## Step 2 — Title Case

## Deploying and Directory Layout

Supposed your organization's name is "haiwen", and you've downloaded `seafile-server_1.8.2_*` into your home directory. We suggest you to to use the following layout for your deployment:

```command
mkdir haiwen
mv seafile-server_* haiwen
cd haiwen
# after moving seafile-server_* to this directory
tar -xzf seafile-server_*
mkdir installed
mv seafile-server_* installed
```

Now you should have the following directory layout

```command
tree haiwen -L 2
haiwen
├── installed
│   └── seafile-server_1.8.2_x86-64.tar.gz
└── seafile-server-1.8.2
    ├── reset-admin.sh
    ├── runtime
    ├── seafile
    ├── seafile.sh
    ├── seahub
    ├── seahub.sh
    ├── setup-seafile.sh
    └── upgrade
```

The benefit of this layout is that:

- We can place all the config files for Seafile server inside "haiwen" directory, making it easier to manage.
- When you upgrade to a new version of Seafile, you can simply untar the latest package into "haiwen" directory. In this way you can reuse the existing config files in "haiwen" directory and don't need to configure again.

## Step # - Prepare MySQL Databases

Three components of Seafile Server need their own databases:

- ccnet server
- seafile server
- seahub

See [Seafile Server Components Overview](https://manual.seafile.com/overview/components.html) if you want to know more about the Seafile server components.

There are two ways to intialize the databases:

- let the `setup-seafile-mysql.sh` script create the databases for you.
- create the databases by yourself, or someone else (the database admin, for example)

We recommend the first way. The script would ask you for the root password of the mysql server, and it will create:

- database for ccnet/seafile/seahub.
- a new user to access these databases

However, sometimes you have to use the second way. If you don't have the root password, you need someone who has the privileges, e.g., the database admin, to create the three databases, as well as a mysql user who can access the three databases for you. For example, to create three databases: `ccnet-db` / `seafile-db` / `seahub-db` for ccnet/seafile/seahub respectively, and a mysql user "seafile" to access these databases run the following SQL queries:

```
create database `ccnet-db` character set = 'utf8';
create database `seafile-db` character set = 'utf8';
create database `seahub-db` character set = 'utf8';

create user 'seafile'@'localhost' identified by 'seafile';

GRANT ALL PRIVILEGES ON `ccnet-db`.* to `seafile`@localhost;
GRANT ALL PRIVILEGES ON `seafile-db`.* to `seafile`@localhost;
GRANT ALL PRIVILEGES ON `seahub-db`.* to `seafile`@localhost;
```

## Step # - Install the Necessary Dependencies

Introduction to the step. What are we going to do and why are we doing it?

First....

The Seafile server package requires the following packages to be installed on your system:

- python 2.7
- python-setuptools
- python-imaging
- python-ldap
- python-mysqldb
- python-urllib3
- python-memcache (or python-memcached)
- python-requests

```command
apt-get update
apt-get install -y python2.7 sudo python-pip python-setuptools python-imaging python-mysqldb python-ldap python-urllib3 \
openjdk-8-jre memcached libmemcached-dev zlib1g-dev pwgen curl openssl poppler-utils libpython2.7 libreoffice \
libreoffice-script-provider-python ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy nginx python-requests

pip install --upgrade pylibmc django-pylibmc
```

Next...

Finally...

<!--If showing a command, explain the command first by talking about what it does. Then show the command.-->

configuration file - show only  relevant parts & explain what needs to change

Now transition to the next step by telling the reader what's next.

## Step # Setup

```
cd seafile-server-*
./setup-seafile-mysql.sh  #run the setup script & answer prompted questions
```

If some of the prerequisites are not installed, the Seafile initialization script will ask you to install them.

The script will guide you through the settings of various configuration options.

**Seafile configuration options**

| Option              | Description                                                  | Note                                                         |
| ------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| server name         | Name of this seafile server                                  | 3-15 characters, only English letters, digits and underscore ('_') are allowed |
| server ip or domain | The IP address or domain name used by this server            | Seafile client program will access the server with this address |
| seafile data dir    | Seafile stores your data in this directory. Default it'll be placed in the current directory. | The size of this directory will increase as you put more and more data into Seafile. Please select a disk partition with enough free space. |
| fileserver port     | The TCP port used by Seafile fileserver                      | Default is 8082. If it's been used by other service, you can set it to another port. |

At this moment, you will be asked to choose a way to initialize Seafile databases:

```
-------------------------------------------------------
Please choose a way to initialize Seafile databases:
-------------------------------------------------------

[1] Create new ccnet/seafile/seahub databases
[2] Use existing ccnet/seafile/seahub databases
```

Which one to choose depends on if you have the root password.

- If you choose "1", you need to provide the root password. The script would create the databases and a new user to access the databases
- If you choose "2", the ccnet/seafile/seahub databases must have already been created, either by you, or someone else.

If you choose "[1] Create new ccnet/seafile/seahub databases", you would be asked these questions:

| Question                        | Description                                                  | Note                                                         |
| ------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| mysql server host               | the host address of the mysql server                         | the default is localhost                                     |
| mysql server port               | the port of the mysql server                                 | the default is 3306. Almost every mysql server uses this port. |
| root password                   | the password of mysql root account                           | the root password is required to create new databases and a new user |
| mysql user for Seafile          | the username for Seafile programs to use to access MySQL server | if the user does not exist, it would be created              |
| password for Seafile mysql user | the password for the user above                              |                                                              |
| ccnet dabase name               | the name of the database used by ccnet, default is "ccnet-db" | the database would be created if not existing                |
| seafile dabase name             | the name of the database used by Seafile, default is "seafile-db" | the database would be created if not existing                |
| seahub dabase name              | the name of the database used by seahub, default is "seahub-db" | the database would be created if not existing                |

If you choose "[2] Use existing ccnet/seafile/seahub databases", you would be asked these questions:

**related questions for "Use existing ccnet/seafile/seahub databases"**

| Question                        | Description                                                  | Note                                                         |
| ------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| mysql server host               | the host address of the mysql server                         | the default is localhost                                     |
| mysql server port               | the port of the mysql server                                 | the default is 3306. Almost every mysql server uses this port |
| mysql user for Seafile          | the user for Seafile programs to use to access MySQL server  | the user must already exists                                 |
| password for Seafile mysql user | the password for the user above                              |                                                              |
| ccnet dabase name               | the name of the database used by ccnet                       | this database must already exist                             |
| seafile dabase name             | the name of the database used by Seafile, default is "seafile-db" | this database must already exist                             |
| seahub dabase name              | the name of the database used by Seahub, default is "seahub-db" | this database must already exist                             |

If the setup is successful, you'll see the following output

![server-setup-succesfully](https://manual.seafile.com/images/Server-setup-successfully.png)

Now you should have the following directory layout :

```
#tree haiwen -L 2
haiwen
├── ccnet               # configuration files
│   ├── mykey.peer
│   ├── PeerMgr
│   └── seafile.ini
├── conf
│   └── ccnet.conf
│   └── seafile.conf
│   └── seahub_settings.py
├── installed
│   └── seafile-server_1.8.2_x86-64.tar.gz
├── seafile-data
├── seafile-server-1.8.2  # active version
│   ├── reset-admin.sh
│   ├── runtime
│   ├── seafile
│   ├── seafile.sh
│   ├── seahub
│   ├── seahub.sh
│   ├── setup-seafile.sh
│   └── upgrade
├── seafile-server-latest  # symbolic link to seafile-server-1.8.2
├── seahub-data
│   └── avatars
```

The folder `seafile-server-latest` is a symbolic link to the current Seafile server folder. When later you upgrade to a new version, the upgrade scripts update this link to point to the latest Seafile Server folder.

## Running Seafile Server

### Starting Seafile Server and Seahub Website

Under seafile-server-1.8.2 directory, run the following commands

```
./seafile.sh start # Start Seafile service
./seahub.sh start <port>  # Start seahub website, port defaults to 8000
```

Note: The first time you start Seahub, the script would prompt you to create an admin account for your Seafile Server.

After starting the services, you may open a web browser and visit Seafile web interface at (assume your server IP is 192.168.1.111):

```
http://192.168.1.111:8000/
```

Congratulations! Now you have successfully setup your private Seafile Server.

## Configure for nginx

1. create file `/etc/nginx/sites-available/seafile.conf`
2. Delete `/etc/nginx/sites-enabled/default`: `rm /etc/nginx/sites-enabled/default`
3. Create symbolic link: `ln -s /etc/nginx/sites-available/seafile.conf /etc/nginx/sites-enabled/seafile.conf`

```
server {
    listen 80;
    server_name seafile.example.com;

    proxy_set_header X-Forwarded-For $remote_addr;

    location / {
         proxy_pass         http://127.0.0.1:8000;
         proxy_set_header   Host $host;
         proxy_set_header   X-Real-IP $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header   X-Forwarded-Host $server_name;
         proxy_read_timeout  1200s;

         # used for view/edit office file via Office Online Server
         client_max_body_size 0;

         access_log      /var/log/nginx/seahub.access.log;
         error_log       /var/log/nginx/seahub.error.log;
    }

# If you are using [FastCGI](http://en.wikipedia.org/wiki/FastCGI),
# which is not recommended, you should use the following config for location `/`.
#
#    location / {
#         fastcgi_pass    127.0.0.1:8000;
#         fastcgi_param   SCRIPT_FILENAME     $document_root$fastcgi_script_name;
#         fastcgi_param   PATH_INFO           $fastcgi_script_name;
#
#         fastcgi_param     SERVER_PROTOCOL     $server_protocol;
#         fastcgi_param   QUERY_STRING        $query_string;
#         fastcgi_param   REQUEST_METHOD      $request_method;
#         fastcgi_param   CONTENT_TYPE        $content_type;
#         fastcgi_param   CONTENT_LENGTH      $content_length;
#         fastcgi_param     SERVER_ADDR         $server_addr;
#         fastcgi_param     SERVER_PORT         $server_port;
#         fastcgi_param     SERVER_NAME         $server_name;
#         fastcgi_param   REMOTE_ADDR         $remote_addr;
#          fastcgi_read_timeout 36000;
#
#         client_max_body_size 0;
#
#         access_log      /var/log/nginx/seahub.access.log;
#          error_log       /var/log/nginx/seahub.error.log;
#    }

    location /seafhttp {
        rewrite ^/seafhttp(.*)$ $1 break;
        proxy_pass http://127.0.0.1:8082;
        client_max_body_size 0;

        proxy_connect_timeout  36000s;
        proxy_read_timeout  36000s;
        proxy_send_timeout  36000s;

        send_timeout  36000s;
    }
    location /media {
        root /home/user/haiwen/seafile-server-latest/seahub;
    }
}
```

Nginx settings `client_max_body_size` is by default 1M. Uploading a file bigger than this limit will give you an error message HTTP error code 413 ("Request Entity Too Large").

You should use 0 to disable this feature or write the same value than for the parameter `max_upload_size` in section `[fileserver]` of [seafile.conf](https://manual.seafile.com/config/seafile-conf.html). Client uploads are only partly effected by this limit. With a limit of 100 MiB they can safely upload files of any size.

Tip for uploading very large files (> 4GB): By default Nginx will buffer large request bodies in temp files. After the body is completely received, Nginx will send the body to the upstream server (seaf-server in our case). But it seems when the file size is very large, the buffering mechanism dosen't work well. It may stop proxying the body in the middle. So if you want to support file uploads larger than 4GB, we suggest to install Nginx version >= 1.8.0 and add the following options to Nginx config file:

```
    location /seafhttp {
        ... ...
        proxy_request_buffering off;
    }
```

## Modify ccnet.conf and seahub_setting.py

### Modify ccnet.conf

You need to modify the value of `SERVICE_URL` in [ccnet.conf](https://manual.seafile.com/config/ccnet-conf.html) to let Seafile know the domain, protocol and port you choose. You can also modify `SERVICE_URL` via web UI in "System Admin->Settings". (**Warning**: If you set the value both via Web UI and ccnet.conf, the setting via Web UI will take precedence.)

```
SERVICE_URL = http://seafile.example.com
```

Note: If you later change the domain assigned to Seahub, you also need to change the value of `SERVICE_URL`.

### Modify seahub_settings.py

You need to add a line in `seahub_settings.py` to set the value of `FILE_SERVER_ROOT`. You can also modify `FILE_SERVER_ROOT` via web UI in "System Admin->Settings". (**Warning**: if you set the value both via Web UI and seahub_settings.py, the setting via Web UI will take precedence.)

```
FILE_SERVER_ROOT = 'http://seafile.example.com/seafhttp'
```

## Start Seafile and Seahub

```
./seafile.sh start
./seahub.sh start
```

## Conclusion

In this article you [configured/set up/built/deployed][something]. Now you can..
