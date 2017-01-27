#!/usr/local/bin/perl
use strict; use feature qw/say/;
# Requires CGI.pm, JSON::MaybeXS and LWP::Simple modules.
use CGI qw/remote_addr redirect virtual_host user_agent param/;
use JSON::MaybeXS qw/decode_json/; use LWP::Simple;

my $scbase='https://api.soundcloud.com';
# client ID borrowed from youtube-dl's source
my $pubapikey='fDoItMDbsbZz8dY16ZzARCZmzgHBPotA';

my $uri = param 'u';
my $jtrack = get "$scbase/resolve.json?client_id=$pubapikey&url=$uri";
my $track = decode_json $jtrack;

if ($track->{downloadable}) {
	$uri = "$track->{download_url}?client_id=$pubapikey";
} else {
	$uri = "$track->{stream_url}?client_id=$pubapikey"
}
print redirect $uri;
