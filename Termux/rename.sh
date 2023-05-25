#bin/vash

# removing Angus-

for i in *;do mv $i `echo $i | tr -d "Angus-"`;done
