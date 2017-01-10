#!/usr/bin/perl

use Config::IniFiles;
use IO::Socket::INET;
use Net::Domain qw(hostname hostfqdn hostdomain);
use Getopt::Long;
use strict;

my $OPTARG;
my @sections;
my $section;
my $host;
my $db_names_string;
my @db_names;
my $db_dump_path;

sub show_usage()
                        {
                          print "Usage: mongodb_backup.pl -p <properties_file> ";
                        }
my $result = GetOptions( "p=s" => \$OPTARG);

my $cfg=Config::IniFiles->new(-file=>"$OPTARG");

if($OPTARG eq "")
        {
          show_usage();
          exit 1;
        }
my $PROPS="$OPTARG";

if(! -f "$PROPS")
        {
          print "Properties file $PROPS doesnt exist!" ;
          exit 2;
        }
@sections=$cfg->Sections;
foreach $section(@sections)
{
   $host                 = $cfg->val("$section","host");
   $db_names_string	 = $cfg->val("$section","db_names");
   $db_dump_path	 = $cfg->val("$section","db_dump_path");
   @db_names		 = split(",",$db_names_string);
   my $hostcurrent = hostname();
   
   if ($hostcurrent eq $host)
   {     
     foreach my $db_name (@db_names) 
     {			
	`/usr/share/fk-mongodb-backup/mongodb_backup.sh $db_dump_path $db_name`;	
     }
   }
}	

	



