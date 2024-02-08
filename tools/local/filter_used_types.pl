#!/usr/bin/perl

use warnings;
use strict;

#(system("make native.distclean") == 0) || die;
#(system("make native.prep") == 0) || die;

#my $pid = open my $command_out, "-|";
#die "$0: fork: $!" unless defined $pid;
#
#if ($pid == 0) {
#    # child
#    open STDERR, ">&", \*STDOUT  or die "$0: open: $!";
#    exec "make", "native.compile";
#    exit 0;
#}
#
#
#exit 0;

while (1) {
    open (my $makecmd_out, "-|", "make native.compile -k 2>&1") || die;

    my $missing_types = {};

    while (<$makecmd_out>) {
        chomp;
        if (/unknown type name\W+(\w+?)_t\W/) {
            $missing_types->{$1} = 1;
        }
    }

    while(my ($k, $v) = each(%$missing_types)) {
        print "type: $k, $v\n";
    }

    close($makecmd_out);
    last;
}