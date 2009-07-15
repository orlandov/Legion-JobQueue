#!/usr/bin/perl

use DBI;
use TheSchwartz::Moosified;
use Legion::Worker::FrameMaker;
use Legion::Worker::Renderer;

my $dbh = DBI->connect('dbi:Pg:dbname=legion', '', '');
my $client = TheSchwartz::Moosified->new(
    databases => [ $dbh ],
    scoreboard => 'log',
    verbose => 1
);

$client->can_do('Legion::Worker::FrameMaker');
$client->can_do('Legion::Worker::Renderer');

$client->prioritize(1);
$client->insert('Legion::Worker::FrameMaker',
    {
        session_name => "test_session",
        filename => 'foo.blend',
        frame_first => 1,
        frame_last => 250
    });
$client->work_until_done;

print "foo => ". $__MAIN__::foo;
warn "Done?";
0;
