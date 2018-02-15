#!/usr/local/bin/bash

screenName=$1 && shift

t list add lewd $screenName
t mute $screenName
t unfollow $screenName
