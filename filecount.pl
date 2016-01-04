#!/usr/bin/perl
# filecount.pl
#

use warnings;
use strict;
use Cwd qw(abs_path);
use File::Find ();

# Vars
my $total = 0;
my $ln = 15;
my $vbar = "|";
my $skip = 0;
my $name;
my $dirname;
my $lf = "\n";

# Recursive search
sub find(&@) { &File::Find::find }
@ARGV = qw(.) unless @ARGV;
print "="x$ln, " File Count ", "="x$ln, $lf;

find { getcount($name) if -d } @ARGV;

sub getcount {
$dirname = "$_";
opendir my $DIR, $dirname or $skip =1;
if ($skip) {$skip=0;} else {
  my $count = grep -f "$dirname/$_", readdir $DIR;
# If you want to hide the full path uncomment below line and commet out the next one
# print "$vbar ",$count, " "x (15-length($count)), $dirname, $lf;
  print "$vbar ",$count, " "x (15-length($count)), abs_path($dirname), $lf;
  $total = $total + $count;
  }
}
print "="x$ln, " $total ", "="x$ln, $lf;
