#!/usr/local/bin/perl
# calendar.pl
#   Description
#
#   Written by Mike Cramer
#   Started on 2017-03-22

use strict;
use warnings;

use HTML::Template;

# open the html template
my $template = HTML::Template->new( filename => '/Users/cramerm/Projects/github/bash_hacks/geektool/calendar.tmpl' );



my $systemUptimeResult = `uptime`;

my $TIME = $systemUptimeResult =~ /^.*?up (.*?), \d+ user/ ? $1 : '';
my $USERCOUNT = $systemUptimeResult =~ /\b(\d+ user\w), / ? $1 : '';
my $LOAD_AVERAGES = $systemUptimeResult =~ /load averages: (.*)/ ? $1 : '';

my $CALENDAR = `cal` ;
chop $CALENDAR;

my $todaysDate            = `date "+%e"`;
$todaysDate = $todaysDate =~ /(\d+)/ ? $1 : '';

my $headDate = $CALENDAR =~ /(.*)\nSu/ ? $1 : '';
my $dayList = $CALENDAR =~ /(Su.*Sa)/ ? $1 : '';
my $leftDays = $CALENDAR =~ /Sa((.*\n?)+\ )$todaysDate\b/ ? $1 : '';
my $rightDays = $CALENDAR =~ /\b$todaysDate(\ (.*\n?)+)/ ? $1 : '';
my $userList = `who`;

my $DAY             = `date "+%A"`;
chop $DAY;
my $DATE            = `date "+%Y-%m-%d"`;
chop $DATE;
my $JULIAN          = `date "+%j"`;
chop $JULIAN;
my $LOCAL_TIME      = `date "+%H:%M:%S"`;
chop $LOCAL_TIME;
my $LOCAL_TIME_ZONE = `date "+%z"`;
chop $LOCAL_TIME_ZONE;
my $UTC_TIME        = `date -u "+%H:%M:%S"`;
chop $UTC_TIME;
my $UTC_TIME_ZONE   = `date -u "+%z"`;
chop $UTC_TIME_ZONE;
my $UNIX_TIME       = `date "+%s"`;
chop $UNIX_TIME;

my $lastReboot = `who -b`;
chop $lastReboot;


$template->param( RAW             => $systemUptimeResult );
$template->param( CALENDARHEAD    => $headDate );
$template->param( CALENDARLIST    => $dayList );
$template->param( CALENDARLEFT    => $leftDays );
$template->param( CALENDARTODAY   => $todaysDate );
$template->param( CALENDARRIGHT   => $rightDays );
$template->param( TIME            => $TIME               );
$template->param( USERCOUNT       => $USERCOUNT          );
$template->param( USERLIST        => $userList           );
$template->param( LOAD_AVERAGES   => $LOAD_AVERAGES      );
$template->param( DAY             => $DAY                );
$template->param( DATE            => $DATE               );
$template->param( JULIAN          => $JULIAN             );
$template->param( LOCAL_TIME      => $LOCAL_TIME         );
$template->param( LOCAL_TIME_ZONE => $LOCAL_TIME_ZONE    );
$template->param( UTC_TIME        => $UTC_TIME           );
$template->param( UTC_TIME_ZONE   => $UTC_TIME_ZONE      );
$template->param( UNIX_TIME       => $UNIX_TIME          );

# fill in some parameters
# $template->param( HOME => $ENV{HOME} );
# $template->param( PATH => $ENV{PATH} );

### send the obligatory Content-Type and print the template output
# print "Content-Type: text/html\n\n"; ## for some reason, Geektool renders this line litterally.
print $template->output;


