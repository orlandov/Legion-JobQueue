package Legion::Worker::Renderer;
use Moose;

use TheSchwartz::Moosified::Job;

BEGIN { extends 'Legion::Worker' }

sub work {
    my ($class, $job) = @_;

    # render parameters are here
    use Data::Dump qw/dump/;
    warn "rendering with arg => " . dump $job->arg;
    $job->completed;
}

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;
