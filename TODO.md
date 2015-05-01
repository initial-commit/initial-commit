* send X when asked to by installimage, to cut execution time (use expect)
* install git in order to version the system's configuration; directories and
  files to be versioned:
  * /etc/
  * /root/
  * /var/log/pacman.log
* format sdb with ext4, only if it contains no data
* automount sdb1 in /media/data/
  * feature to ease the development: also format if a magic file is available
    in /media/data/
* iptables -j LOG and deny any requests to the primary IP address
* iptables - activate port knocking for the primary IP address
