# do-seafile-1804

[do.co/style]([https://do.co/style)](https://do.co/style)) - [Markdown previewer]([https://www.digitalocean.com/community/markdown)](https://www.digitalocean.com/community/markdown))

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
* One Ubuntu 16.04 server set up by following [this Ubuntu 16.04 initial server setup tutorial](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04), including a sudo non-root user and a firewall.
* A LEMP stack installed by following this [LEMP on Ubuntu 18.04 tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04)
* (Optional) If software such as Nginx needs to be installed, link to the proper article describing how to install it.

[Download the latest server package.](https://www.seafile.com/en/download)

## Step 2 — Title Case

## Deploying and Directory Layout

Supposed your organization's name is "haiwen", and you've downloaded `seafile-server_1.8.2_*` into your home directory. We suggest you to to use the following layout for your deployment:

```
mkdir haiwen
mv seafile-server_* haiwen
cd haiwen
# after moving seafile-server_* to this directory
tar -xzf seafile-server_*
mkdir installed
mv seafile-server_* installed
```

Now you should have the following directory layout

```
#tree haiwen -L 2
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

## Step #

## Step # — Title Case

Another introduction

Your content

Transition to the next step.

## Conclusion

In this article you [configured/set up/built/deployed][something]. Now you can..

## MARKDOWN EXAMPLES

This is _italics_ and this is **bold**.

Only use italics and bold for specific things. Learn more at [https://do.co/style#bold-and-italics](https://do.co/style#bold-and-italics)

This is `inline code`. Use it for referencing package names and commands.

Here's a command someone types in the Terminal:

​```command

sudo nano /etc/nginx/sites-available/default

​```

Here's a configuration file. The label on the first line lets you clearly state the file that's being shown or modified:

​```nginx

[label /etc/nginx/sites-available/default]

server {

    listen 80 default_server;
    
    listen [::]:80 default_server ipv6only=on;
    
    root <^>/usr/share/nginx/html<^>;
    
    index index.html index.htm;
    
    server_name localhost;
    
    location / {
    
        try_files $uri $uri/ =404;
    
    }

}

​```

Here's output from a command:

​```

[secondary_label Output]

Could not connect to Redis at 127.0.0.1:6379: Connection refused

​```

Learn about formatting commands and terminal output at [https://do.co/style#code](https://do.co/style#code)

Key presses should be written in ALLCAPS with in-line code formatting: `ENTER`.

Use a plus symbol (+) if keys need to be pressed simultaneously: `CTRL+C`.

This is a <^>variable<^>.

This is an `<^>in-line code variable<^>`

Learn more about how to use variables to highlight important items at [https://do.co/style#variables](https://do.co/style#variables)

Use `<^>your_server_ip<^>` when referencing the IP of the server.  Use `111.111.111.111` and `222.222.222.222` if you need other IP addresses in examples.

Learn more about host names and domains at [https://do.co/style#users-hostnames-and-domains](https://do.co/style#users-hostnames-and-domains)

<$>[note]

**Note:** This is a note.

<$>

<$>[warning]

**Warning:** This is a warning.

<$>

Learn more about notes at [https://do.co/style#notes-and-warnings](https://do.co/style#notes-and-warnings)

Screenshots should be in PNG format and hosted on imgur. Embed them in the article using the following format:

![Alt text for screen readers](/path/to/img.png)

Learn more about images at [https://do.co/style#images-and-other-assets](https://do.co/style#images-and-other-assets)

-->
`````

`````