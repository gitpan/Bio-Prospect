#!/usr/bin/env perl

#-------------------------------------------------------------------------------
# NAME: Align.pl
# PURPOSE: test script for the Align object
# USAGE: Align.pl sequence-file
#
# $Id: Align.pl,v 1.7 2003/11/18 19:45:45 rkh Exp $
#-------------------------------------------------------------------------------

use Bio::Prospect::Options;
use Bio::Prospect::LocalClient;
use Bio::Prospect::Align;
use Bio::SeqIO;
use warnings;
use strict;

use vars qw( $VERSION );
$VERSION = sprintf( "%d.%02d", q$Revision: 1.7 $ =~ /(\d+)\.(\d+)/ );


die( "USAGE: Align.pl sequence-file\n" ) if $#ARGV != 0;

my $in = new Bio::SeqIO( -format=> 'Fasta', '-file' => $ARGV[0] );
my $po = new Bio::Prospect::Options( seq=>1, svm=>1, global_local=>1,
                 templates=>[qw(1bgc 1alu)] );
my $pf = new Bio::Prospect::LocalClient( {options=>$po} );

while ( my $s = $in->next_seq() ) {
  my @threads = $pf->thread( $s ); 
  my $pa = new Bio::Prospect::Align( -debug=>0,-threads => \@threads );
  print $pa->get_alignment(-format=>'html');
}
