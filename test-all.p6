#!/usr/bin/env perl6
use v6;
use LWP::Simple;
use IO::Socket::SSL;

constant DEBUG = %*ENV<DEBUG>;

my $me = "stmuk";

my $url = "https://raw.githubusercontent.com/perl6/ecosystem/master/META.list";

my $content = LWP::Simple.get($url);

my @lines = $content.split("\n").grep(/$me/);

for @lines -> $line {
    my $dir = $line.split("/").[4];
    my $repo = "https://github.com/{$me}/{$dir}.git";
    shell "git clone $repo" unless $dir.IO.e;
#    shell "cd $dir && panda --force install . && cd ..";
}

