#

for f in $(ls output_checked); do 
   php read_alaign.php output_checked/$f
done
