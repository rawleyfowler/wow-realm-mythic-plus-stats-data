#!/usr/bin/env perl

use 5.036;

use GD;
use GD::Graph;
use GD::Graph::bars;
use GD::Graph::Data;
use GD::Text;
use File::Slurp;
use Carp ();

# You probably need to set this to a font on your system.
my $font
    = '/usr/share/fonts/google-crosextra-caladea-fonts/Caladea-Italic.ttf';
my $dir   = shift @ARGV;
my @lines = read_file("$dir/realms")
    or Carp::croak("Couldn't read realms file for directory $dir");

open( my $realms_png, '>', "$dir/realms.png" );

my $graph = GD::Graph::bars->new( 25 * scalar @lines, 800 );

for (
    qw(set_x_label_font set_y_label_font set_x_axis_font set_y_axis_font set_values_font)
    )
{
    $graph->$_( $font, 14 );
}
$graph->set_title_font( $font, 18 );

$graph->set(
    x_label => 'Realm',
    y_label => '# of players',
    title   => 'Unique players realms encountered during M+ this tier',
    x_labels_vertical => 1,
    transparent       => 0
);

my @h;
my @data = ( [], [] );

for (@lines) {
    chomp;
    say $_ if defined $ENV{REALMS_DEBUG};
    my ( $key, $val ) = split ' ';
    next unless $key && $val;
    push @h, { key => $key, val => $val };
}

@h = sort { $a->{val} <=> $b->{val} } @h;

for (@h) {
    push @{ $data[0] }, $_->{key};
    push @{ $data[1] }, $_->{val};
}

my $data = GD::Graph::Data->new( [@data] );
$graph->plot($data) or Carp::croak( $graph->error );

binmode $realms_png;
print $realms_png $graph->gd->png;
close $realms_png;

say "DONE! See the output graph at $dir/realms.png";
