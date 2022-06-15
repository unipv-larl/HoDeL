package MyApp::View::TT;

use strict;
use utf8;
use base 'Catalyst::View::TT';

__PACKAGE__->config(TEMPLATE_EXTENSION => '.tt2',
        # Set the location for TT files
        INCLUDE_PATH => [
                MyApp->path_to( 'root', 'src' ),
            ],
        # Set to 1 for detailed timer stats in your HTML as comments
        TIMER              => 0,

        # This is your wrapper template located in the 'root/src'
#template esempio catalyst:
#        WRAPPER => 'wrapper.tt2',
#template1 emastic:
#        WRAPPER => 'template1.tt2',
#blueprint:
        WRAPPER => 'blueprint.tt2',
    VARIABLES => {
 CaseMoodV => {
'nom'   => 'Nominative',
'gen'   => 'Genitive',
'dat'   => 'Dative',
'acc'   => 'Accusative',
'voc'   => 'Vocative',
'ind'   => 'Indicative',
'sub'   => 'Subjunctive',
'inf'   => 'Infinitive',
'imp'   => 'Imperative',
'par'   => 'Participle',
'opt'   => 'Optative'
},
CaseMoodT => {
'nom'   => 'Case',
'gen'   => 'Case',
'dat'   => 'Case',
'acc'   => 'Case',
'voc'   => 'Case',
'ind'   => 'Mood',
'sub'   => 'Mood',
'inf'   => 'Mood',
'imp'   => 'Mood',
'par'   => 'Mood',
'opt'   => 'Mood'
}, 
CaseMoodO => {
'nom'   => 1,
'gen'   => 2,
'dat'   => 3,
'acc'   => 4,
'voc'   => 5,
'ind'   => 6,
'sub'   => 7,
'inf'   => 8,
'imp'   => 9,
'par'   => 10,
'opt'   => 11
}, 

Preps => [
'ἄγχι',
'ἀγχίμολον',
'ἀγχίμολος',
'ἅμα',
'ἀμφί',
'ἀμφίς',
'ἀνά',
'ἄνευθε',
'ἄντα',
'ἀντί',
'ἀντία',
'ἀντικρύ',
'ἀντίον',
'ἀντίος',
'ἀπάνευθε',
'ἀπό',
'ἀπονόσφι',
'ἆσσον',
'διά',
'διαμπερές',
'διαπρύσιος',
'διέκ',
'ἐγγύθεν',
'ἐγγύς',
'εἰς',
'εἴσω',
'ἐκ',
'ἑκάς',
'ἔκτοθεν',
'ἐκτός',
'ἔκτοσθε',
'ἔκτοσθεν',
'ἐν',
'ἔναντα',
'ἐναντίος',
'ἔνδοθι',
'ἔνερθε',
'ἐντός',
'ἔντοσθε',
'ἔντοσθεν',
'ἔξω',
'ἐπί',
'ἔσω',
'ζεύς',
'ἰθύς',
'καθύπερθε',
'κατά',
'καταντικρύ',
'κατεναντίον',
'κατόπισθεν',
'κάτος',
'μεσηγύ',
'μέσος',
'μετά',
'μετόπισθε',
'νόσφι',
'ὀπίσσω',
'παρά',
'παρέξ',
'πάροιθε',
'πάρος',
'πέραν',
'περί',
'πλησίος',
'πρό',
'προπάροιθε',
'πρός',
'πρόσθεν',
'πρόσθεϝ',
'σύν',
'σχεδόθεν',
'σχεδόν',
'τῆλε',
'ὕπαιθα',
'ὑπέκ',
'ὑπέρ',
'ὕπερθεν',
'ὑπό'
],

Conjs => [
'ἐάν',
'εἰ',
'εἰς',
'εἴτε',
'ἐπεί',
'ἤ',
'ἵνα',
'μή',
'ὁ',
'ὁπότε',
'ὅπως',
'ὅς',
'ὅτε',
'ὅτι',
'οὕνεκα',
'ὄφρα',
'πρίν',
'ὡς'
],

    },  
);

=head1 NAME

MyApp::View::TT - TT View for MyApp

=head1 DESCRIPTION

TT View for MyApp. 

=head1 SEE ALSO

L<MyApp>

=head1 AUTHOR

Paolo Ruffolo

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
