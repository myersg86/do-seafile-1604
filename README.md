# do-seafile-1804

[https://do.co/style)](https://do.co/style) - [Markdown previewer](https://www.digitalocean.com/community/markdown)

# How to install and configure Seafile server on an Ubuntu 18.04 droplet

Introductory paragraph about the topic that explains what this topic is about and why the reader should care; what problem does it solve?

In this guide, you will [configure/set up/build/deploy] [some thing]...

When you're finished, you'll be able to...

## Prerequisites

<!-- Prerequisites are important. Learn more at [https://do.co/style#prerequisites](https://do.co/style#prerequisites) -->

Before you begin this guide you'll need the following:

- [number of servers] <OS and OS Version> server(s) <!-- Also specify the amount of RAM the server needs if relevant. -->

- A non-root user with sudo privileges (<insert link to Initial Server Setup article for the OS used in this tutorial>) explains how to set this up.)

- (Optional) If software such as Nginx needs to be installed, link to the proper article describing how to install it.

- List any other accounts needed, such as Github or other services.

## Step 1 — Doing Something

<!-- For more information on steps, see [https://do.co/style/#steps](https://do.co/style/#steps) -->

Introduction to the step. What are we going to do and why are we doing it?

First....

Next...

Finally...

<!--If showing a command, explain the command first by talking about what it does. Then show the command.-->

configuration file - show only  relevant parts & explain what needs to change

Now transition to the next step by telling the reader what's next.

## Step 2 — Title Case

Another introduction

Your content

Transition to the next step.

## Step 3 — Title Case

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

```command

sudo nano /etc/nginx/sites-available/default

```

Here's a configuration file. The label on the first line lets you clearly state the file that's being shown or modified:

```nginx

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

```

Here's output from a command:

```

[secondary_label Output]

Could not connect to Redis at 127.0.0.1:6379: Connection refused

```

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
