#!/usr/bin/env perl
# .welcome.pl

use feature ":5.16";

use strict;
use warnings;

# use Data::Dumper::Concise;

my ( $command, $last_login, $message, $user, $term, $ip_address,
    $time_last_login, $still_online );

my ( $filter_user, $filter_term, $filter_ip_address, $filter_time_last_login,
    $filter_still_online );

for (`uname`) {
    if (/linux/) {
        $command = 'last -1i $USER | head -1'

          $last_login = `$command`;

        $filter_user            = /^(.*?)\s/;
        $filter_term            = /^.*?\s+(.*?)\s/;
        $filter_ip_address      = /^.*?\s+.*?\s+(\d+\.\d+\.\d+\.\d+)\s/;
        $filter_time_last_login = /^.*?\s+.*?\s+.*?\s+(.*?:\d\d)/;
        $filter_still_online    = /^.*?\s+.*?\s+.*?\s+.*?:\d\d\s+(.*)/;

    }
    elsif (/darwin/) {
        $command = 'last -1 $USER | head -1';

        $last_login = `$command`;

        $filter_user            = /^(.*?)\s/;
        $filter_term            = /^.*?\s+(.*?)\s/;
        $filter_ip_address      = /^.*?\s+.*?\s+(\d+\.\d+\.\d+\.\d+)\s/;
        $filter_time_last_login = /^.*?\s+.*?\s+.*?\s+(.*?:\d\d)/;
        $filter_still_online    = /^.*?\s+.*?\s+.*?\s+.*?:\d\d\s+(.*)/;

    }
    else {
        exit 1;
    }
}

if ($last_login) {

    $user            = $last_login =~ $filter_user            ? $1 : '';
    $term            = $last_login =~ $filter_term            ? $1 : '';
    $ip_address      = $last_login =~ $filter_ip_address      ? $1 : '';
    $time_last_login = $last_login =~ $filter_time_last_login ? $1 : '';
    $still_online    = $last_login =~ $filter_still_online    ? $1 : '';

    $message = 'Last login: ';
    if ($user) { $message .= $user; }

    # if ($term){ $message .= ' ' . $term ; }
    if ($ip_address)      { $message .= " - " . $ip_address; }
    if ($time_last_login) { $message .= ' - ' . $time_last_login; }
    if ($still_online)    { $message .= ' - ' . $still_online; }

    say $message;
}
