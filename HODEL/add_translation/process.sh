
for p in {1..2};  do
      if [ "$p" -eq 1 ]; then
          i=1
      else 
          i=0;
      fi
      php5 get_paras.php $p $i
done


for p in {1..2};  do
   for b in {1..24}; do
      if [ "$p" -eq 1 -a "$b" -eq 1 ]; then
          i=1
      else 
          i=0;
      fi
      php5 init_aligment.php $p $b  $i
   done
done
