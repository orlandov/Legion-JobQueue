package Legion::Worker::FrameMaker;
use Moose;
use TheSchwartz::Moosified::Worker;
use TheSchwartz::Moosified::Job;

BEGIN { extends 'Legion::Worker' }

sub work {
    my ($class, $job) = @_;

    my %args = %{ $job->arg };
    my @jobs;

    warn "Frame Making in progress!";

    for my $frame_number ($args{frame_first} .. $args{frame_last}) {
        my $job = TheSchwartz::Moosified::Job->new;
        $job->arg(
            {
                session_name => $args{session_name},
                frame_number => $frame_number
            }
        );
        $job->priority($args{frame_last} - $frame_number);
        $job->funcname('Legion::Worker::Renderer');
        push @jobs, $job;
    }

    $job->replace_with(@jobs);
}

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;
