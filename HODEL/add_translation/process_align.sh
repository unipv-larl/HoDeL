

for p in {1..2};  do
   for b in {1..24}; do
      if [ "$p" -eq 1 -a "$b" -eq 1 ]; then
          i=1
      else 
          i=0;
      fi
      php5 sentences_alignment_6.php 0.5 0.3 0.2 0.3 $p $b
   done
done
