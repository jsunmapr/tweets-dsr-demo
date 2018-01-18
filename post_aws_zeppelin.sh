#!/bin/bash
#
# usage:
#	post_aws_zeppelin.sh <WaitHandle>
#


HANDLE_URL=${1}

# Log should match all post-*-info scripts
LOG=/tmp/post-stack-config.log

exec_and_log() {
    echo $* >> $LOG
    $* || {
	echo "============== $* failed at "`date` >> $LOG
	return 1
    }
	return 0
}

if [ -z "${HANDLE_URL:-}" ] ; then
	echo "post_aws_zeppelin.sh: No URL provided ... exiting" | tee -a $LOG
	exit 0
fi

# Grab the launch-index from the instance meta-data.  For Spot
# clusters, ALL nodes will have a launch-index of 0, so we'll
# try to be a bit smarter.
#
murl_top=http://169.254.169.254/latest/meta-data
launch_index=$(curl -f $murl_top/ami-launch-index)
[ -z "$launch_index" ] &&  launch_index=1
if [ ${launch_index} -eq 0  -a  -r /tmp/maprhosts ] ; then
	cnode=$(grep `hostname` /tmp/maprhosts | awk '{print $2}' )
	hindex=${cnode#*NODE}
	[ -n "$hindex" ] && launch_index=$hindex 
fi

THIS_HOST=`/bin/hostname`
echo "post_aws_zeppelin: Executing on $THIS_HOST (node $launch_index)" | tee -a $LOG

private_ip=$(hostname -I)
public_ip=$(curl -f $murl_top/public-ipv4)

MAPR_HOME=${MAPR_HOME:-/opt/mapr}

CFN_SIGNAL=/opt/aws/bin/cfn-signal

	exec_and_log  $CFN_SIGNAL -e 0  -r "Stack_Info" \
		-i "Zeppelin_UI" -d "https://${public_ip}:9995" "$HANDLE_URL"

	exec_and_log  $CFN_SIGNAL -e 0  -r "Stack_Info" \
		-i "MCS_UI" -d "https://${public_ip}:8443" "$HANDLE_URL"

	exec_and_log  $CFN_SIGNAL -e 0  -r "Stack_Info" \
		-i "DRILL_UI" -d "https://${public_ip}:8047" "$HANDLE_URL"

	exec_and_log  $CFN_SIGNAL -e 0  -r "Stack_Info" \
		-i "UI_USER" -d "mapr" "$HANDLE_URL"

	exec_and_log  $CFN_SIGNAL -e 0  -r "Stack_Info" \
		-i "UI_PASSWORD" -d "mapr" "$HANDLE_URL"

	exec_and_log  $CFN_SIGNAL -e 0  -r "Stack_Info" \
		-i "OS_SSH_USER" -d "centos" "$HANDLE_URL"


