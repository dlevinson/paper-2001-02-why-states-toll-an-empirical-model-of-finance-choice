BEGIN {}
{  
   apowst=substr(6,1)
   powstate=substr(7,2)
   pwgt1=substr(9,4)
   serialno=substr(13,7)
   field[powstate]+=pwgt1
}
END { for (i=1;i<100;i++) {print field[i]}}
