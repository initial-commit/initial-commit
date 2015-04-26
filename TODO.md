* install git in order to version the system's configuration; directories and
  files to be versioned:
  * /etc/
  * /root/
  * /var/log/pacman.log
* set the hostname of the root box according to variables
* format sdb with ext4, only if it contains no data
* automount sdb1 in /media/data/
  * feature to ease the development: also format if a magic file is available
    in /media/data/
