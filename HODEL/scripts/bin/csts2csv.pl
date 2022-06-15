
my $infile = $ARGV[0];
my $outfile = $ARGV[1];

open (OUT, ">$outfile");
&elabora ($infile);
close( OUT );

sub elabora() {
    my $file = shift;
    my $sentenceID="";
    
    open(IN, "<$file") || die "diocane: $!";
    while (<IN>) {
	chomp;

	$row = $_;

#SENTENCE
	if ( $row =~ /^<s\s+id="(\S+)"/ ) {  #match sentence
	     $sentenceID=$1 ;   
#print STDERR "$sentenceID\n"
	} 
#TOKEN
      elsif ( $row =~ /^<[f|d]>([^<]*).*<l>([^<]*).*<t>(\S)(\S)(\S)(\S)(\S)(\S)(\S)(\S)(\S)(\S)(\S).*<A>([^<]*).*<r>(\d+).*<g>(\d+)/ ) {  
	    print OUT "$1\t$2\t$3\t$4\t$5\t$6\t$7\t$8\t$9\t$10\t$11\t$12\t$13\t$14\t$15\t$16\t$sentenceID\n";
	}

    }
 #   print OUT "\n";
    close(IN);
}
