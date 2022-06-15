package MyApp::Controller::query;

use strict;
use warnings;
#PAOLO UTF8
use utf8;
use parent 'Catalyst::Controller';

=head1 NAME

MyApp::Controller::query - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

#    $c->stash->{template}   = 'query/query.tt2';
#    $c->stash->{no_wrapper} = 0;
    $c->forward('list');
}


=head2 getFilters

=cut
sub getFilters {
    my ( $self, $c ) = @_;

#P
    my @REL = ( 'Sb', 'Obj', 'Pnom', 'OComp' );

    my %browseFilter;
    $browseFilter{"lemma"} = $c->request->params->{lemma};
    $browseFilter{"argsCard"} = $c->request->params->{argsCard};
    $browseFilter{"argsSet"}  = $c->request->params->{argsSet};
###
    $browseFilter{"curArgLem"} = $c->request->params->{curArgLem};
    $browseFilter{"curArgRel"}    = $c->request->params->{curArgRel};
    $browseFilter{"curArgCas"} = $c->request->params->{curArgCas};
###

#P    $browseFilter{"relOrderType"}   = $c->request->params->{relOrderType};
#P    $browseFilter{"relOrderCat"}    = $c->request->params->{relOrderCat};
    $browseFilter{"catOrderField"} = 0;
    foreach (@REL) {
        $browseFilter{"relOrderCat".$_}    = $c->request->params->{"relOrderCat".$_};
###
        $browseFilter{"catOrderField"}++ if (defined $c->request->params->{"relOrderCat".$_});
    }
#P
    $browseFilter{"relOrderSubCat"} = $c->request->params->{relOrderSubCat};
    $browseFilter{"diatesi"}   = $c->request->params->{diatesi};
    
    my %selectFilter;
    $selectFilter{"lemma"} = $c->request->params->{Slemma};
    $selectFilter{"argsCard"} = $c->request->params->{SargsCard};
    $selectFilter{"argsSet"}  = $c->request->params->{SargsSet};
###
    $selectFilter{"curArgLem"} = $c->request->params->{ScurArgLem};
    $selectFilter{"curArgRel"}    = $c->request->params->{ScurArgRel};
    $selectFilter{"curArgCas"} = $c->request->params->{ScurArgCas};
###
#P    $selectFilter{"relOrderType"}   = $c->request->params->{SrelOrderType};
#P    $selectFilter{"relOrderCat"}    = $c->request->params->{SrelOrderCat};
    $selectFilter{"catOrderField"} = 0;
    foreach (@REL) {
        $selectFilter{"relOrderCat".$_}    = $c->request->params->{"SrelOrderCat".$_};
###
        $selectFilter{"catOrderField"}++ if (defined $c->request->params->{"SrelOrderCat".$_});
    }
#P
    $selectFilter{"relOrderSubCat"} = $c->request->params->{SrelOrderSubCat};
    $selectFilter{"diatesi"}   = $c->request->params->{Sdiatesi};

    my %mergedFilter = %selectFilter;
    $mergedFilter{"lemma"} = $browseFilter{"lemma"} if ($browseFilter{"lemma"});
    $mergedFilter{"argsCard"} = $browseFilter{"argsCard"} if (defined $browseFilter{"argsCard"});
    $mergedFilter{"argsSet"}  = $browseFilter{"argsSet"} if ($browseFilter{"argsSet"});
###
    $mergedFilter{"curArgLem"} = $browseFilter{"curArgLem"} if ($browseFilter{"curArgLem"});
    $mergedFilter{"curArgRel"}    = $browseFilter{"curArgRel"} if ($browseFilter{"curArgRel"});
    $mergedFilter{"curArgCas"} = $browseFilter{"curArgCas"} if ($browseFilter{"curArgCas"});
###
#    $mergedFilter{"relOrderType"}   = $browseFilter{"relOrderType"} if ($browseFilter{"relOrderType"});
#    $mergedFilter{"relOrderCat"}    = $browseFilter{"relOrderCat"} if ($browseFilter{"relOrderCat"});
    $mergedFilter{"catOrderField"} = 0;
    foreach (@REL) {
        $mergedFilter{"relOrderCat".$_}    = $browseFilter{"relOrderCat".$_} if ($browseFilter{"relOrderCat".$_});
###
        $mergedFilter{"catOrderField"}++ if (defined $c->request->params->{"SrelOrderCat".$_} || defined $c->request->params->{"relOrderCat".$_});
    }
#P
    $mergedFilter{"relOrderSubCat"} = $browseFilter{"relOrderSubCat"} if ($browseFilter{"relOrderSubCat"});
    $mergedFilter{"diatesi"}   = $browseFilter{"diatesi"} if ($browseFilter{"diatesi"});

#decodifica argomenti:
#    my @argField = ("fillerLem", "fillerRelation", "fillerCase", "fillerRelPos");
    my @argField = ("fillerLem", "fillerRelation", "fillerCase", "fillerRelPos", "fillerPrep", "fillerConj");
    my @arguments = ();
    my $numArgs = $c->request->params->{cardinality};
    my $card = $c->request->params->{card};
    my $seq = $c->request->params->{seq};
###
    $c->stash->{ card } = $card;
    $c->stash->{ seq } = $seq;
###
    for my $i (0..$numArgs-1) {
        my $arg = {};
        my $any=0;
        foreach (@argField) {
            $arg->{ $_ } = $c->request->params->{"S$_$i"};
            $any++ if ( $arg->{ $_ } ne '' );
        }    
        push (@arguments, $arg) if ($any || ($card ne '') || ($seq ne '') );
    }

    my $isSeq = ($seq ne '');
    if ($card ne '') {
        $mergedFilter{"argsCard"} = $numArgs;
        $selectFilter{"argsCard"} = $numArgs;
    }
########################

    return ( \%browseFilter, \%selectFilter, \%mergedFilter, \@arguments, $isSeq );
}

=head2 getTokenSet

=cut

sub getTokenSet {
#    my (  $self, $c, $browseFilter) = @_;
    my (  $self, $c, $browseFilter, $arguments, $isSeq) = @_;

#P
    my @REL = ( 'Sb', 'Obj', 'Pnom', 'OComp' );

    my $lemma;

    my ( $argsCard, $argsSet );

    #
    my ($curArgLem, $curArgRel, $curArgCas );

    my ( $relOrderType, $relOrderCat, $relOrderSubCat );
    my $catOrderField;

    my ($diatesi);

    $lemma = $browseFilter->{lemma};

    $argsCard = $browseFilter->{argsCard};
    $argsSet  = $browseFilter->{argsSet};
### ??
    $curArgLem = $browseFilter->{curArgLem};
    $curArgRel    = $browseFilter->{curArgRel};
    $curArgCas = $browseFilter->{curArgCas};
###
#P    $relOrderType   = $browseFilter->{relOrderType};
#P    $relOrderCat    = $browseFilter->{relOrderCat};
    $relOrderSubCat = $browseFilter->{relOrderSubCat};

#P    $catOrderField  = 'argsorder_' . $relOrderType if ($relOrderType);
=h
    $catOrderField = 0;
    foreach (@REL) {
        $catOrderField++ if (defined $browseFilter->{"relOrderCat".$_});
    }
=cut
    $catOrderField = $browseFilter->{"catOrderField"};

    $diatesi   = $browseFilter->{diatesi};

    my %Filter;

##AGDT
#    $Filter{'-or'} = [ 'me.pos' => '2', 'me.pos' => '3' ];
    $Filter{'-or'} = [ 'me.posagdt' => 'v' ];
##

    my $root_id;
    if ( defined $argsCard || $argsSet ) {
        $root_id = 'argscats.root_id';
    }
    elsif ($catOrderField) {
        $root_id = 'argscatorders.root_id';
    }
#    elsif ($filler) {
#        $root_id = 'verbarguments.root_id';
#    }
    elsif ($curArgLem || $curArgRel || $curArgCas || @{$arguments}) {
        $root_id = 'verbarguments.root_id';
    }
    elsif ($diatesi) {
        $root_id = 'diatesicats.root_id';
    }

    $Filter{$root_id} = undef
      if ( ( defined $argsCard ) && ( $argsCard == 0 ) );
    $Filter{$root_id} = { '!=', undef }
#      if ( $argsCard || $argsSet || $catOrderField || $filler );
#      if ( $argsCard || $argsSet || $catOrderField || $curArgLem || $curArgRel || $curArgCas );
      if ( $argsCard || $argsSet || $catOrderField || $curArgLem || $curArgRel || $curArgCas || @{$arguments} );

    $Filter{'me.lemma'} = $lemma if ($lemma);

    $Filter{'argscard'} = $argsCard if ($argsCard);
    $Filter{'argsset'}  = $argsSet  if ($argsSet);

    #
#    $Filter{'rCase'} = $argsCase if ($argsCase);

#    $Filter{'verbarguments.lemma'} = $filler    if ($filler);
#    $Filter{'relation'}            = $fillerRel if ($fillerRel);
    
    my $i = 1;
    for my $arg ( @{$arguments} ){
        my $indRel = "_$i"  if ($i > 1);  
#        $Filter{"verbarguments$indRel.rCase"} = $arg->{fillerCase} if($arg->{fillerCase});
        $Filter{"verbarguments$indRel.rCase"} = ($arg->{fillerCase} eq 'NULL') ? undef : $arg->{fillerCase} if($arg->{fillerCase});
        $Filter{"verbarguments$indRel.lemma"} = $arg->{fillerLem} if($arg->{fillerLem});
        $Filter{"verbarguments$indRel.relation"} = $arg->{fillerRelation} if($arg->{fillerRelation});
###
#        $Filter{"verbarguments$indRel.prep"} = $arg->{fillerPrep} if($arg->{fillerPrep});
#        $Filter{"verbarguments$indRel.conj"} = $arg->{fillerConj} if($arg->{fillerConj});
        $Filter{"verbarguments$indRel.prep"} = ( $arg->{fillerPrep} eq 'NULL' ) ? undef : $arg->{fillerPrep} if( $arg->{fillerPrep} );
        $Filter{"verbarguments$indRel.conj"} = ( $arg->{fillerConj} eq 'NULL' ) ? undef : $arg->{fillerConj} if( $arg->{fillerConj} );

        if($arg->{fillerRelPos} eq "BV") {
            $Filter{"verbarguments$indRel.mx"} = { '<', \"me.rank"};
        } elsif ($arg->{fillerRelPos} eq "AV") {
            $Filter{"verbarguments$indRel.mn"} = { '>', \"me.rank"};
        } elsif ($arg->{fillerRelPos} eq "OV") {
            $Filter{"verbarguments$indRel.mn"} = { '<', \"me.rank"};
            $Filter{"verbarguments$indRel.mx"} = { '>', \"me.rank"};
        }

        if ($isSeq && ($i > 1)) { #argomenti consecutivi
            my $j = $i-1;
            my $pindRel = "_$j"  if ($j > 1);
            if ( defined $Filter{"verbarguments$indRel.mn"} ) {
            $Filter{"-and"} = ($Filter{"-and"}, [\"verbarguments$indRel.mn > me.rank", \"verbarguments$indRel.mn > verbarguments$pindRel.mn"]);
            }
            else {
            $Filter{"verbarguments$indRel.mn"} = { '>', \"verbarguments$pindRel.mn"};
            }
        } else {  # argomenti diversi
            for my $j (1..$i-1) {
                my $pindRel = "_$j"  if ($j > 1);
                $Filter{"verbarguments$indRel.coord_id"} = { '!=', \"verbarguments$pindRel.coord_id"}
            }
        }
        $i++;
    }

### definisci filtro sugli argomenti:
    if ( defined $curArgLem || defined $curArgRel || defined $curArgCas ) {
        my $numVA = scalar @{$arguments};
        $numVA++;
        my $VAname="verbarguments";
        $VAname="verbarguments_$numVA" if ( $numVA > 1 );

#        $Filter{"$VAname.rCase"} = $curArgCas if (defined $curArgCas);
        $Filter{"$VAname.rCase"} = ( $curArgCas eq 'NULL' ) ? undef : $curArgCas if (defined $curArgCas);
        $Filter{"$VAname.lemma"} = $curArgLem    if (defined $curArgLem);
        $Filter{"$VAname.relation"}            = $curArgRel if (defined $curArgRel);        
    }

#P    $Filter{$catOrderField} = $relOrderCat if ($catOrderField);
#P    $catOrderField  = 'argsorder_' . $relOrderType if ($relOrderType);
    foreach (@REL) {
        $Filter{ "argsorder_" . $_ } = $browseFilter->{"relOrderCat".$_} if ( defined $browseFilter->{"relOrderCat".$_} );
    }
#P
    $Filter{'argsorder'} = $relOrderSubCat if ($relOrderSubCat);

    $Filter{'diatesi'} = $diatesi if ($diatesi);

    my $lemmiVerbali;

    my @addTables=();
    push (@addTables, 'argscats') if ( defined $argsCard || defined $argsSet );
#    push (@addTables, 'argscatorders') if ( defined $catOrderField );
    push (@addTables, 'argscatorders') if ( $catOrderField );
    push (@addTables, 'diatesicats') if ( defined $diatesi );
#    push (@addTables, 'verbarguments') if ( defined $filler || defined $argsCase );

    for my $arg ( @{$arguments} ){
        push (@addTables, "verbarguments");
    }
    # aggiungi tabella per il filtro degli argomenti
    push (@addTables, 'verbarguments') if ( defined $curArgLem || defined $curArgRel || defined $curArgCas );

    $lemmiVerbali =
          $c->model('DB::Forma')
#          ->search( %Filter, { join => \@addTables, } );
          ->search( \%Filter, { join => \@addTables, } );
    return ($lemmiVerbali, \@addTables, $root_id);
}


=head2 list
    
    List of all Verbs
    
=cut

sub list : Local : Args(0) {
    my ( $self, $c ) = @_;
    my ( $orderby, $dir, $filter, $update );
    my %Filter;

    $filter  = $c->request->params->{filter};
    $orderby = $c->request->params->{orderby};
    $dir     = $c->request->params->{dir};
    $update = $c->request->params->{update};

    $filter  = "%"      unless ($filter);
    $Filter{'me.lemma'} = { 'LIKE', $filter } if ( $filter );

    $orderby = "me.lemma" unless ($orderby);
    $dir     = "asc"   unless ($dir);

    my $page = $c->request->param('page');
    if ( defined $page ) {
        $page = 1 if ( $page !~ /^\d+$/ );
    }
    else {
        $page = 1;
    }

#    my ($browseFilter, $selectFilter, $mergedFilter) = getFilters( $self, $c );
#    my ($lemmiVerbali, $fields, $root_id) = getTokenSet( $self, $c, $mergedFilter );

    my ($browseFilter, $selectFilter, $mergedFilter, $arguments, $isSeq) = getFilters( $self, $c );
    my ($lemmiVerbali, $fields, $root_id) = getTokenSet( $self, $c, $mergedFilter, $arguments, $isSeq );

#    for my $p (@{$fields}) {$c->log->debug('*** table:'.$p);}
#    for my $k (keys %{$mergedFilter}) {$c->log->debug('*** param:'.$k.'='.$mergedFilter->{$k});}
#    for my $p (@{$arguments}) {
#    for my $k (keys %{$p}) {$c->log->debug('*** arg param:'.$k.'='.$p->{$k});}
#    }

    my $lV = $lemmiVerbali->search(
        \%Filter,
        {
            select =>
              [ 'me.lemma', \'COUNT(id) AS frq', \'REVERSE(me.lemma) AS lRetr' ],
            as       => [ 'lemma', 'num', 'lemmar' ],
            group_by => 'me.lemma',
            order_by => { "-" . $dir => $orderby },
            page     => $page,       # page to return (defaults to 1)
            rows => 100,    # number of results per page
        }
        #{
            #select =>
              #[ 'me.lemma', 
              #{ COUNT => 'id', -as => 'frq' },
              #{ REVERSE => 'me.lemma', -as => 'lRetr' }
              #],
            #as       => [ 'lemma', 'num', 'lemmar' ],
            #group_by => 'me.lemma',
            #order_by => { "-" . $dir => $orderby },
            #page     => $page,       # page to return (defaults to 1)
            #rows => 100,    # number of results per page
        #}
    );

    if ($update <= 2) {
    $c->stash->{lemmiVerbali} = [ $lV->all() ];
    $c->stash->{pager} = $lV->pager();
    }

    $c->stash->{orderby}  = $orderby;
    $c->stash->{dir}      = $dir;
    $c->stash->{filter}   = $filter;

    $c->stash->{browseFilter} = $mergedFilter;
    $c->stash->{selectFilter} = $selectFilter;
    $c->stash->{argsFilter} = $arguments;

####
    argumentsList( $self, $c, $lemmiVerbali, $fields, $mergedFilter );

    if ($update) {
        if ($update == 2 ) {
            if ( $selectFilter->{lemma} ) {
               $c->stash->{lemmaInfo} = $lemmiVerbali->search( undef, { select => ['me.cat_fl'] } )->first;
            } else {
               $c->stash->{lemmataCount} =
               $lemmiVerbali
               ->search( undef, { columns => [ qw/me.lemma/ ], distinct => 1} )->count;
            } 
            $c->stash->{reificationsCount} = $lemmiVerbali->count;
            $c->stash->{'cardCatIndex'} = argsNumCatTree( $self, $c, $lemmiVerbali, $fields );
            $c->stash->{'ordCatIndex'} = argsOrdCatTree( $self, $c, $lemmiVerbali, $fields );
            $c->stash->{template}   = 'query/list.tt2';
        } elsif ($update == 1 ) {
            $c->stash->{template}   = 'query/tabella.tt2';
        } elsif ($update == 3 ) {
            $c->stash->{template}   = 'query/tabellaArgs.tt2';
        }
        $c->stash->{no_wrapper} = 1;
    }
    else {
        $c->stash->{template}   = 'query/list.tt2';
        $c->stash->{no_wrapper} = 0;
        $c->stash->{lemmataCount} =
          $lemmiVerbali
          ->search( undef, { columns => [ qw/me.lemma/ ], distinct => 1} )->count;
        $c->stash->{reificationsCount} = $lemmiVerbali->count;
        $c->stash->{'cardCatIndex'} = argsNumCatTree( $self, $c, $lemmiVerbali, $fields );
        $c->stash->{'ordCatIndex'} = argsOrdCatTree( $self, $c, $lemmiVerbali, $fields );
    }
}

=head2 argsNumCatTree

=cut

sub argsNumCatTree {
#    my ( $self, $c, $lemma ) = @_;
    my ( $self, $c, $tokenVerbali, $addTables ) = @_;

    my %Filter;
=h
    $Filter{'-or'} = [ pos => '2', pos => '3' ];
    $Filter{'lemma'} = $lemma if ($lemma);

    my $byArgsCard =
      $c->model('DB::Forma')->search( %Filter, { join => 'argscats', } );
=cut
    my $byArgsCard = grep(/^argscats$/,@{$addTables}) ?
      $tokenVerbali :
      $tokenVerbali->search( undef, { join => 'argscats', } );
    
    my $byArgsCardCount = $byArgsCard->search(
        {},
        {
            select =>
              [ \'IFNULL(argscats.argscard,"0") AS rCard', { count => '*' } ],
            as       => [ 'argsCard', 'occs' ],
            order_by => ['argsCard'],
            group_by => ['argsCard'],
        }
    );

    my $Root = 'argscats.root_id';
    $Filter{$Root} = { '!=', undef };


    my $byArgsSetCount = $byArgsCard->search(
#        %Filter,
		\%Filter,
        {
            select => [
                'argscats.argscard', 'argscats.argsSet',
                { count => $Root }
            ],
            as       => [ 'argsCard', 'argsSet', 'occs' ],
            order_by => [ 'argsCard', 'argsSet' ],
            group_by => [ 'argsCard', 'argsSet' ]
        }
    );
    
    my @nodes = ();    #categorie

    my ( $cat, $num );
    my ( $n,   $n1 );
    $n1 = $byArgsSetCount->next;
    while ( $n = $byArgsCardCount->next ) {
        $cat = $n->get_column('argsCard');
        $num = $n->get_column('occs');

        my @nodes1 = ();

        my ( $cat1, $num1 );
        if ( $cat ne '0' ) {
            while ($n1) {
                last if ( $n1->get_column('argsCard') ne $cat );
                $cat1 = $n1->get_column('argsSet');
                $num1 = $n1->get_column('occs');

                push(
                    @nodes1,
                    {
                        argsCard => $cat,
                        argsSet  => $cat1,
                        occs     => $num1,
                    }
                );
                $n1 = $byArgsSetCount->next;
            }
            push(
                @nodes,
                {
                    argsCard => $cat,
                    occs     => $num,
                    children => \@nodes1
                }
            );
        }
        else {
            push(
                @nodes,
                {
                    argsCard => $cat,
                    occs     => $num,
                }
            );
        }
    }
    return \@nodes;
}

=head2 argsOrdCatTree

=cut

sub argsOrdCatTree {
    my ( $self, $c, $tokenVerbali, $addTables ) = @_;

    my $byArgsOrd = grep(/^argscatorders$/,@{$addTables}) ?
      $tokenVerbali :
      $tokenVerbali->search( undef, { join => 'argscatorders', } );

    my @nodes = ();
    for my $Rel ( 'Sb', 'Obj', 'Pnom', 'OComp' ) {

#        my $catField = 'argsorder_' . $Rel;
        my $catField = 'argsorder_' . $Rel;
        my $Targs = 'argscatorders.';

        my $byArgsOrdRelCount = $byArgsOrd->search(
            { $catField => { '!=', undef } },
            {
                #select   => [ $catField, { count => '*' } ],
                #as       => [ $catField, 'occs' ],
                #order_by => [$catField],
                #group_by => [$catField],
                select   => [ $Targs.$catField, { count => '*' } ],
                as       => [ $catField, 'occs' ],
                order_by => [$catField],
                group_by => [$catField],
            }
        );

        my $byArgsOrdRelScCount = $byArgsOrd->search(
            { $catField => { '!=', undef } },
            {
                #select   => [ $catField, 'argsorder', { count => '*' } ],
                #as       => [ $catField, 'argsorder', 'occs' ],
                #order_by => [ $catField, 'argsorder' ],
                #group_by => [ $catField, 'argsorder' ],
                select   => [ $Targs.$catField, $Targs.'argsorder', { count => '*' } ],
                as       => [ $catField, 'argsorder', 'occs' ],
                order_by => [ $catField, 'argsorder' ],
                group_by => [ $catField, 'argsorder' ],
            }
        );

        my @nodes1 = ();
        my ( $cat1, $num1 );
        my ( $n1,   $n2 );
        $n2 = $byArgsOrdRelScCount->next;
        while ( $n1 = $byArgsOrdRelCount->next ) {
            $cat1 = $n1->get_column($catField);
            $num1 = $n1->get_column('occs');

            my @nodes2 = ();

            my ( $cat2, $num2 );
            while ($n2) {
                last if ( $n2->get_column($catField) ne $cat1 );
                $cat2 = $n2->get_column('argsorder');
                $num2 = $n2->get_column('occs');

                push(
                    @nodes2,
                    {
                        relOrderType   => $Rel,
                        relOrderCat    => $cat1,
                        relOrderSubCat => $cat2,
                        occs           => $num2,
                    }
                );
                $n2 = $byArgsOrdRelScCount->next;
            }

            push(
                @nodes1,
                {
                    relOrderType => $Rel,
                    relOrderCat  => $cat1,
                    occs         => $num1,
                    children     => \@nodes2
                }
            );
        }

        push(
            @nodes,
            {
                relOrderType => $Rel,
                children     => \@nodes1
            }
        ) if (@nodes1);

    }    # for cat loop

    return \@nodes;
}





sub argumentsList : Local {
    my ( $self, $c, $tokenVerbali, $addTables, $browseFilter ) = @_;

    my $VAname = "verbarguments";

    my @vargs = grep /^verbarguments$/, @{$addTables};
    push ( @vargs, "verbarguments" ) if ( !( defined $browseFilter->{curArgLem} || defined $browseFilter->{curArgRel} || defined $browseFilter->{curArgCas} ) );
    my $numVA = @vargs;
    $VAname="verbarguments_$numVA" if ($numVA>1);

    my ( $orderby, $dir, $filter, $update );
    my %Filter;

    $filter  = $c->request->params->{filter};
    $orderby = $c->request->params->{orderby};
    $dir     = $c->request->params->{dir};
    $update = $c->request->params->{update};

    if ($orderby eq 'lemma') { $orderby = "$VAname.lemma"; }
    elsif ($orderby eq 'frq') { $orderby = "argsOccs"; }

    $filter  = "%"      unless ($filter);
    $orderby = "$VAname.lemma" unless ($orderby);
    $dir     = "asc"   unless ($dir);
#
    $Filter{"$VAname.lemma"} = { 'LIKE', $filter } if ( $filter );

    my $page = $c->request->param('page');
    if ( defined $page ) {
        $page = 1 if ( $page !~ /^\d+$/ );
    }
    else {
        $page = 1;
    }

    my $tokenArgs = $tokenVerbali
      ->search(
        { "$VAname.root_id" => { '!=', undef } },
        { join => \@vargs } );
    
   my $tokenArgsLemmata = $tokenArgs->search(
#        %Filter,
        \%Filter,
        {
            select   => [ "$VAname.lemma", \"COUNT( DISTINCT $VAname.coord_id) AS argsOccs", \"COUNT( DISTINCT $VAname.root_id)", \"REVERSE($VAname.lemma) AS lRetr"],
            as => [ 'lemma', 'argsOccs', 'verbOccs', 'lRetr' ],
            group_by => ["$VAname.lemma"],
            order_by => { "-" . $dir => $orderby },
            page     => $page,       # page to return (defaults to 1)
            rows => 100,    # number of results per page
        }
    );

    my $tALbyRelation = $tokenArgs->search(
        {},
        {
            select => [ "$VAname.relation", \"COUNT( DISTINCT $VAname.coord_id)", \"COUNT( DISTINCT $VAname.root_id)" ],
            group_by => [ "$VAname.relation" ],
            order_by => [ "$VAname.relation" ],
            as       => [ 'relation', , 'argsOccs', 'verbOccs'  ],
        }
    );

    my $tALbyCase = $tokenArgs->search(
        {},
        {
            select => [ "$VAname.rCase", \"COUNT( DISTINCT $VAname.coord_id)", \"COUNT( DISTINCT $VAname.root_id)" ],
            group_by => [ "$VAname.rCase" ],
            order_by => [ "$VAname.rCase" ],
            as       => [ 'caso', 'argsOccs', 'verbOccs'  ],
        }
    );

    if ( $update == 2 || $update == 0 ) { #mostra solo indici
        $c->stash->{argsLemmataCount} =
            $tokenArgs
            ->search( undef, { columns => [ "$VAname.lemma" ], distinct => 1} )->count;
#        $c->stash->{argsReificationsCount} = $tokenArgs->count;
        $c->stash->{argsReificationsCount} = $tokenArgs
        ->search( undef, { columns => [ "$VAname.arg_id" ], distinct => 1} )->count;
        $c->stash->{'tALbyRelation'} = [ $tALbyRelation->all() ];
        $c->stash->{'tALbyCase'} = [ $tALbyCase->all() ];
    } elsif ($update == 3) {
        $c->stash->{lemmiArgs} = [ $tokenArgsLemmata->all() ];
        $c->stash->{pager} = $tokenArgsLemmata->pager();
    }

}


sub showLemma : Local {
    my ( $self, $c ) = @_;
    my $update = $c->request->params->{update};

    my ($browseFilter, $selectFilter, $mergedFilter, $arguments, $isSeq) = getFilters( $self, $c );
    my ($lemmiVerbali, $fields, $root_id) = getTokenSet( $self, $c, $mergedFilter, $arguments, $isSeq );

    my $page = $c->request->param('page');
    if ( defined $page ) {
        $page = 1 if ( $page !~ /^\d+$/ );
    }
    else { $page = 1; }
    my $sentList;

    $sentList = $lemmiVerbali->search(
        {},
        {
            join     => 'frase',
            order_by => ['me.frase'],
            +select  => ['frase.id'],
            +as      => ['sentence'],
            distinct => 1,
            page     => $page,          # page to return (defaults to 1)
            rows     => 10,             # number of results per page
        }
    );

    $c->stash->{pager} = $sentList->pager();
    my @sL = $sentList->all;

    my $downPage = $sL[0]->get_column('sentence');
    my $upPage   = $sL[$#sL]->get_column('sentence');

    # aggiungo al filtro il vincolo delle pagine
    my %pageFilter;
    $pageFilter{'-and'} =
      [ 'me.frase' => { '>=', $downPage }, 'me.frase' => { '<=', $upPage } ];

    my $sentTree;
    $sentTree = $lemmiVerbali->search(
#        %pageFilter,
        \%pageFilter,
        {
            join     => 'frase',
            order_by => ['me.frase'],
            +select => [ 'me.id', 'frase.code' ],
            +as     => [ 'root',  'sentence' ], 
###### senza il distinct duplicati in presenza di query con argomenti!!! verificare...
            distinct => 1
        }
    );

    $c->stash->{sentTree} = [ $sentTree->all ];

    my $tokens;

            
=begin comment  AGDT           
            +select => [
                'frase.code',    'formas.ID',
                'formas.forma',  'formas.lemma',
                'formas.pos',    'formas.grado_nom',
                'formas.cat_fl', 'formas.modo',
                'formas.tempo',  'formas.grado_part',
                'formas.caso',   'formas.gen_num'
            ],
            +as => [
                'sentence',, 'id', 'forma',
                'lemma', 'pos',   'grado_nom',  'cat_fl',
                'modo',  'tempo', 'grado_part', 'caso',
                'gen_num'
            ],            
=end comment
=cut


    $tokens = $lemmiVerbali->search(
#        %pageFilter,
        \%pageFilter,
        {
            join    => { 'frase' => 'formas' },
            +select => [
                'frase.code',    'formas.ID',
                'formas.forma',  'formas.lemma',
                'formas.posagdt',    'formas.pers',
                'formas.num', 'formas.tense',
                'formas.mood',  'formas.voice',
                'formas.gend',   'formas.case', 'formas.degree'
            ],
            +as => [
                'sentence', 'id', 'forma',
                'lemma', 'posagdt',   'pers',  'num',
                'tense',  'mood', 'voice', 'gend',
                'case','degree'
            ],
##
            group_by => [ 'formas.frase', 'formas.rank' ],
            order_by => [ 'formas.frase', 'formas.rank' ],
        }
    );

    $c->stash->{tokensVerbali} = [ $tokens->all ];

=h
    my $args = $lemmiVerbali->search(
        %pageFilter,
        {
            prefetch => ['verbarguments'],
            +select  => ['verbarguments.arg_id'],
            +as      => ['arg_id'],
        }
    );
=cut

    my $VAname = "verbarguments";

    my @vargs = grep /^verbarguments$/, @{$fields};
    push ( @vargs, "verbarguments" ) if ( !( defined $mergedFilter->{curArgLem} || defined $mergedFilter->{curArgRel} || defined $mergedFilter->{curArgCas} ) );
    my $numVA = @vargs;
    $VAname="verbarguments_$numVA" if ($numVA>1);


    my $args = $lemmiVerbali->search(
#        %pageFilter,
        \%pageFilter,
        {
            join => \@vargs,
#            prefetch => ["$VAname"],
            +select  => ["$VAname.arg_id"],
            +as      => ['arg_id'],
        }
    );

######
    $c->stash->{arguments} = [ $args->all ];

#    if ( $mergedFilter->{argsCard} || $mergedFilter->{argsSet} || $mergedFilter->{catOrderField} || $mergedFilter->{filler} || $mergedFilter->{lemma} ) {
    if ( $mergedFilter->{argsCard} || $mergedFilter->{argsSet} || $mergedFilter->{catOrderField} || $mergedFilter->{curArgLem} || $mergedFilter->{curArgRel} ||$mergedFilter->{curArgCas} || $mergedFilter->{lemma} ) {

        my $trees;

        # patch:
        $pageFilter{"path_root_ids.root_id"} = { '!=', undef }
#          if ( !( $mergedFilter->{argsCard} || $mergedFilter->{argsSet} || $mergedFilter->{catOrderField} || $mergedFilter->{filler} ) );
          if ( !( $mergedFilter->{argsCard} || $mergedFilter->{argsSet} || $mergedFilter->{catOrderField} || $mergedFilter->{curArgLem} || $mergedFilter->{curArgRel} ||$mergedFilter->{curArgCas} ) );

        $trees = $lemmiVerbali->search(
#            %pageFilter,
            \%pageFilter,
            {
                join => { 'path_root_ids' => [ 'parent_id', 'target_id' ], },
                order_by => {
                    -asc => [
                        'path_root_ids.root_id', 'path_root_ids.target_id',
                        'path_root_ids.depth'
                    ]
                },
                +select => [
                    'path_root_ids.root_id',   'path_root_ids.target_id',
                    'path_root_ids.parent_id', 'parent_id.forma',
                    'me.forma',                'target_id.forma',
                    'parent_id.afun',          'target_id.afun'
                ],
                +as => [
                    'root_id',     'target_id',
                    'parent_id',   'parent_forma',
                    'root_forma',  'target_forma',
                    'parent_afun', 'target_afun'
                ], 
###### senza il distinct alberi mal formati in presenza di query con argomenti!!! verificare...
                distinct => 1
            }
        );

        buildTree($trees);

    }

    $c->stash->{browseFilter}= $mergedFilter;
    $c->stash->{no_wrapper} = 1;
#    $c->stash->{template} = 'query/showLemma.tt2';
    if ($update == 2 ) {
#        $c->stash->{lemmataCount} = 1;
=begin comment  AGDT
sostituisco cat_fl con voice           
        $c->stash->{lemmaInfo} = $lemmiVerbali->search( undef, { select => ['me.cat_fl'] } )->first;
=end comment
=cut
        $c->stash->{lemmaInfo} = $lemmiVerbali->search( undef, { select => ['me.voice'] } )->first;
        $c->stash->{reificationsCount} = $lemmiVerbali->count;
        $c->stash->{selectFilter} = $selectFilter;
        $c->stash->{'cardCatIndex'} = argsNumCatTree( $self, $c, $lemmiVerbali, $fields );
        $c->stash->{'ordCatIndex'} = argsOrdCatTree( $self, $c, $lemmiVerbali, $fields );
####
        $c->stash->{argsFilter} = $arguments;
        argumentsList( $self, $c, $lemmiVerbali, $fields, $mergedFilter );
#####
        $c->stash->{template}   = 'query/showLemmaAndIndex.tt2';
    } else {
        $c->stash->{template}   = 'query/showLemma.tt2';
    }

}

sub buildTree {
    use GraphViz;

    my ($byArgsCard) = @_;

    my $graph;
    my $prev_n;
    my $cur_root;
    my $cur_target;
    my $cur_target_afun;
    my $imageFile;
    my %is_linked;
    undef %is_linked;

    while ( my $n = $byArgsCard->next ) {

        # nuovo albero
        if ( $n->get_column('root_id') != $cur_root ) {
            if ($graph) {
                $graph->add_edge( $prev_n, $cur_target,
                    label => $cur_target_afun );    #completa albero corrente
                $imageFile = $cur_root;
                open( PNG, ">root/src/verbo/trees/$imageFile.png" );
                print PNG $graph->as_png;
                close PNG;
            }
            $graph = GraphViz->new(
                edge => { arrowhead => 'none', fontsize => '8' },
                node => { fontsize  => '8' }
            );
            $graph->add_node(
                $n->get_column('root_id'),
                label => $n->get_column('root_forma'),
                shape => 'box',
                color => '0.06,0.75,1.00'
            );
            $cur_root = $n->get_column('root_id');
            $prev_n   = $cur_root;
            $graph->add_node(
                $n->get_column('target_id'),
                label => $n->get_column('target_forma'),
                shape => 'ellipse',
                color => '0.50,1.00,1.00'
            );
            $cur_target      = $n->get_column('target_id');
            $cur_target_afun = $n->get_column('target_afun');
            undef %is_linked;
        }

        # nuovo percorso dell'albero corrente
        elsif ( $n->get_column('target_id') != $cur_target ) {
            $graph->add_edge( $prev_n, $cur_target, label => $cur_target_afun );
            $graph->add_node(
                $n->get_column('target_id'),
                label => $n->get_column('target_forma'),
                shape => 'ellipse',
                color => '0.50,1.00,1.00'
            );
            $prev_n          = $cur_root;
            $cur_target      = $n->get_column('target_id');
            $cur_target_afun = $n->get_column('target_afun');
        }

        # nodo del percorso corrente
        else {
            $graph->add_node(
                $n->get_column('parent_id'),
                label => $n->get_column('parent_forma'),
                style => 'dashed'
            );
            if ( !$is_linked{ $n->get_column('parent_id') } ) {
                $graph->add_edge( $prev_n, $n->get_column('parent_id') );
                $is_linked{ $n->get_column('parent_id') } = 1;
            }
            $prev_n = $n->get_column('parent_id');
        }
    }

    # last tree?
    if ($graph) {
        $graph->add_edge( $prev_n, $cur_target, label => $cur_target_afun )
          ;    #completa albero corrente
        $imageFile = $cur_root;
        open( PNG, ">root/src/verbo/trees/$imageFile.png" );
        print PNG $graph->as_png;
        close PNG;
    }
}


=head1 AUTHOR

Paolo Ruffolo

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
