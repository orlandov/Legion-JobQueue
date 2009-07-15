package Legion::Worker;
use Moose;
use TheSchwartz::Moosified::Worker;

BEGIN { extends 'TheSchwartz::Moosified::Worker' }

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;
