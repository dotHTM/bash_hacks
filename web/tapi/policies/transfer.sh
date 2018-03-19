#!/usr/local/bin/bash

source ./policy_config.bash

transfer(){
	a=$1 && shift
	b=$1 && shift
	a_list=$1 && shift

	if [[ -z $a || -z $b || -z $a_list ]];then
		exit "embpty parameter"
	else
	
		t set active "$a" && \
		list_members=`t list members "$a/$a_list"`
		if [[ -n "$list_members" ]]; then
			t set active "$b" && \
			t follow $list_members && \
			t set active "$a" && \
			t unfollow $list_members && \
			t list remove "$a/$a_list" $list_members && \
			echo "==== Moved $a_list from $a to $b ===="
		else
			echo "==== No One to move… $a_list from $a to $b ===="
		fi
	fi
}

transfer $MAIN_ACCOUNT $SECONDARY_ACCOUNT $MAIN_TO_SECONDARY_TRANSFER_LIST
transfer $SECONDARY_ACCOUNT $MAIN_ACCOUNT $SECONDARY_TO_MAIN_TRANSFER_LIST
