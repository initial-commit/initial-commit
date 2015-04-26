Initial commit
==============
system for learning programming hands-on, based on automated testing and community peer-review.
Infrastructure
--------------
Hardware assets: distributed, easily scalable, deploy on push to origin/master (with testing beforehand).
Uses containers (lxc), manual scripting, no magic
Contained boxes:
* root, runs on the bare metal, contains
  * ssh
  * system-ng
  * HAProxy
* www, the interface
  * users can see their status
  * create a fork of a course
  * upload their public keys
* judge, a highly volatile box, it’s brought up with a new application, runs the tests, and exits
  * it has a job-specific timeout
  * most probably on top of docker (aufs speeds up booting it up)
  * by default, it does not allow internet access and it only allows reads from the FS
  * some restricted access to the internal network for reporting statistics about the test runner and SUT
* git, holds the repositories, types:
  * system/ for this infrastructure itself
  * courses/ for courses
  * forks/ - users’ forks of the courses
* analytics, a mongodb which gathers all the data, mainly from system-ng, but applications can also send data
  * Long term: we don’t know what we’ll do with this data yet, but we’ll learn from it to better protect the infrastructure, or improve the workflow and/or the courses (maybe some ML too)
  * append-only
* honeypot, to further learn from those who are too smart
Plan
----
* Make the basic infrastructure for deployment (all 5 boxes)
* Write the app v0.1: it only accepts email subscriptions: we’ll announce interested parties when it’s ready
* When the number of subscriptions is reached, proceed to next step (open issue)
* A basic course in which we teach TDD, by writing an xUnit-compatible tool, from scratch
  * at the beginning, it’s more for showing off how it works (long commit messages, blog-style)
  * for people who don’t know TDD yet
  * focus is on teaching how to do TDD and how to use the system
  * every commit has a discussion thread
* When the number of subscriptions is reached, start the course (maybe never, open issue)
* 1 year passes…
* .. Further ideas:
  * courses for the same thing but different programming languages
  * different technologies
  * different subjects
Non-Functional requirements
--------------------------
* In case of a disaster:
  * the entire server with all its boxes must be re-installed and reconfigured from scratch in max. 10 minutes
  * normal operation must resume (e.g. pending log entries are flushed to analytics, judge jobs with unknown results are (re)queued)
* The data of all applications and boxes lives on a secondary disk (sdb), which is not re-formatted in case of a disaster recovery procedure
* Everything is logged and stored to the analytics box
* (not at first) sdb is backed-up every hour
  * (at first, backups are made to the personal boxes of the devs)
* any box can be updated seamlessly
