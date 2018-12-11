#!/usr/bin/env perl
# calendar.pl
#   Description
#
#   Written by Mike Cramer
#   Started on 2017-03-22

use feature ':5.16';
use strict;
use warnings;

use autodie qw(open close);

use English qw( -no_match_vars );

my $EMPTY = '';

use Getopt::Std;
my %opts;
getopts( 'hdvno', \%opts );
    
my $help_mode  = $opts{'h'};
my $debug_mode = $opts{'d'};

my $dry_run_mode = $opts{'n'};
my $output_mode  = $opts{'o'};

if ($help_mode) {
    say "Usage: $PROGRAM_NAME -hdno";
    say join
        "\n\t",
        (
        'Options:',
        "-h\thelp_mode",
        "-d\tget debug messages",
        "-n\tdon't print to screen",
        "-o\toutupt to file"
        );

    exit 0;
}

use HTML::Template;

# open the html template
my $template = HTML::Template->new( filename => 'calendar.tmpl' );

my $system_uptime_result = `uptime`;

my $uptime_time
    = $system_uptime_result =~ /^.*?up (.*?), \d+ user/ ? $1 : $EMPTY;
my $usercount = $system_uptime_result =~ /(\d+ users?), / ? $1 : $EMPTY;
my $load_averages
    = $system_uptime_result =~ /load averages: (.*)/ ? $1 : $EMPTY;

my $calendar = `cal -h`;
chop $calendar;

use Time::Piece;

my $tp_localtime = localtime;
my $tp_gmtime    = gmtime;

my $todays_date = $tp_localtime->mday;

my $head_date  = $calendar =~ /(.*)\nSu/                       ? $1 : $EMPTY;
my $day_list   = $calendar =~ /(Su.*Sa)/                       ? $1 : $EMPTY;
my $left_days  = $calendar =~ /Sa((.*\n?)+ ?)\b$todays_date\b/ ? $1 : $EMPTY;
my $right_days = $calendar =~ /\b$todays_date\b( (.*\n?)+)/    ? $1 : $EMPTY;
my $user_list  = `who`;

my $last_reboot = `who -b`;
chop $last_reboot;

sub pad_str {
    my ( $padding_char, $input, $length, $after ) = @_;
    if ( length $padding_char == 1 && $input && $length ) {
        if ( length $input < $length ) {
            my $next_input = $padding_char . $input;
            if ($after) { $next_input = $input . $padding_char; }
            return pad_str( $padding_char, $next_input, $length, $after );
        }
        return $input;
    }
    return;
}

sub chop_str {
    my ($input_string) = @_;
    if ($input_string) {
        return substr $input_string, 0, ( length $input_string ) - 1;
    }
    return;
}

sub chomp_str {
    my ($input_string) = @_;
    if ($input_string) {
        return substr $input_string, 1, ( length $input_string );
    }
    return;
}

my %data_hash = (
    'RAW'             => $system_uptime_result,
    'CALENDARHEAD'    => $head_date,
    'CALENDARLIST'    => $day_list,
    'CALENDARLEFT'    => $left_days,
    'CALENDARTODAY'   => $tp_localtime->mday,
    'CALENDARRIGHT'   => $right_days,
    'TIME'            => $uptime_time,
    'USERCOUNT'       => $usercount,
    'USERLIST'        => $user_list,
    'LOAD_AVERAGES'   => $load_averages,
    'DAY'             => $tp_localtime->fullday,
    'DATE'            => $tp_localtime->date,
    'JULIAN'          => $tp_localtime->yday,
    'LOCAL_TIME'      => $tp_localtime->time,
    'LOCAL_TIME_ZONE' => chop_str( $tp_localtime->tzoffset ),
    'UTC_TIME'        => $tp_gmtime->time,
    'UTC_DATE'        => pad_str( 0, $tp_localtime->mon, 2 ) . "-"
        . pad_str( 0, $tp_localtime->mday, 2 ),
    'UTC_TIME_ZONE' => $tp_gmtime->tzoffset,
    'UNIX_TIME'     => $tp_gmtime->epoch,
);

foreach my $key ( keys %data_hash ) {
    my $value = $data_hash{$key};

    $template->param( $key => $value );
}

# fill in some parameters
# $template->param( HOME => $env{HOME} );
# $template->param( PATH => $env{PATH} );

### send the obligatory Content-Type and print the template output
# print "Content-Type: text/html\n\n"; ## for some reason, Geektool renders this line litterally.
if ( !$dry_run_mode ) { print $template->output; }

if ($output_mode) {
    open my $calendar_outfile, '>', './cal.html';
    print {$calendar_outfile} $template->output;
    close $calendar_outfile;
}
