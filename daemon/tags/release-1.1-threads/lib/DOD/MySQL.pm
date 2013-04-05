package DOD::MySQL;

use strict;
use warnings;
use Exporter;

use YAML::Syck;
use File::ShareDir;
use Log::Log4perl;
use File::Temp;

use DOD::Database;
use DOD::All;

our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS, $config, $config_dir, $logger,);

$VERSION     = 0.03;
@ISA         = qw(Exporter);
@EXPORT      = qw(test_instance get_variable get_version state_checker upgrade_callback);
@EXPORT_OK   = qw();
%EXPORT_TAGS = ( );

# Load general configuration

BEGIN{

$config_dir = File::ShareDir::dist_dir( "DOD" );
$config = LoadFile( "$config_dir/dod.conf" );
Log::Log4perl::init( "$config_dir/$config->{'LOGGER_CONFIG'}" );
$logger = Log::Log4perl::get_logger( 'DOD' );
$logger->debug( "Logger created" );
$logger->debug( "Loaded configuration from $config_dir" );
foreach my $key ( keys(%{$config}) ) {
    my %h = %{$config};
    $logger->debug( "\t$key -> $h{$key}" );
    }

} # BEGIN BLOCK

sub test_instance{
    my $entity = shift;
    $logger->debug( "Fetching state of entity $entity" );
    my $cmd = "/etc/init.d/syscontrol -i $entity MYSQL_ping -debug";
    my $res = `$cmd`;
    $logger->debug( "\n$res" );
    return $res;
    }

sub get_variable{
    my ($entity, $varname) = @_;
    $logger->debug( "Fetching state of entity $entity" );
    my $cmd = "/etc/init.d/syscontrol -i $entity MYSQL_get_status -entity $entity -variable $varname";
    my $output = `$cmd`;
    $logger->debug( "\n$output" );
    return $output;
    }

sub get_version{
    my $entity = shift;
    my $cad = get_variable($entity, 'version');
    my @buf = split(/-/, $cad); # We have to remove the -log at the end of the version string
    return $buf[0];
    }

sub state_checker{
    my ($job, $code) = @_;
    my ($job_state, $instance_state);
    if ($code){
        $job_state = "FINISHED_FAIL";
    }
    else{
        $job_state = "FINISHED_OK";
    }
    my $entity = DOD::All::get_entity($job);
    my $output = test_instance($entity);
    my $retcode = DOD::All::result_code($output);
    if ($retcode) {
        $instance_state = "STOPPED";
    }
    else{
        $instance_state = "RUNNING";
    }
    $logger->debug( "Resulting states are: ($job_state, $instance_state)" );
    return ($job_state, $instance_state);
}

sub upgrade_callback{
    my ($job, $dbh);
    if ($#_ == 1){
        ($job, $dbh) = @_;
    }
    elsif($#_ == 0){
        $job = shift;
        $dbh = DOD::Database::getDBH();
    }
    my $entity = DOD::All::get_entity($job);
    eval{
        my $version = get_version($entity);
        $logger->debug( "Updating $entity version to $version");
        DOD::Database::updateInstance($job, 'VERSION', $version);
        1;
    } or do {
        $logger->error( "A problem occured when trying to update $entity version");
        return undef;
    };
}

1;