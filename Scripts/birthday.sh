#计算还有多少天过生日
#!/bin/bash
read -p "Enter you birthday (MMDD,ex>0707)" bth #-p,show the tips
now=$(date +%m%d)  #format date

#now == birthday
if [ $bth -eq $now ] ; then
	echo "Happy birthday"
#after
elif[ $bth -gt $now ];than
	year=$(date +%Y)
	total_d=$[$[$(date --date="$year$bth" +%s)-$(date +%s)]/60/24/60]
	echo "Your birthday will be $total_d later!"
#before now this year
else
	year=$[$(date +Y) + 1]
	total_d=$[$[$(date --date="$year$bth" +%s)-$(date +%s)]/60/24/60]
	echo "Your birthday will be $total_d later!"
fi

