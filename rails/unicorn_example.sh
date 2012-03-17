#!/bin/sh

### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the unicorn web server
# Description:       starts unicorn
### END INIT INFO

. /lib/lsb/init-functions

test $DEBIAN_SCRIPT_DEBUG && set -v -x

USER=tualatrix
WEBSITE=dev.imtx.me

DAEMON=`which unicorn`
APP_DIR=/home/$USER/public_html/$WEBSITE/current/
DAEMON_OPTS="-c $APP_DIR/config/unicorn.rb -E production -D"
NAME=unicorn
DESC="Unicorn app for $USER"
PID=$APP_DIR/pids/unicorn.$WEBSITE.pid

test -x $DAEMON || exit 0

case "$1" in
  start)
        log_action_begin_msg "Starting $DESC"

        if test -e $PID ; then
            log_warning_msg " $DESC has already started."
            exit 1
        fi

        CD_TO_APP_DIR="cd /home/$USER/public_html/$WEBSITE/current"
        START_DAEMON_PROCESS="$DAEMON $DAEMON_OPTS"

        if [ `whoami` = root ]; then
          su - $USER -c "$CD_TO_APP_DIR > /dev/null 2>&1 && $START_DAEMON_PROCESS"
        else
          $CD_TO_APP_DIR && $START_DAEMON_PROCESS
        fi
        log_daemon_msg "$DESC is started."
        ;;
  stop)
        log_action_begin_msg "Stopping $DESC"

        if test -e "$PID" ; then
            kill -QUIT `cat $PID`
            log_daemon_msg "  $DESC has been stopped"
        else
            log_warning_msg "  No $DESC is running."
        fi
        ;;
  restart)
        log_action_begin_msg "Restarting $DESC"
        if test -e "$PID" ; then
            kill -USR2 `cat $PID`
            log_daemon_msg "  $DESC has been restart"
        else
            log_warning_msg "  No $DESC is running."
        fi
        ;;
  reload)
        log_action_begin_msg "Reloading $DESC"
        if test -e "$PID" ; then
            kill -HUP `cat $PID`
            log_daemon_msg "  $DESC has been reload"
        else
            log_warning_msg "  No $DESC is running."
        fi
        ;;
  *)
        echo "Usage: $NAME {start|stop|restart|reload}" >&2
        exit 1
        ;;
esac

exit 0
