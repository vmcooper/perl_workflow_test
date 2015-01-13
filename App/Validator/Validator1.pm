package App::Validator::Validator1;

use strict;
use base qw( Workflow::Validator );
use Workflow::Exception qw( validation_error configuration_error );
use Data::Dumper;
use Carp qw(carp);

sub _init {
    my ( $self, $params ) = @_;
     unless ( $params->{answer} ) {
         configuration_error
             "You must define a value for 'answer' in ",
             "declaration of validator ", $self->name;
     }
     if ( ref $params->{answer} ) {
         configuration_error
             "The value for 'answer' must be a simple scalar in ",
             "declaration of validator ", $self->name;
     }
     print "Answer: ".$params->{answer}."\n";
     $self->{ answer => $params->{answer} };
}

sub validate {
	my ( $self, $wf, $city ) = @_;

    print "Your answer is being validated!\n";
    print "Your answer is - ".$city."\n";

	my $check;

	if ( $city eq $self->{answer} ){
		$check = 1;
	} else {
		$check = 0;
	}
	unless ( $check ) {
		validation_error "Validation error!";
	}
}

1;