#!/usr/bin/perl
 
# Copyright (C) 2007-2009 Eric L. Wilhelm
 
use warnings;
use strict;
 
=head1 NAME
 
vc-checkup - cached version-control status checker
 
=head1 About
 
This program checks the status of a version-controlled checkout and
prints a message if something has changed.  It is suitable as a cron job
for tracking changes to configuration or code directories.
  
It keeps a cache in your ~/.vc_checkup/ directory and is currently
hard-coded to create a reminder message every 6 hours after a change.
Your help and input are welcome.
 
=head1 See Also
 
This uses L<VCfs> to handle the version-control actions. 
 
=cut
 
package bin::vc_checkup;
 
use Cwd;
 
my $app_dir   = $ENV{HOME} . '/.vc_checkup/';
my $cache_dir = $app_dir . '/cache/';
 
sub main {
  my (@args) = @_;
 
  my $now = time;
 
  my ($dir) = @args;
 
  my $pwd = Cwd::cwd();
  if($dir) {
    chdir($dir) or die "cannot chdir $dir";
    $dir = Cwd::abs_path($dir);
  }
  else {
    $dir = $pwd;
  }
 
  my $cachefile = $cache_dir . sub {
    my $p = shift;
    $p =~ s#^/+##;
    $p =~ s#/+#%2F#g;
    return($p);
  }->($dir);
  my %status = VCfs->new('.')->status;
 
  unless(%status) {
    # if it has been checked-in, clean the slate
    if(-e $cachefile) {
      unlink($cachefile) or die "cannot unlink '$cachefile' $!";
    }
    return;
  }
 
  my $st = YAML::Syck::Dump(\%status);
 
  if(-e $cachefile) {
    my $cache = YAML::Syck::LoadFile($cachefile);
    # check if it changed or needs reminding
    my $notice;
    if($cache->{status} eq $st) {
      my $was = $cache->{updated} || $cache->{detected};
      my $delta = 60*60*6; # XXX config
      if($was + $delta > $now) {
        return; # not worried yet
      }
 
      $cache->{updated} = $now;
      $notice = 'reminder';
    }
    else {
      delete($cache->{updated});
      $cache->{detected} = $now;
      $cache->{status}   = $st;
      $notice = 'change detected';
    }
    $notice or die "ack";
    print "$notice\n\n$st";
 
    YAML::Syck::DumpFile($cachefile, $cache);
  }
  else {
    # create a new cache
 
    unless(-d $cache_dir) {
      (-e $cache_dir)
        and die "'$cache_dir' exists, but is not a directory";
      require File::Path;
      File::Path::mkpath($cache_dir);
    }
 
    print "change detected\n\n$st";
    YAML::Syck::DumpFile($cachefile, {
      detected => $now, 
      status   => $st,
    });
  }
}
 
package main;
 
if($0 eq __FILE__) {
  bin::vc_checkup::main(@ARGV);
}
 
# vi:ts=2:sw=2:et:sta
my $package = 'bin::vc_checkup';
