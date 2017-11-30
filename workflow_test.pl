use strict;
use Log::Log4perl     qw( get_logger );
use Workflow::Factory qw( FACTORY );
use lib qw(lib);

Log::Log4perl::init( 'log4perl.conf' );
system('clear');

# Stock the factory with the configurations; we can add more later if we want
FACTORY->add_config_from_file(
    workflow   => 'workflow.xml',
    action     => 'action.xml',
    persister  => 'persister.xml',
    validator  => 'validator.xml'
    );

my $workflow = FACTORY->create_workflow( "Workflow1" );
my $context = $workflow->context;

while ( $workflow->state eq "INITIAL" ) {
    print "If you answer right the action should change state to 'finished'. Try answering wrong first.\n";
    my $city = get_response( "Capital city of England: " );
    print "You answered - $city\n";
    $context->param( answer => $city );
    $workflow->execute_action( 'action1' );

    if( $workflow->state eq "INITIAL" ) {
        print "Your answer is wrong! try again!\n\n";
    }
}

print "\nCorrect! Current state of workflow is - ".$workflow->state."\n\n";


# Generic routine to read a response from the command-line (defaults,
# etc.) Note that return value has whitespace at the end/beginning of
# the routine trimmed.

sub get_response {
    my ( $msg ) = @_;
    print $msg;
    my $response = <STDIN>;
    chomp $response;
    $response =~ s/^\s+//;
    $response =~ s/\s+$//;
    return $response;
}
