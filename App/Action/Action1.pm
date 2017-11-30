package App::Action::Action1;

use strict;
use base qw( Workflow::Action );
use Workflow::Exception qw( validation_error configuration_error );
use Data::Dumper;

sub execute {
    my $self = shift;
    my $wf = shift;
    print "App::Action::Action1::Execute\n";
    print "Validators: ".Dumper($self->get_validators())."\n";
}

1;
