if ( $ENV{PAR_PROGNAME} ) {
    my $zip = $PAR::LibCache{$ENV{PAR_PROGNAME}}
        || Archive::Zip->new(__FILE__);
    my $script = '';
    $ARGV[0] ||= $script if $script;
    if ( ( @ARGV == 0 ) || ( $ARGV[0] eq '-h' ) || ( $ARGV[0] eq '-help' )) {
        my @members = $zip->membersMatching('.*script/.*.pl');
        my $list = "  Available scripts:\n";
        for my $member ( @members ) {
            my $name = $member->fileName;
            $name =~ /(\w+\.pl)$/;
            $name = $1;
            next if $name =~ /^main.pl$/;
            next if $name =~ /^par.pl$/;
            $list .= "    $name\n";
        }
        die <<"END";
Usage:
    [parl] myapp[.par] [script] [arguments]

  Examples:
    parl myapp.par myapp_server.pl -r
    myapp myapp_cgi.pl

$list
END
    }
    my $file = shift @ARGV;
    $file =~ s/^.*[\/\\]//;
    $file =~ s/\.[^.]*$//i;
    my $member = eval { $zip->memberNamed("./script/$file.pl") };
    die qq/Can't open perl script "$file"
/ unless $member;
    PAR::_run_member( $member, 1 );
}
else {
    require lib;
    import lib 'lib';
    $ENV{CATALYST_ENGINE} = 'CGI';
    require MyApp;
    import MyApp;
    require Catalyst::Helper;
    require Catalyst::Test;
    require Catalyst::Engine::HTTP;
    require Catalyst::Engine::CGI;
    require Catalyst::Controller;
    require Catalyst::Model;
    require Catalyst::View;
    require Getopt::Long;
    require Pod::Usage;
    require Pod::Text;
    
}
