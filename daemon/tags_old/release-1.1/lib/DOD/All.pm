package DOD::All;

use strict;
use warnings;
use Exporter;

use DOD::Config qw( $config );

our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS, $logger);

$VERSION     = 0.03;
@ISA         = qw(Exporter);
@EXPORT      = qw(get_host_from_entity copy_to_entity);
@EXPORT_OK   = qw();
%EXPORT_TAGS = ( );

# Load general configuration

INIT{
    $logger = Log::Log4perl::get_logger( 'DOD.All' );
    $logger->debug( "Logger created" );
} # INIT BLOCK


sub get_entity {
    my $job = shift;
    return join('_', 'dod', $job->{'DB_NAME'});
}

sub get_host_from_entity{
    my $entity = shift;
    $logger->debug( "Fetching host corresponding to entity $entity" );
    my $cmd = "/ORA/dbs01/syscontrol/bin/netservicestab.sh sc_entity=$entity host";
    my $res = `$cmd`;
    chomp $res;
    $logger->debug( "Hostname: <$res>" );
    return $res;
    }

sub copy_to_entity{
    my ($item, $entity) = @_;
    my $host = get_host_from_entity($entity);
    system("scp", "-r",  $item, "sysctl\@$host:/tmp");
    return $?;
}


sub result_code{
    my $log = shift;
    my @lines = split(/\n/, $log);
    my $code = undef;
    foreach (@lines){
        if ($_ =~ /\[(\d)\]/){
            $code = $1;
            print $_,"\n";
            print $code,"\n";
        }
    }
    if (defined $code){
        return int($code);
    }
    else{
        # If the command doesn't return any result code, we take it as bad
        return 1;
    }
}

1;