#!/usr/local/bin/perl
# ref.pl
#   Description
#
#   Written by Mike Cramer
#   Started on DATE

# use 5.18.0;
use strict;
use warnings;



sub printLineItem {
  my ($line) = @_;
  print " - $line\n";
}

sub displayHash {
  my ( $name, $hash ) = @_;
  print "$name:\n";
  my $maxlength = 0;
  foreach my $key ( keys %$hash ) {
    if ( $maxlength < length $key ) {
      $maxlength = length $key;
    }
  }
  $maxlength++;
  $maxlength++;
  foreach my $key ( sort keys %$hash ) {
    my $value = $hash->{$key};
    my $line  = "$key:";
    for ( my $var = 0; $var < ( $maxlength - length $key ); $var++ ) {
      $line .= " ";
    }
    $line .= $hash->{$key};
    printLineItem $line;
  }
  print "\n";
}

sub displayArray {
  my ( $name, $array ) = @_;
  print "$name:\n";
  foreach my $anItem (@$array) {
    printLineItem $anItem;
  }
  print "\n";
}

sub displayScalar {
  my ( $name, $scalar ) = @_;
  print "$name:\n";
  printLineItem $scalar;
  print "\n";
}

sub displayStuff {

  displayArray "INC", \@INC;
  displayHash "INC",  \%INC;
  displayHash "ENV",  \%ENV;

  # displayArray "_",  \@_;
  # displayScalar "_", $_;

  my $otherVar = {
    'PROCESS_ID           =>  $$   ' => $$,
    'PROGRAM_NAME         =>  $0   ' => $0,
    'REAL_GROUP_ID        =>  $(   ' => $(,
    'EFFECTIVE_GROUP_ID   =>  $)   ' => $),
    'REAL_USER_ID         =>  $<   ' => $<,
    'EFFECTIVE_USER_ID    =>  $>   ' => $>,
    'SUBSCRIPT_SEPARATOR  =>  $;   ' => $;,
    'OLD_PERL_VERSION     =>  $]   ' => $],
    'PERL_VERSION         =>  $^V  ' => $^V,
    'OSNAME               =>  $^O  ' => $^O,
    'EXECUTABLE_NAME      =>  $^X  ' => $^X,
  };

  displayHash "other", $otherVar;
}

displayStuff
