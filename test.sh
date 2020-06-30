


stc(){





aa=$(echo ${#2})

bb=$(grep -o $2 *.rec | wc -l)
if [ "$num" = "stc" ]

then 

printf "The student id should be 6 numbers. \n"

exit 1

elif [ "$bb" -eq 0 ]

then

printf "The student with id: $2 is not registered in any course. \n"

elif [ "$num" = ".stc$2" ] && [ "$aa" -eq 6 ] 

then

cat *.rec |grep -B 15 "$2"|grep -i "COURSE"|cut -c 20- |sed 's/^[ \t]*//g'|sed 's/[ \t]*$//g'| sed 's/$/& which has/g' >> singlecourse.rec

cat *.rec | grep  -B 15 "$2" |grep -i "CREDITS"| cut -c 12- |sed 's/^[ \t]*//g'| sed 's/$/& credits/g' >> singlecredit.rec

paste singlecourse.rec singlecredit.rec > output.rec

printf "The student with id:$2, is registered in the following courses: \n $(cat output.rec)

"
rm singlecourse.rec singlecredit.rec output.rec

exit 1


else 

printf "The student id should be 6 numbers. \n"

fi
}


gpa(){
if [ "$num" = ".gpa$3" ]

then

course_set=`find . -name "*.rec" -perm -u=r`

for course in $course_set
do 
cat $course | grep "$3" | cut -c 7- | awk ' {for (i=1; i<=NF; i++) sum += $i; print sum;} ' >> singlegpa.rec


done


cat *.rec | grep  -B 15 "$3" |grep -i "CREDITS"| cut -c 12- |sed 's/^[ \t]*//g' >> singlecredit.rec


paste singlegpa.rec singlecredit.rec >> ssgpa.rec

awk '{print $1*$2}' ssgpa.rec >> bbgpa.rec

awk '{sum += $1};END {print sum}' bbgpa.rec >> gpa.rec

awk '{sum += $1};END {print sum}' singlecredit.rec >>gpa2.rec

paste gpa.rec gpa2.rec > finalgpa.rec

printf "$(awk '{print $1/$2}' finalgpa.rec | sed "s/\..*//g"  ) \n"


rm ssgpa.rec singlegpa.rec singlecredit.rec gpa.rec bbgpa.rec gpa2.rec finalgpa.rec



else

printf "The student id should be 6 numbers. \n"

exit 1

fi
}

case $2 in
	stc) stc;;	
	gpa) gpa;;
esac

exit 0






















