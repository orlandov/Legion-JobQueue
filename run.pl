#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';
use DBI;
use TheSchwartz::Moosified;
use Legion::Worker::FrameMaker;
use Legion::Worker::Renderer;

my $dbname = $ENV{DBNAME} or die "Must specify DBNAME";

my $dbh = DBI->connect("dbi:Pg:dbname=$dbname", '', '');
my $client = TheSchwartz::Moosified->new(
    databases => [ $dbh ],
    scoreboard => 'log',
    verbose => 1
);

$client->can_do('Legion::Worker::FrameMaker');
$client->can_do('Legion::Worker::Renderer');

$client->prioritize(1);
# $client->insert('Legion::Worker::FrameMaker',
#     {
#         session_name => "test_session",
#         filename => 'foo.blend',
#         frame_first => 1,
#         frame_last => 250
#     });
$client->work;

warn "Done?";
0;
