package MyApp::Controller::Verbo;

use strict;
use warnings;
#PAOLO UTF8
use utf8;
use parent 'Catalyst::Controller';

=head1 NAME

MyApp::Controller::Verbo - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyApp::Controller::Verbo in Verbo.');
}

=head2 list
    
    List of all Verbs
    
=cut

sub list : Local : Args(0) {
    my ( $self, $c ) = @_;
    my ( $orderby, $dir, $filter, $update );
    my ( $argsCard, $argsSet );
    my ( $relOrderType, $relOrderCat, $relOrderSubCat );
    my $catOrderField;

    $filter  = $c->request->params->{filter};
    $orderby = $c->request->params->{orderby};
    $dir     = $c->request->params->{dir};

    $update = $c->request->params->{update};

    $argsCard = $c->request->params->{argsCard};
    $argsSet  = $c->request->params->{argsSet};

    $relOrderType   = $c->request->params->{relOrderType};
    $relOrderCat    = $c->request->params->{relOrderCat};
    $relOrderSubCat = $c->request->params->{relOrderSubCat};
    $catOrderField  = 'argsorder_' . $relOrderType if ($relOrderType);

    $filter  = ""      unless ($filter);
    $orderby = "lemma" unless ($orderby);
    $dir     = "asc"   unless ($dir);

    if ( !$update ) {

        $c->stash->{allLemmaCount} =
          $c->model('DB::Forma')
          ->search( { '-or' => [ pos => '2', pos => '3' ] } )->count;
        $c->stash->{'cardCatIndex'} = argsNumCatTree( $self, $c );
        $c->stash->{'ordCatIndex'} = argsOrdCatTree( $self, $c );
    }

    my %Filter;
    $Filter{'-or'} = [ pos => '2', pos => '3' ];
    $Filter{'root_id'} = undef
      if ( ( defined $argsCard ) && ( $argsCard == 0 ) );
    $Filter{'root_id'} = { '!=', undef }
      if ( $argsCard || $argsSet || $catOrderField );
    $Filter{'lemma'} = { 'like' => $filter } if ($filter);

    $Filter{'argscard'} = $argsCard if ($argsCard);
    $Filter{'argsset'}  = $argsSet  if ($argsSet);

    $Filter{$catOrderField} = $relOrderCat if ($catOrderField);
    $Filter{'argsorder'} = $relOrderSubCat if ($relOrderSubCat);

    my $lemmiVerbali;
    if ( defined $argsCard || $argsSet ) {
        $lemmiVerbali =
          $c->model('DB::Forma')->search( %Filter, { join => 'argscats', } );
    }
    elsif ($catOrderField) {
        $lemmiVerbali =
          $c->model('DB::Forma')
          ->search( %Filter, { join => 'argscatorders', } );
    }
    else {
        $lemmiVerbali = $c->model('DB::Forma')->search( %Filter, {} );
    }

    my $page = $c->request->param('page');
    if ( defined $page ) {
        $page = 1 if ( $page !~ /^\d+$/ );
    }
    else {
        $page = 1;
    }

    my $lV = $lemmiVerbali->search(
        {},
        {
            select =>
              [ 'lemma', \'COUNT(id) AS frq', \'REVERSE(lemma) AS lRetr' ],
            as       => [ 'lemma', 'num', 'lemmar' ],
            group_by => 'lemma',
            order_by => { "-" . $dir => $orderby },
            page     => $page,       # page to return (defaults to 1)
            rows => 100,    # number of results per page
        }
    );

    $c->stash->{lemmiVerbali} = [ $lV->all() ];

    $c->stash->{pager} = $lV->pager();

    $c->stash->{orderby}  = $orderby;
    $c->stash->{dir}      = $dir;
    $c->stash->{filter}   = $filter;
    $c->stash->{argsCard} = $argsCard if ( $argsCard || $argsCard == 0 );
    $c->stash->{argsSet}  = $argsSet if ($argsSet);
    if ($update) {
        $c->stash->{template}   = 'verbo/tabella.tt2';
        $c->stash->{no_wrapper} = 1;
    }
    else {
        $c->stash->{template}   = 'verbo/list.tt2';
        $c->stash->{no_wrapper} = 0;
    }
}

=head2 argsNumCatTree

=cut

sub argsNumCatTree {
    my ( $self, $c, $lemma ) = @_;

    #    my ($self, $c) = @_;

    my %Filter;
    $Filter{'-or'} = [ pos => '2', pos => '3' ];
    $Filter{'lemma'} = $lemma if ($lemma);

#    my $byArgsCard = $c->model('DB::Forma')->search( { -or => [ pos => '2', pos => '3'] },
    my $byArgsCard =
      $c->model('DB::Forma')->search( %Filter, { join => 'argscats', } );

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

    $Filter{'root_id'} = { '!=', undef };

   #    my $byArgsSet = $byArgsCard->search( { 'root_id' => { '!=', undef } }, {
    my $byArgsSet = $byArgsCard->search( %Filter, {} );

    my $byArgsSetCount = $byArgsSet->search(
        {},
        {
            select => [
                'argscats.argscard', 'argscats.argsSet',
                { count => 'root_id' }
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
    my ( $self, $c ) = @_;

    my $byArgsOrd =
      $c->model('DB::Forma')->search( { -or => [ pos => '2', pos => '3' ] },
        { join => 'argscatorders', } );

    my @nodes = ();
    for my $Rel ( 'Sb', 'Obj', 'Pnom', 'OComp' ) {

        my $catField = 'argsorder_' . $Rel;

        my $byArgsOrdRelCount = $byArgsOrd->search(
            { $catField => { '!=', undef } },
            {
                select   => [ $catField, { count => '*' } ],
                as       => [ $catField, 'occs' ],
                order_by => [$catField],
                group_by => [$catField],
            }
        );

        my $byArgsOrdRelScCount = $byArgsOrd->search(
            { $catField => { '!=', undef } },
            {
                select   => [ $catField, 'argsorder', { count => '*' } ],
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
        );

    }    # for cat loop

    return \@nodes;
}

=head2 lemmaNumCatTree

=cut

=h

sub lemmaNumCatTree : Local {
    my ( $self, $c, $lemma ) = @_;

    my $byArgsCase = $c->model('DB::Forma')->search( { 'me.lemma' => $lemma },
        { join => [ 'argscats', 'verbarguments' ], } );

    my $byArgsCaseCount = $byArgsCase->search(
        { 'me.lemma' => $lemma, 'verbarguments.root_id' => { '!=', undef } },
        {
            select => [
                'argscats.argscard',
                'argscats.argsSet',
                'verbarguments.rCase',
                \'COUNT(verbarguments.root_id) AS occs',
                \'COUNT( DISTINCT verbarguments.root_id) AS t_occs'
            ],
            as       => [ 'argsCard', 'argsSet', 'caso', 'occs', 't_occs' ],
            group_by => [ 'argsCard', 'argsSet', 'rCase' ],
            order_by => [ 'argsCard', 'argsSet', 'rCase' ]
        }
    );

    my @nodes = @{ argsNumCatTree( $self, $c, $lemma ) };

    my ( $cat, $cat1 );
    my ( $n, $n1, $n2 );
    $n2 = $byArgsCaseCount->next;
    for $n (@nodes) {
        next if ( $n->{'argsCard'} == 0 );
        for $n1 ( @{ $n->{'children'} } ) {
            $cat  = $n1->{'argsCard'};
            $cat1 = $n1->{'argsSet'};

            my @nodes2 = ();
            my ( $cat2, $num2 );

            while ($n2) {
                last
                  if ( $n2->get_column('argsCard') ne $cat
                    || $n2->get_column('argsSet') ne $cat1 );
                $cat2 = $n2->get_column('caso');
                $num2 = $n2->get_column('occs');
                my $num_1 = $n2->get_column('t_occs');
                push(
                    @nodes2,
                    {
                        argsCard => $cat,
                        argsSet  => $cat1,
                        caso     => $cat2,
                        occs     => $num2,
                        t_occs   => $num_1,
                    }
                );
                $n2 = $byArgsCaseCount->next;
            }

            $n1->{'children'} = \@nodes2;
        }
    }

    return \@nodes;
}

=cut

sub lemmaNumCatTree : Local {
    my ( $self, $c, $lemma ) = @_;

    my $byDiatesi =
      $c->model('DB::Forma')
      ->search( { 'me.lemma' => $lemma, 'argscats.root_id' => { '!=', undef } },
        { join => [ 'diatesicats', 'argscats' ] } );

    my $byDiatesiCount = $byDiatesi->search(
        undef,
        {
            select => [
                'argscats.argscard',   'argscats.argsSet',
                'diatesicats.diatesi', \'COUNT(argscats.root_id) AS occs',
            ],
            as       => [ 'argsCard', 'argsSet', 'diatesi', 'occs' ],
            group_by => [ 'argsCard', 'argsSet', 'diatesi' ],
            order_by => [ 'argsCard', 'argsSet', 'diatesi' ]
        }
    );

    my $byArgsCase = $byDiatesi->search( undef, { join => 'verbarguments' } );

    my $byArgsCaseCount = $byArgsCase->search(
        undef,
        {
            select => [
                'argscats.argscard',
                'argscats.argsSet',
                'diatesicats.diatesi',
                'verbarguments.rCase',
                \'COUNT(verbarguments.root_id) AS occs',
                \'COUNT( DISTINCT verbarguments.root_id) AS t_occs'
            ],
            as =>
              [ 'argsCard', 'argsSet', 'diatesi', 'caso', 'occs', 't_occs' ],
            group_by => [ 'argsCard', 'argsSet', 'diatesi', 'rCase' ],
            order_by => [ 'argsCard', 'argsSet', 'diatesi', 'rCase' ]
        }
    );

    my @nodes = @{ argsNumCatTree( $self, $c, $lemma ) };

    my ( $cat, $cat1 );
    my ( $n, $n1, $n2, $nD );
    $n2 = $byArgsCaseCount->next;
    $nD = $byDiatesiCount->next;
    for $n (@nodes) {
        next if ( $n->{'argsCard'} == 0 );
        for $n1 ( @{ $n->{'children'} } ) {
            $cat  = $n1->{'argsCard'};
            $cat1 = $n1->{'argsSet'};

            my @nodesD = ();
            my ( $catD, $numD );

            while ($nD) {
                last
                  if ( $nD->get_column('argsCard') ne $cat
                    || $nD->get_column('argsSet') ne $cat1 );
                $catD = $nD->get_column('diatesi');
                $numD = $nD->get_column('occs');

####
                my @nodes2 = ();
                my ( $cat2, $num2 );

                while ($n2) {
                    last
                      if ( $n2->get_column('argsCard') ne $cat
                        || $n2->get_column('argsSet') ne $cat1 
                      || $n2->get_column('diatesi') ne $catD );
                    $cat2 = $n2->get_column('caso');
                    $num2 = $n2->get_column('occs');
                    my $num_1 = $n2->get_column('t_occs');
                    push(
                          @nodes2,
                          {
                              argsCard => $cat,
                              argsSet  => $cat1,
                              diatesi  => $catD,
                              caso     => $cat2,
                              occs     => $num2,
                              t_occs   => $num_1,
                          }
                    );
                    $n2 = $byArgsCaseCount->next;
                }

####
                push(
                      @nodesD,
                      {
                          argsCard => $cat,
                          argsSet  => $cat1,
                          diatesi  => $catD,
                          occs     => $numD,
                          children => \@nodes2,
                      }
                );
                $nD = $byDiatesiCount->next;
            }

            $n1->{'children'} = \@nodesD;
        }
    }

    return \@nodes;
}


=head2 lemmaFillers

=cut

sub lemmaFillers : Local {
    my ( $self, $c, $lemma ) = @_;

    my $Fillers =
      $c->model('DB::Forma')
      ->search(
        { 'me.lemma' => $lemma, 'verbarguments.root_id' => { '!=', undef } },
        { join => 'verbarguments', } );

    my $byLemmaCount = $Fillers->search(
        {},
        {
            select   => [ 'verbarguments.lemma', { count => '*' } ],
            group_by => ['verbarguments.lemma'],
            order_by => ['verbarguments.lemma'],
            as => [ 'lemma', 'occs' ],
        }
    );

    my $byRelationCount = $Fillers->search(
        {},
        {
            select => [ 'verbarguments.lemma', 'relation', { count => '*' } ],
            group_by => [ 'verbarguments.lemma', 'relation' ],
            order_by => [ 'verbarguments.lemma', 'relation' ],
            as       => [ 'lemma',               'relation', 'occs' ],
        }
    );

    my $byCaseCount = $Fillers->search(
        {},
        {
            select =>
              [ 'verbarguments.lemma', 'relation', 'rCase', { count => '*' } ],
            group_by => [ 'verbarguments.lemma', 'relation', 'rCase' ],
            order_by => [ 'verbarguments.lemma', 'relation', 'rCase' ],
            as       => [ 'lemma',               'relation', 'caso', 'occs' ],
        }
    );

    my @nodes = ();
    my ( $cat, $num );
    my ( $n1,  $n2 );
    $n1 = $byRelationCount->next;
    $n2 = $byCaseCount->next;
    while ( my $n = $byLemmaCount->next ) {
        $cat = $n->get_column('lemma');
        $num = $n->get_column('occs');

        my @nodes1 = ();
        my ( $cat1, $num1 );

        while ($n1) {
            last if ( $n1->get_column('lemma') ne $cat );
            $cat1 = $n1->get_column('relation');
            $num1 = $n1->get_column('occs');

            my @nodes2 = ();
            my ( $cat2, $num2 );

            while ($n2) {
                last
                  if ( $n2->get_column('lemma') ne $cat
                    || $n2->get_column('relation') ne $cat1 );
                $cat2 = $n2->get_column('caso');
                $num2 = $n2->get_column('occs');
                push(
                    @nodes2,
                    {
                        filler   => $cat,
                        relation => $cat1,
                        caso     => $cat2,
                        occs     => $num2,
                    }
                );
                $n2 = $byCaseCount->next;
            }

            push(
                @nodes1,
                {
                    filler   => $cat,
                    relation => $cat1,
                    occs     => $num1,
                    children => \@nodes2
                }
            );
            $n1 = $byRelationCount->next;
        }

        push(
            @nodes,
            {
                filler   => $cat,
                occs     => $num,
                children => \@nodes1
            }
        );
    }

    return \@nodes;
}

=head2 catIndexTree
      Indice delle categorie per lemma, mediante tree di Json

=cut

sub catIndexTree : Local : Args(0) {
    my ( $self, $c, $lemma ) = @_;
    $lemma = $c->request->params->{lemma};
    $c->stash->{lemma} = $lemma;
    $c->stash->{lemmaCount} =
      $c->model('DB::Forma')->search( { 'me.lemma' => $lemma } )->count;
    $c->stash->{lemmaInfo} =
      $c->model('DB::Forma')
      ->search( { 'me.lemma' => $lemma }, { select => ['cat_fl'] } )->first;

    $c->stash->{'cardCatIndex'} = lemmaNumCatTree( $self, $c, $lemma );
    $c->stash->{'lemmaFillers'} = lemmaFillers( $self, $c, $lemma );

    $c->stash->{'template'} = 'verbo/lemmaIndex.tt2';
    $c->stash->{no_wrapper} = 1;
}

sub showLemma : Local {

    #my ($self, $c, $lemma, $card, $set, $case) = @_;

##   DUPLICO DA LIST----------
    my ( $self, $c ) = @_;

    #    my ( $orderby, $dir, $filter, $update) ;
    my $lemma;

    my ( $argsCard, $argsSet );

    #
    my ($argsCase);

    my ( $filler, $fillerRel );

    my ( $relOrderType, $relOrderCat, $relOrderSubCat );
    my $catOrderField;

    my ($diatesi);

    $lemma = $c->request->params->{lemma};

    #    $filter = $c->request->params->{filter};
    #    $orderby = $c->request->params->{orderby};
    #    $dir = $c->request->params->{dir};

    #    $update = $c->request->params->{update};

    $argsCard = $c->request->params->{argsCard};
    $argsSet  = $c->request->params->{argsSet};

    $argsCase = $c->request->params->{argsCase};

    $filler    = $c->request->params->{filler};
    $fillerRel = $c->request->params->{fillerRel};

    $relOrderType   = $c->request->params->{relOrderType};
    $relOrderCat    = $c->request->params->{relOrderCat};
    $relOrderSubCat = $c->request->params->{relOrderSubCat};
    $catOrderField  = 'argsorder_' . $relOrderType if ($relOrderType);

    $diatesi   = $c->request->params->{diatesi};
    #    $filter="" unless ($filter);
    #    $orderby="lemma" unless ($orderby);
    #    $dir="asc" unless ($dir);

    my %Filter;

    #$Filter{'-or'} = [ pos => '2', pos => '3'];
    $Filter{'-or'} = [ 'me.pos' => '2', 'me.pos' => '3' ];

    my $root_id;
    if ( defined $argsCard || $argsSet ) {
        $root_id = 'argscats.root_id';
    }
    elsif ($catOrderField) {
        $root_id = 'argscatorders.root_id';
    }
    elsif ($filler) {
        $root_id = 'verbarguments.root_id';
    }
    $Filter{$root_id} = undef
      if ( ( defined $argsCard ) && ( $argsCard == 0 ) );
    $Filter{$root_id} = { '!=', undef }
      if ( $argsCard || $argsSet || $catOrderField || $filler );

####
#$Filter{'root_id'} = undef if ( (defined $argsCard) && ( $argsCard == 0) );
#$Filter{'root_id'} = { '!=', undef } if ( $argsCard || $argsSet || $catOrderField );
####

    # $Filter{'lemma'}= { 'like' => $filter } if ($filter);
    $Filter{'me.lemma'} = $lemma if ($lemma);

    $Filter{'argscard'} = $argsCard if ($argsCard);
    $Filter{'argsset'}  = $argsSet  if ($argsSet);

    #
    $Filter{'rCase'} = $argsCase if ($argsCase);

    $Filter{'verbarguments.lemma'} = $filler    if ($filler);
    $Filter{'relation'}            = $fillerRel if ($fillerRel);

    $Filter{$catOrderField} = $relOrderCat if ($catOrderField);
    $Filter{'argsorder'} = $relOrderSubCat if ($relOrderSubCat);

    $Filter{'diatesi'} = $diatesi if ($diatesi);

    my $lemmiVerbali;
    if ( defined $argsCard || $argsSet ) {
        if ( defined $argsCase ) {
            $lemmiVerbali =
              $c->model('DB::Forma')
#              ->search( %Filter, { join => [ 'argscats', 'verbarguments' ] } );
              ->search( %Filter, { join => [ 'argscats', 'diatesicats', 'verbarguments' ] } );
        }
        elsif ( defined $diatesi ) {
            $lemmiVerbali =
              $c->model('DB::Forma')
              ->search( %Filter, { join => ['argscats', 'diatesicats'] } );
        } else {
            $lemmiVerbali =
              $c->model('DB::Forma')
              ->search( %Filter, { join => 'argscats', } );
        }
#        else {
#            $lemmiVerbali =
#              $c->model('DB::Forma')
#              ->search( %Filter, { join => 'argscats', } );
#        }
    }
    elsif ($catOrderField) {
        $lemmiVerbali =
          $c->model('DB::Forma')
          ->search( %Filter, { join => 'argscatorders', } );
    }
    elsif ($filler) {
        $lemmiVerbali =
          $c->model('DB::Forma')
          ->search( %Filter, { join => 'verbarguments', } );
    }
    else {
        $lemmiVerbali = $c->model('DB::Forma')->search(%Filter);
    }
######### duplico da list

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
        %pageFilter,
        {
            join     => 'frase',
            order_by => ['me.frase'],
            +select => [ 'me.id', 'frase.code' ],
            +as     => [ 'root',  'sentence' ]
        }
    );

    $c->stash->{sentTree} = [ $sentTree->all ];

    my $tokens;

    $tokens = $lemmiVerbali->search(
        %pageFilter,
        {
            join    => { 'frase' => 'formas' },
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
            group_by => [ 'formas.frase', 'formas.rank' ],
            order_by => [ 'formas.frase', 'formas.rank' ],
        }
    );

    $c->stash->{tokensVerbali} = [ $tokens->all ];

    my $args = $lemmiVerbali->search(
        %pageFilter,
        {
            prefetch => ['verbarguments'],
            +select  => ['verbarguments.arg_id'],
            +as      => ['arg_id'],
        }
    );

    $c->stash->{arguments} = [ $args->all ];

    #if ($argsCard != 0) {
    if ( $argsCard || $argsSet || $catOrderField || $filler || $lemma ) {

        my $trees;

        # patch:
        $pageFilter{"path_root_ids.root_id"} = { '!=', undef }
          if ( !( $argsCard || $argsSet || $catOrderField || $filler ) );

        $trees = $lemmiVerbali->search(
            %pageFilter,
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
                ]
            }
        );

        buildTree($trees);

    }

    $c->stash->{lemma}       = $lemma;
    $c->stash->{cardinality} = $argsCard if ( defined $argsCard );
    $c->stash->{set}         = $argsSet if ($argsSet);

    $c->stash->{relation} = $relOrderType;
    $c->stash->{orderRel} = $relOrderCat;
    $c->stash->{order}    = $relOrderSubCat if ($relOrderSubCat);

    $c->stash->{catType}  = 'args'     if ($filler);
    $c->stash->{argLemma} = $filler    if ($filler);
    $c->stash->{argAfun}  = $fillerRel if ($fillerRel);

    $c->stash->{argCase} = $argsCase if ($argsCase);

    $c->stash->{diatesi} = $diatesi if ($diatesi);

    $c->stash->{no_wrapper} = 1;

    $c->stash->{template} = 'verbo/showLemma.tt2';

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

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

