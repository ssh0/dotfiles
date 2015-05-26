#/bin/sh
#
if [ $# = 0 ]; then
    echo "need argument 'COMMAND'" 1>&2
    exit 0
else
    COMMAND=$1
fi
subject="command \"${COMMAND}\" done"
result=`${COMMAND}`
wait; sleep 1;
python /home/shotaro/Workspace/python/sendGmail.py -t fuji101ijuf@gmail.com -s "${subject}" -b "${result}"
exit 0
