!!! The documentation is not set in stone !!!


Overview
========

The purpose of this box (the root box) is to manage all other subsystems.

The purpose of this repo is to bootstrap the said root box to the point where
all subsystems are ready to run.

It is starting from the base installation of an ArchLinux setup.

The container host (a.k.a. root box)
------------------------------------

This kind of box only offers lxc and aggregates logging (syslog-ng) from its
containers.

Services running:

* ssh
* syslog-ng (buffering and forwarding to analytics, then empty the buffer)
* lxc
* health monitoring for lxc containers
* a lightweight daemon which monitors and restarts the previous services as
  needed (and logs their downtime to syslog-ng)

Turning an arch host into an lxc host
for various systems.

1. Install packages
  * for actual functionality: augeas lxc syslog-ng
  * for monitoring and administration: cpupower hdparm htop lshw tree wget
    iotop git net-tools tree ethtool 
  * customizations: rxvt-unicode vim zsh
  * from AUR: packer liquidprompt
  * for compiling from AUR: binutils jshon packer fakeroot

The data box
------------

This kind of box has a syslog-ng server which forwards its messages to an event
store (e.g. mongodb).

Services running:

* syslog-ng
* mongodb
* an app which gathers intelligence from the event store and summarizes the
  information (an analytics box)
* a small app which can push notifications to interested parties when certain
  events occur

The git box
-----------

This kind of box hosts git repositories. Some of them belong to the users, but
some are for the infrastructure itself.

The ones for the infrastructure hold apps running in this "cloud" and are
located under `system/`

Once a system's repository's develop branch is pushed:

1. A new container for that type is created and run, but in a staging
   environment (i.e. accessible via another hostname or port)
2. If a staging environment already exists, it is brought down

Once a system's repository's master branch is pushed:

3. Run 1 and 2, notify the application to do it's health checks, and if
   everything is ok:
   block new connections to the current box of this type and forward them to
   the new box. When the old lxc box does not have any connections, shut it
   down and remove it

All these steps are done by sending messages over syslog to the root box, which
triggers the corresponding processes

The www box
-----------

This serves one or more web apps which have business value.

The security box
----------------

This stores all sensitive information about its users like:

* (app, credentials)
* public keys

and sends back responses to other apps, like:

* if an user tries to authenticate, given an (app, credentials) tuple, it
  replies with 0 or 1 if the authentication failed or succeeded
* if an app wants to store some data about the user, it can do so (encrypted)

This type of box is not user-facing.

This box can also store sensitive information about the network (like ip
addresses) and assets (like LDAP).

The honey box
-------------

For every user-accessible system, there's a honeypot which makes the attacker
think he's hacked the system 

The mail box
------------

TODO

The irc box
-----------

TODO
