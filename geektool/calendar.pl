#!/usr/bin/perl
# calendar.pl
#   Description
#
#   Written by Mike Cramer
#   Started on 2017-03-22

use strict ;
use warnings ;

use Getopt::Std ;
my %opts ;
getopts ( 'hdvno', \%opts ) ;

our $help_mode  = $opts{ 'h' } ;
our $debug_mode = $opts{ 'd' } ;

our $dryRun_mode = $opts{ 'n' } ;
our $output_mode = $opts{ 'o' } ;

if ( $help_mode ) {
    print "Usage: $0 -hdno\n" ;
    print join (
        "\n\t",
        (
            "Options:",
            "-h\thelp_mode",
            "-d\tget debug messages",
            "-n\tdon't print to screen",
            "-o\toutupt to file"
        )
    ) ;

    print "\n" ;

    exit 0 ;
}

open OUTPUTFILE, ">./cal.html" ;

use HTML::Template ;

# open the html template
my $template =
    HTML::Template->new (
    filename => 'calendar.tmpl' ) ;

sub debugMessage($$) {
    my ( $key, $value ) = @_ ;
    my $breakLine = "" ;
    $breakLine = "\n" if ( $value =~ /\n/ ) ;
    print "$key => $breakLine'$value'\n\n" if $debug_mode ;
}

sub passTemplateKV($ $) {
    my ( $key, $value ) = @_ ;
    debugMessage $key, $value ;
    $template->param ( $key => $value ) ;
}

my $systemUptimeResult = `uptime` ;

debugMessage "systemUptimeResult", $systemUptimeResult ;

my $TIME          = $systemUptimeResult =~ /^.*?up (.*?), \d+ user/ ? $1 : '' ;
my $USERCOUNT     = $systemUptimeResult =~ /(\d+ users?), /         ? $1 : '' ;
my $LOAD_AVERAGES = $systemUptimeResult =~ /load averages: (.*)/    ? $1 : '' ;

my $CALENDAR = `cal -h` ;
chop $CALENDAR ;

my $todaysDate = `date "+%e"` ;
$todaysDate = $todaysDate =~ /(\d+)/ ? $1 : '' ;

my $headDate  = $CALENDAR =~ /(.*)\nSu/                    ? $1 : '' ;
my $dayList   = $CALENDAR =~ /(Su.*Sa)/                    ? $1 : '' ;
my $leftDays  = $CALENDAR =~ /Sa((.*\n?)+\ ?)\b$todaysDate\b/ ? $1 : '' ;
my $rightDays = $CALENDAR =~ /\b$todaysDate\b(\ (.*\n?)+)/   ? $1 : '' ;
my $userList  = `who` ;

my $DAY = `date "+%A"` ;
chop $DAY ;
my $DATE = `date "+%Y-%m-%d"` ;
chop $DATE ;
my $JULIAN = `date "+%j"` ;
chop $JULIAN ;
my $LOCAL_TIME = `date "+%H:%M:%S"` ;
chop $LOCAL_TIME ;
my $LOCAL_TIME_ZONE = `date "+%z"` ;
chop $LOCAL_TIME_ZONE ;
my $UTC_TIME = `date -u "+%H:%M:%S"` ;
chop $UTC_TIME ;
my $UTC_DATE = `date -u "+%m-%d"` ;
chop $UTC_DATE ;
my $UTC_TIME_ZONE = `date -u "+%z"` ;
chop $UTC_TIME_ZONE ;
my $UNIX_TIME = `date "+%s"` ;
chop $UNIX_TIME ;

my $lastReboot = `who -b` ;
chop $lastReboot ;

passTemplateKV ( "RAW",             $systemUptimeResult ) ;
passTemplateKV ( "CALENDARHEAD",    $headDate ) ;
passTemplateKV ( "CALENDARLIST",    $dayList ) ;
passTemplateKV ( "CALENDARLEFT",    $leftDays ) ;
passTemplateKV ( "CALENDARTODAY",   $todaysDate ) ;
passTemplateKV ( "CALENDARRIGHT",   $rightDays ) ;
passTemplateKV ( "TIME",            $TIME ) ;
passTemplateKV ( "USERCOUNT",       $USERCOUNT ) ;
passTemplateKV ( "USERLIST",        $userList ) ;
passTemplateKV ( "LOAD_AVERAGES",   $LOAD_AVERAGES ) ;
passTemplateKV ( "DAY",             $DAY ) ;
passTemplateKV ( "DATE",            $DATE ) ;
passTemplateKV ( "JULIAN",          $JULIAN ) ;
passTemplateKV ( "LOCAL_TIME",      $LOCAL_TIME ) ;
passTemplateKV ( "LOCAL_TIME_ZONE", $LOCAL_TIME_ZONE ) ;
passTemplateKV ( "UTC_TIME",        $UTC_TIME ) ;
passTemplateKV ( "UTC_DATE",        $UTC_DATE ) ;
passTemplateKV ( "UTC_TIME_ZONE",   $UTC_TIME_ZONE ) ;
passTemplateKV ( "UNIX_TIME",       $UNIX_TIME ) ;

# fill in some parameters
# $template->param( HOME => $ENV{HOME} );
# $template->param( PATH => $ENV{PATH} );

### send the obligatory Content-Type and print the template output
# print "Content-Type: text/html\n\n"; ## for some reason, Geektool renders this line litterally.
print $template->output unless $dryRun_mode ;

print OUTPUTFILE $template->output if $output_mode ;

