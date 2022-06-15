<?php

//     *** STATS PARAMETERS ***
$VAR=6.8;  //variance
if ( isset($argv[1]) AND isset($argv[2]) AND isset($argv[3]) AND isset($argv[4]) ) {
$LEN_W=$argv[1];
$CAPS_W=$argv[2];
$PUNCT_W=$argv[3];
$SCORE_MIN=$argv[4];
} else {
$LEN_W=0.5;
$CAPS_W=0.3;
$PUNCT_W=0.2;
$SCORE_MIN=0.30;
}
//


//     *** INPUT PARAMETERS ***
//  $argv[7]  paragrafi

if ( isset($argv[5]) AND isset($argv[6]) ) {
   if ($argv[5] == 1 ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
       $poem="ILIAD";
   } elseif ($argv[5] == 2 ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg002.perseus-grc1";
       $poem="ODYSSEY";
   } else {
       print "ERRORE: poem??\n";
       exit;
   }
   
   $bookID=$argv[6];
} else {
$poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
$poem="ILIAD";
$bookID=1;
}
//


//OUTPUT FILES
$RESFILE="./out/alignment_res_".$poem."_".$bookID."_".".txt";
$LOGFILE="./log/tmp_log_".$poem."_".$bookID."_".".log";
$ERRFILE="./err/align_error_".$poem."_".$bookID."_".".log";



//LOG LEVEL
$LOG_LEVEL=0;

//FORMATS
$SEP1="\n----------------------------------------------------------------------\n";
$SEP2="\n======================================================================\n";
$SEP3="\n\n§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§\n";
$SEP4="\n\n########################################################################\n";



function match_scores($str_eng, $str_greek, $isAfterFS, $c, $s2) {
//strings
$s_eng=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str_eng);
$s_greek=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str_greek);

//length
$l_eng=grapheme_strlen($s_eng);
$l_greek=grapheme_strlen($s_greek);

//COUNT CAPS
// en
$s_eng_caps_search=$str_eng;
if ($isAfterFS)
   $s_eng_caps_search=preg_replace('/^[[:space:]"]*[[:upper:]]/u','',$s_eng_caps_search);
$s_eng_caps_search=str_replace('I ','',$s_eng_caps_search);
$s_eng_caps_search=preg_replace('/[.?!:][[:space:]"]*[[:upper:]]/u','',$s_eng_caps_search);
$s_eng_C=preg_replace('/[^[:upper:]]+/u', '',$s_eng_caps_search);
// gr
$s_greek_C=preg_replace('/[^[:upper:]]+/u', '', $s_greek);
$l_eng_C=grapheme_strlen($s_eng_C);
$l_greek_C=grapheme_strlen($s_greek_C);

//COUNT PUNCT
// en
$s_eng_P=preg_replace('/[^[:punct:]]+/u', '',$str_eng);
// gr
$s_greek_P=preg_replace('/[^[:punct:]]+/u', '', $str_greek);
$l_eng_P=grapheme_strlen($s_eng_P);
$l_greek_P=grapheme_strlen($s_greek_P);


//COUNT STRONG PUNCT
// en
$s_eng_SP=preg_replace('/[^.?!:]+/u', '',$s_eng_P);
// gr
$s_greek_SP=preg_replace('/[^.·;]+/u', '', $s_greek_P);
$l_eng_SP=grapheme_strlen($s_eng_SP);
$l_greek_SP=grapheme_strlen($s_greek_SP);

//COUNT Q Marks
// en
$s_eng_Q=preg_replace('/[^?]+/u', '',$s_eng_P);
// gr
$s_greek_Q=preg_replace('/[^;]+/u', '', $s_greek_P);
$l_eng_Q=grapheme_strlen($s_eng_Q);
$l_greek_Q=grapheme_strlen($s_greek_Q);


$m=( $l_eng + $l_greek/$c )/2;
$z=abs( $c*$l_eng - $l_greek ) / sqrt( $s2 * $m );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pd= 2*( 1 - $pnorm );

$res = array(
            'eng_length'=>$l_eng,
            'greek_length'=>$l_greek,
            'eng_no_caps'=>$l_eng_C,
            'greek_no_caps'=>$l_greek_C,
            'eng_no_punct'=>$l_eng_P,
            'greek_no_punct'=>$l_greek_P,
            'eng_no_s_punct'=>$l_eng_SP,
            'greek_no_s_punct'=>$l_greek_SP,
            'eng_no_qm'=>$l_eng_Q,
            'greek_no_qm'=>$l_greek_Q,
            'prob'=>$pd,
            'log_prob'=>($pd>0)?(-100*log($pd)):NULL
       );

return $res;
}

function score($str_eng,$str_greek,$isAfterFS=false, $mean=NULL, $var=NULL,$len_weight=NULL,$caps_weight=NULL,$punct_weight=NULL) {
    //use defaults?
    global $MEAN;
    global $VAR;
    global $LEN_W;
    global $CAPS_W;
    global $PUNCT_W;
    if(is_null($mean)) $mean=$MEAN;
    if(is_null($var)) $var=$VAR;
    if(is_null($len_weight)) $len_weight=$LEN_W;
    if(is_null($caps_weight)) $caps_weight=$CAPS_W;
    if(is_null($punct_weight)) $punct_weight=$PUNCT_W;
    
    $res=match_scores($str_eng, $str_greek, $isAfterFS, $mean, $var);
    
    //chech Capital Letters
    $diffNoCaps=$res['eng_no_caps']-$res['greek_no_caps'];
    $p_delta_C=(max($res['eng_no_caps'],$res['greek_no_caps'])>0)?
                1-abs($diffNoCaps)/max($res['eng_no_caps'],$res['greek_no_caps']):1.0;
    //
    
    //chech Strong Punct
    $diffNoPunct=$res['eng_no_s_punct']-$res['greek_no_s_punct'];
    $p_delta_P=(max($res['eng_no_s_punct'],$res['greek_no_s_punct'])>0)?
                abs($diffNoPunct)/max($res['eng_no_s_punct'],$res['greek_no_s_punct']):0;

    //weighted sum
    $score=$len_weight*$res['prob']+$caps_weight*$p_delta_C+$punct_weight*$p_delta_P;
    
    return $score;
}




function db_query($conn,$query){
    $queryRes=mysqli_query($conn,$query);
    if (!$queryRes ) {
        echo "DB ERROR\n";
        echo "MySQL: (" . mysqli_errno($conn) . ") " . mysqli_error($conn)."\n";
        echo "QUERY(".$query.")\n";
        exit;
    } 
    return $queryRes;
}

function my_log($msg,$echo = false, $msg_ll = 0) {
    global $LOGFILE;
    global $LOG_LEVEL;
    if ($echo) {
        echo $msg;
    }
    if ( $msg_ll<=$LOG_LEVEL )
    error_log($msg, 3, $LOGFILE);
}

function reset_log($store) {
    global $LOGFILE;
    global $ERRFILE;
    if ($store) {
        $curlog = file_get_contents($LOGFILE);
        file_put_contents($ERRFILE, $curlog, FILE_APPEND | LOCK_EX);
    }
    if(file_exists($LOGFILE))
    unlink($LOGFILE);
} 

//CONNECTION
$mysqli = new mysqli("localhost", "root", "PaShalom", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');



//poems
/*
$poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
*/

// STAT PARAMS
$query_stat="
SELECT poem_id, SUM(greek_para_l)/SUM(eng_para_l) AS c
FROM Book_paras
WHERE poem_id='".$poemID."'
GROUP BY poem_id
";
$result = db_query($mysqli,$query_stat);
$row = mysqli_fetch_array($result);
$MEAN=$row['c'];


//LOOP PARAS
$FILTER_PARA=(isset($argv[7]))?" AND start IN(".$argv[7].")":"";
$queryParas="
SELECT book_id, start AS para_start, end AS para_end, eng_para
FROM Book_paras
WHERE poem_id='".$poemID."'
 AND book_id= '".$bookID."'".
$FILTER_PARA.
"";
$Paras = db_query($mysqli,$queryParas);
$para_count=0;
$totEnSents=0;
$totGrSents=0;
$totMilestones=0;

reset_log(false);
if(file_exists($RESFILE))
unlink($RESFILE);

my_log( $SEP4."PARAMETERS: "."\n".
      "\tLEN_W=\t".$LEN_W."\n".
      "\tCAPS_W=\t".$CAPS_W."\n".
      "\tPUNCT_W=\t".$PUNCT_W."\n".
      "\tSCORE_MIN=\t".$SCORE_MIN.$SEP4, true);


while( $rowParas = mysqli_fetch_array($Paras) ) {
    
    $bookID = $rowParas['book_id'];
    $para_start = $rowParas['para_start'];
    $para_end = is_null($rowParas['para_end'])?"NULL":$rowParas['para_end'];
    
    my_log( "\nprocessing PARA: ".
          " BOOK=".$bookID.
          " START=".$para_start.
          " END=".$para_end . $SEP2, true);

    
    $paraFilter="poem_id='".$poemID."' AND book_id=".$bookID." AND para_start=".$para_start;
    $queryMS="SELECT ms_start, ms_end, ms_en
              FROM Para_en_ms
              WHERE ". $paraFilter;
    $Milestones = db_query($mysqli,$queryMS);
    $noMS=mysqli_num_rows($Milestones);

    $queryGR="SELECT sent_start, sent_end, sent_id, sent_gr
              FROM Para_gr_sents
              WHERE ". $paraFilter;
    $GrSents = db_query($mysqli,$queryGR);
    $noGrSents=mysqli_num_rows($GrSents);

    //INIT FRAMES STACK
    $para_frames=array();
    $frames=array();
    $frames[]=array(
                 'grStart' => 0,
                 'grEnd'   => $noGrSents-1,
                 'msStart' => 0,
                 'msEnd'   => $noMS-1,
                 'msStart_pos' => NULL,
                 'msEnd_pos'   => NULL,
             );

    $para_best_choices=array();
    my_log( "MILESTONES=".$noMS." GREEK SENTS=".$noGrSents."\n", true);
    $frame_iterations=1;
    while ( !empty($frames) ) {
        $frame=array_pop($frames);
        my_log( $SEP4."FRAME: START (MS=".$frame['msStart'].", POS=".$frame['msStart_pos'].
                            ") END (MS=".$frame['msEnd'].", POS=".$frame['msEnd_pos'].")\n",false);
        
        //choices init
        $frame_choicesScores=array();
        $frame_choices=array();

        // milestone content array
        $msContents=array();
        $msStart=array();
        $msEnd=array();
        $msIndex=$frame['msStart'];
        mysqli_data_seek($Milestones, $msIndex  );
        while ( $msIndex <= $frame['msEnd'] ) {
            $msRow=mysqli_fetch_array($Milestones);
            $msContents[]=$msRow['ms_en'];
            $msStart[]=$msRow['ms_start'];
            $msEnd[]=$msRow['ms_end'];
            $msIndex++;
        }  
        $noFrameMS=count($msContents);

        // greek sents array
        $grSentsContents=array();
        $grSentsContents_show=array();
        $grSentsStart=array();
        $grSentsEnd=array();
        $grIndex=$frame['grStart'];
        mysqli_data_seek($GrSents, $grIndex  );
        while ( $grIndex <= $frame['grEnd'] ) {
            $grRow=mysqli_fetch_array($GrSents);
            $grSentsContents[]=$grRow['sent_gr'];
            $grSentsContents_show[]=$grRow['sent_gr']."[".$grRow['sent_start'].",".$grRow['sent_end']."]";
            $grSentsStart[]=$grRow['sent_start'];
            $grSentsEnd[]=$grRow['sent_end'];
            $grIndex++;
        }  
        $noFrameGrSents=count($grSentsContents);
        $ctrl_grL=grapheme_strlen(implode('',$grSentsContents));
        $noChoises=0;
        
//        my_log("FRAME GR_SENTS_START:\n".print_r($grSentsStart,true),false);
//        my_log("FRAME GR_SENTS_END:\n".print_r($grSentsEnd,true),false);

        for ($msIndex=0; $msIndex<$noFrameMS; $msIndex++) {
            //prev milestones text
            $start_msText=( !is_null($frame['msStart_pos']) )?
                    substr($msContents[0],$frame['msStart_pos']):$msContents[0];
            $prev_msText=($msIndex>0)?$start_msText:'';
            $prev_msText.=($msIndex>1)?implode('',array_slice($msContents,1,$msIndex-1)):'';
            
            //succ milestones text
            $end_msText=(!is_null($frame['msEnd_pos']) )?
                    substr( $msContents[$noFrameMS-1], 0, $frame['msEnd_pos']+1 ):$msContents[$noFrameMS-1];
            $succ_msText=($msIndex<$noFrameMS-2)?implode('',array_slice($msContents,$msIndex+1,$noFrameMS-2-$msIndex)):'';
            $succ_msText.=($msIndex<$noFrameMS-1)?$end_msText:'';

            //milestone eng text
            if ($noFrameMS>1) {
                if ( $msIndex==0 ) {
                    $msText=$start_msText;
                } elseif ( $msIndex==$noFrameMS-1 ) {
                    $msText=$end_msText;
                } else {
                    $msText=$msContents[$msIndex];
                }
            } else {
                $start_offset=( !is_null($frame['msStart_pos']) )? $frame['msStart_pos']:0;
                if ( is_null($frame['msEnd_pos']) ) {
                    $msText=substr($msContents[0],$start_offset);
                } else {
                    $msText=substr($msContents[0],$start_offset,$frame['msEnd_pos']-$start_offset+1);
                }
            }
            //
            my_log( $SEP2."MILESTONE #".($msIndex+1)."(".$msStart[$msIndex].",".$msEnd[$msIndex].")\n", false,0 );
            my_log( "\tCONTENT(".$msText.")\n",false, 1 );
                  
            //prev greek text
            $prev_grText='';
            $prev_grText_show='';
            $last_prevIndex=NULL;
            $lower_bound=$msStart[$msIndex];
            if ($msIndex>0) {
                $prev_ends = array_filter($grSentsEnd, 
                                      function($end) use($lower_bound) {
                                                      return $end<$lower_bound; 
                                                 } );
                if ( !empty($prev_ends) ){
                    $last_prevIndex= max( array_keys($prev_ends) );
//                    $prev_grText=implode('',array_slice($grSentsContents,0,$last_prevIndex));
                    $prev_grText=implode('',array_slice($grSentsContents,0,$last_prevIndex+1));
                    $prev_grText_show=implode('',array_slice($grSentsContents_show,0,$last_prevIndex+1));
                }
            }

            //succ greek text
            $succ_grText='';
            $succ_grText_show='';
            $fisrt_succIndex=NULL;
            $upper_bound=$msEnd[$msIndex];
            if ($msIndex<$noFrameMS-1) {
                $succ_ends =array_filter($grSentsEnd, 
                                           function($end) use($upper_bound) {
                                                      return $end>$upper_bound; 
                                                 } );
                if ( !empty($succ_ends) ){
                    $fisrt_succIndex= min( array_keys($succ_ends) );
                    $succ_grText=implode('',array_slice($grSentsContents,$fisrt_succIndex));
                    $succ_grText_show=implode('',array_slice($grSentsContents_show,$fisrt_succIndex));
                }
            }
//
            
            //milestone greek sents
            $offset=is_null($last_prevIndex)?0:$last_prevIndex+1;
            if (is_null($fisrt_succIndex) ) {
                $grMS_sents=array_slice($grSentsContents, $offset);
                $grMS_sents_show=array_slice($grSentsContents_show, $offset);
            } else {
                $grMS_sents=array_slice($grSentsContents, $offset,$fisrt_succIndex-$offset);
                $grMS_sents_show=array_slice($grSentsContents_show, $offset,$fisrt_succIndex-$offset);
            }
            $no_greek_cuts=count($grMS_sents);
            my_log( "\tNo. Greek Sents=".$no_greek_cuts."/".(count($grSentsContents))."\n", false);
            //my_log( "\tOFFSET(".$offset.") LAST(".$last_prevIndex.") FIRST(".$fisrt_succIndex.")\n", false);
                    
            //find strong punct in text
            preg_match_all('~([.?!:])~',$msText,$out,PREG_OFFSET_CAPTURE);
            $msPunct=$out[1];
            $noPunct=count($msPunct);
            if ($noPunct>0 ){
                my_log( "\tNo. PUNCT=".$noPunct."\n", false);
                //print_r($msPunct);
                for ($punctIndex=0; $punctIndex<$noPunct; $punctIndex++) {
                    //get score for candidate division
                    $punct=$msPunct[$punctIndex];
                    $punct_pos=$punct[1];
                    $punct_type=$punct[0];
                    $pos=substr($msText,$punct_pos+1,1)=='"'?$pos=$punct_pos+2:$punct_pos+1;
                    $en_seg0=substr($msText,0,$pos);
                    $en_seg1=substr($msText,$pos);

                    $en_beforePart=$prev_msText.$en_seg0;
                    $en_afterPart=$en_seg1.$succ_msText;
                    if ( strlen(trim($en_beforePart))>0 AND strlen(trim($en_afterPart))>0 ) {                        
                        /*
                        my_log( "\nEN CUT:\n[".$en_beforePart."]\n".
                              "[".$en_afterPart."]\n" );
                        */
                        my_log( "\nEN CUT:\n[".$prev_msText."###".$en_seg0."]\n".
                              "[".$en_seg1."###".$succ_msText."]\n", false, 1 );
                        //                    

                        $search_greek_cuts_sep=implode(PHP_EOL,$grMS_sents);
                        for ($cut=0; $cut<$no_greek_cuts; $cut++) {
                            //before
                            $gr_seg0=implode('', array_slice($grMS_sents,0,$cut+1) );
                            $gr_beforePart=$prev_grText.$gr_seg0;
                            $gr_beforePart_show=$prev_grText_show."\n{{\n".implode(PHP_EOL, array_slice($grMS_sents_show,0,$cut+1) )."\n}}\n";
                            //after
                            $gr_seg1=($cut<$no_greek_cuts-1)?implode('', array_slice($grMS_sents,$cut+1) ):'';
                            $gr_afterPart=$gr_seg1.$succ_grText;
                            $gr_afterPart_show=($cut<$no_greek_cuts-1)?
                            "\n{{\n".implode(PHP_EOL, array_slice($grMS_sents_show,$cut+1) )."\n}}\n".$succ_grText_show:
                            $succ_grText_show;

                            if ( ( strlen(trim($gr_beforePart))>0 AND strlen(trim($gr_afterPart))>0 )
                               AND 
                                !(  ( strlen(trim($en_seg0))>0 AND strlen(trim($gr_seg0))==0 )
                                  OR( strlen(trim($en_seg0))==0 AND strlen(trim($gr_seg0))>0 )
                                  OR( strlen(trim($en_seg1))>0 AND strlen(trim($gr_seg1))==0 )
                                  OR( strlen(trim($en_seg1))==0 AND strlen(trim($gr_seg1))>0 )
                                 )
                               ){
/*
                                my_log( "GR #".($cut+1)."\n{".$gr_beforePart."}\n".
                                      "{".$gr_afterPart."}\n");
*/
                                my_log( "GR #".($cut+1)."\n{".$gr_beforePart_show."}\n".
                                      "{".$gr_afterPart_show."}\n",false,1);

//ALWAYS AFTER FS
/*                                      
                                $beforePart_score=score($en_beforePart, $gr_beforePart);
                                $afterPart_score=score($en_afterPart, $gr_afterPart);
*/
                                $beforePart_score=score($en_beforePart, $gr_beforePart,true);
                                $afterPart_score=score($en_afterPart, $gr_afterPart,true);
//                                
                                $noChoises++;
                                my_log( $SEP1."\t***  CHOICE #".$noChoises.": SCORES=(".$beforePart_score.",".$afterPart_score.")  ***\n",false,1);
                                
                                $frame_choicesScores[]=array($beforePart_score,$afterPart_score);
                                $pos_offset=($msIndex==0 AND !is_null($frame['msStart_pos']) )?
                                            $frame['msStart_pos']:0;
                                $frame_choices[]=array(
                                                        array(
                                                               'grStart' => $frame['grStart'],
//                                                               'grEnd'   => $frame['grStart']+$last_prevIndex+$cut+1,
                                                               'grEnd'   => $frame['grStart']+$offset+$cut,
                                                               'msStart' => $frame['msStart'],
                                                               'msEnd'   => $frame['msStart']+$msIndex,
                                                               'msStart_pos' => $frame['msStart_pos'],
                                                               'msEnd_pos'   => $pos_offset+$pos-1,
                                                        ),
                                                        array(
//                                                               'grStart' => $frame['grStart']+$last_prevIndex+$cut+2,
                                                               'grStart' => $frame['grStart']+$offset+$cut+1,
                                                               'grEnd'   => $frame['grEnd'],
                                                               'msStart' => $frame['msStart']+$msIndex,
                                                               'msEnd'   => $frame['msEnd'],
                                                               'msStart_pos' => $pos_offset+$pos,
                                                               'msEnd_pos'   => $frame['msEnd_pos'],
                                                        ),
                                                 );
                            }
                        }
                    }
                }
            } else {
                my_log( "\tNO PUNCT\n",false);
            }
            
        } // loop frame milestones
        
        if ( !empty($frame_choices) ) {
            //print_r($frame_choicesScores);
            //print_r($frame_choices);
            $scores_means = array_map(function($s) { return ($s[0]+$s[1])/2; }, $frame_choicesScores);
            //print_r($scores_means);
            $best_choice_value=max($scores_means);
            $para_best_choices[]=$best_choice_value;
            
            if ( $best_choice_value > $SCORE_MIN ) {
                $best_choice_indexes = array_keys($scores_means, $best_choice_value);
                $best_choice=$best_choice_indexes[0];   

                my_log( "*** BEST CHOICE(".$best_choice.",".$best_choice_value.") ***\n",false);
                array_push($frames,$frame_choices[$best_choice][1],$frame_choices[$best_choice][0]);
                my_log("FRAMES\n".print_r($frames,true)."\n");
            } else {
                //no choices above threshold
                my_log( "NO DIVISION ABOVE THRESHOLD\n",false);
                $para_frames[]=$frame;
                my_log("FRAMES\n".print_r($frames,true)."\n");
            }
        } else {
            //no choices
            my_log( "NO DIVISION\n",false);
            $para_frames[]=$frame;
            my_log("FRAMES\n".print_r($frames,true)."\n");
        }
        $frame_iterations++;
//        if ($frame_iterations>12) break; 
    } // loop frames
    my_log("\n PARA FRAMES: \n".print_r($para_frames,true));
    my_log("\n PARA BEST SCORES: \n".print_r($para_best_choices,true));
    my_log("\n FRAME ITERATIONS:". ($frame_iterations-1)."\n",true);

/////////  OUT ///////////////////
    
    $para_header = "\n\n".$SEP3.
              " START=".$para_start.
              " END=".$para_end .$SEP3;
    file_put_contents( $RESFILE, $para_header, FILE_APPEND | LOCK_EX ); 
       
    foreach ($para_frames as $frame) {

        // milestone content array
        $msContents=array();
        $msStart=array();
        $msEnd=array();
        $msIndex=$frame['msStart'];
        mysqli_data_seek($Milestones, $msIndex  );
        while ( $msIndex <= $frame['msEnd'] ) {
            $msRow=mysqli_fetch_array($Milestones);

            if ($frame['msStart']<$frame['msEnd']) {
                if ( $msIndex==$frame['msStart'] AND !is_null($frame['msStart_pos']) ) {
                    $msText=substr($msRow['ms_en'],$frame['msStart_pos'])."[".$msRow['ms_end']."]";
                } elseif ( $msIndex==$frame['msEnd'] AND !is_null($frame['msEnd_pos']) ) {
                    $msText=substr( $msRow['ms_en'], 0, $frame['msEnd_pos']+1 );
                } else {
                    $msText=$msRow['ms_en']."[".$msRow['ms_end']."]";
                }
            } else {
                $start_offset=( !is_null($frame['msStart_pos']) )? $frame['msStart_pos']:0;
                if ( is_null($frame['msEnd_pos']) ) {
                    $msText=substr($msRow['ms_en'],$start_offset);
                } else {
                    $msText=substr($msRow['ms_en'],$start_offset,$frame['msEnd_pos']-$start_offset+1);
                }
            }


            $msContents[]=$msText;
            $msStart[]=$msRow['ms_start'];
            $msEnd[]=$msRow['ms_end'];
            $msIndex++;
        }  
        $noFrameMS=count($msContents);
        $en_header=$SEP2."from MILESTONE ".max($msStart[0]-1,$para_start). 
                            " to MILESTONE ".end($msEnd);
        file_put_contents( $RESFILE, "\n\n".$en_header.$SEP2.implode('',$msContents), FILE_APPEND | LOCK_EX );

        // greek sents array
        $grSentsContents=array();
        $grSentsStart=array();
        $grSentsEnd=array();
        $grIndex=$frame['grStart'];
        mysqli_data_seek($GrSents, $grIndex  );
        while ( $grIndex <= $frame['grEnd'] ) {
            $grRow=mysqli_fetch_array($GrSents);
//            $grSentsContents[]=$grRow['sent_gr'];
            $grSentsContents[]=$grRow['sent_gr']."[".$grRow['sent_start'].",".$grRow['sent_end']."]";
            $grSentsStart[]=$grRow['sent_start'];
            $grSentsEnd[]=$grRow['sent_end'];
            $grIndex++;
        } 
         
        $noFrameGrSents=count($grSentsContents);
        
        $gr_header=$SEP1."from line ".$grSentsStart[0].
                            " to line ".end($grSentsEnd);
        file_put_contents( $RESFILE, $gr_header.$SEP1.implode(PHP_EOL,$grSentsContents).$SEP4, FILE_APPEND | LOCK_EX );
    }
    
/////////  OUT ///////////////////
    
    //break;
} //LOOP PARAS



?>
