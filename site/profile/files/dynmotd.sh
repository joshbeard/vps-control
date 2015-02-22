#!/usr/bin/env bash

PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`

MEMFREE=$(facter memoryfree)
MEM=$(facter memorysize_mb)


echo -e "\033[1;32m
  \033[0;37mHostname \033[0;35m= \033[1;32m`hostname`
\033[0;35m   \033[0;37mAddress \033[0;35m= \033[1;32m`facter ipaddress`
\033[0;35m    \033[0;37mKernel \033[0;35m= \033[1;32m`uname -sr`
\033[0;35m    \033[0;37mUptime \033[0;35m= \033[1;32m`uptime | sed 's/.*up ([^,]*), .*/1/'`
\033[0;35m    \033[0;37mMemory \033[0;35m= \033[1;32m${MEMFREE} / ${MEM}
\033[0;35m  \033[0;37mSessions \033[0;35m= \033[1;32m`who | grep $USER | wc -l | tr -d '[[:space:]]'`
\033[0;35m \033[0;37mProcesses \033[0;35m= \033[1;32m$PROCCOUNT of `ulimit -u`\033[0;37m
"
