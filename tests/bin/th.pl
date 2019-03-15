
use strict;
use Getopt::Long;

my $help_text =<<END_OF_HELP;
  Option:
    -h           print out this help message
    -f=[file]    input hex file
    -debug=[1|0] print debug info
END_OF_HELP


my $help;
my $file;
my $out_file;
my $debug;
my $base_addr;

GetOptions ("h"  => \$help,
          "file=s" => \$file,
          "base=s" => \$base_addr,
          "out=s" => \$out_file,
          "debug" => \$debug);

sub bin2dec()
{
    my $bin = shift;
    my $dec = unpack("N",pack("B32",$bin));
    return $dec;
}

sub hex2dec()
{
    my $hex = shift;
    my $dec = hex $hex;
    return $dec;
}




if ($help) {
    print "$help_text";
}

open (IN_FILE,$file) || die "Error: Can not open $file.";
my @in_array = <IN_FILE>;
my $line;
my $addr;
my @data;
my $data_len;
my $idx;
my $tail;
my $i;

my $dtcm_file;

my $test_name;

$test_name = $out_file;

$test_name =~ s/\..*$//g;

my $itcm_file = "$test_name"."\.itcm" ;
my $dtcm_file = "$test_name"."\.dtcm" ;


open (OUT_FILE,">$out_file") || die "Error: Can not open $out_file";
open (OUT_FILE1,">$itcm_file") || die "Error: Can not open $itcm_file";
open (OUT_FILE2,">$dtcm_file") || die "Error: Can not open $dtcm_file";
my $current_addr = 0;

$current_addr = &hex2dec($base_addr);
print "---- $current_addr---\n";

foreach $line (@in_array) {
    chomp $line;
    if ($line =~ /\@(.*)/) {
        $addr = &hex2dec($1);
        print "current address is $addr\n";
        print "$current_addr\n";
        while ($current_addr < $addr) {
            print OUT_FILE "00000000\n";
            $current_addr = $current_addr + 4;
        }
    } else {
        @data = split(/ /,$line);
        $idx =0;
        $data_len = @data;
        while (($data_len - $idx) >= 8 ) {
            #print OUT_FILE "$data[$idx+3]$data[$idx+2]$data[$idx+1]$data[$idx+0]\n";
            print OUT_FILE "$data[$idx+7]$data[$idx+6]$data[$idx+5]$data[$idx+4]$data[$idx+3]$data[$idx+2]$data[$idx+1]$data[$idx+0]\n";
            $current_addr = $current_addr + 8;
            $idx = $idx +8;
        }
        if (  (($data_len -$idx) <8) && (($data_len - $idx) > 1) ) {
            $tail = $data_len - $idx;
            for ($i=0;$i<=(8-$tail);$i++) {
                print OUT_FILE "00";
            }
            for ($i=2;$i<$tail+1;$i++) {
                print OUT_FILE "$data[$data_len-$i]";
            }
            print OUT_FILE "\n";

        }

    }
}

close (OUT_FILE);

open (OUT_FILE,"$out_file") || die "Error: Can not open $out_file";

my @out_array = <OUT_FILE>;
my $i =0;
foreach $line (@out_array) {
    chomp $line;
    if ($i < 16384) {
        print  OUT_FILE1 "$line\n";
    } else {
        print  OUT_FILE2 "$line\n";
    }
    $i = $i +1;
}


