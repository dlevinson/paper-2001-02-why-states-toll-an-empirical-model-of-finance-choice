BEGIN {for (i=0;i<100;i++){field[i]=0}}
{  
   powstate=$1
   powstatx=powstate/1
   pwgt1=$2
   serialno=$3
   field[powstatx]+=pwgt1
   total+=pwgt1
}
END { printf ("%3s %-20s\n","x",FILENAME);
      printf ("%3s %16d\n","x",total);
      for (i=0;i<100;i++) {printf("%3d %16d\n",i,field[i])}}
