BEGIN { for (i=1;i<100;i++){field[i]=0}}
{  
   powstate=$1
   pwgt1=$2
   serialno=$3
   field[powstate]+=pwgt1
}
END { for (i=1;i<100;i++) {print i,field[i]}}
