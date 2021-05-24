#!/bin/bash


STARTTIME=$(date +%s)

inf=`sed -e '/u'\''Traceback/{n;d;}' neutron-openvswitch-agent.log-20180129-1517214601 | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep INFO | wc -l`
war=`sed -e '/u'\''Traceback/{n;d;}' neutron-openvswitch-agent.log-20180129-1517214601 | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep WARNING | wc -l`
errwtb=`sed -e '/u'\''Traceback/{n;d;}' neutron-openvswitch-agent.log-20180129-1517214601 | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep ERROR | wc -l`
errtb=`cat neutron-openvswitch-agent.log-20180129-1517214601 | grep "u'Traceback" | wc -l`
err=$(($errwtb+$errtb))



echo "<html>
 <head>
  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
  <title>Веб-страница</title>
 </head>
 <body>
  <h1>Общая статистика лога</h1>
  <!-- Комментарий -->
  <p>INFO $inf</p>
  <p>WARNING $war</p>
  <p>ERROR $err</p>" > ./html/index.html


num=1
delta=1
start=1
step=50


while [ "$num" -lt 19453 ]
do
#echo

num=$(($num + $step))

#dat1=`sed "$start!D" neutron-openvswitch-agent.log-20180129-1517214601 | cut -c 1-19`
#dat2=`sed "$num!D" neutron-openvswitch-agent.log-20180129-1517214601 | cut -c 1-19`

#dat1=`sed "${num}q;d" neutron-openvswitch-agent.log-20180129-1517214601 | cut -c 1-19`

#echo $dat1
#echo $num

#if [ "$num" -lt 10000 ]
#then
dat1=`head -n $start neutron-openvswitch-agent.log-20180129-1517214601 | tail -n 1 | cut -c 1-19`
dat2=`head -n $num neutron-openvswitch-agent.log-20180129-1517214601 | tail -n 1 | cut -c 1-19`
#fi

#if [ "$num" -ge 10000 ]
#then
#dat1=`tail -n $start neutron-openvswitch-agent.log-20180129-1517214601 | head -n 1 | cut -c 1-19`
#dat2=`tail -n $num neutron-openvswitch-agent.log-20180129-1517214601 | head -n 1 | cut -c 1-19`
#echo $dat1
#echo $dat2
#echo $num

#fi

#echo $dat1
#echo $dat2
#echo $num
sec1=`date -d "$dat1" +%s`
sec2=`date -d "$dat2" +%s`

#echo $sec1
#echo $sc2

delta=$(($sec2-$sec1))

#echo $delta

if [ "$delta" -gt 21600 ]
then
#echo $num
#echo $start
num=$(($num - $step))
#echo $num
#echo $start
inf=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | sed -e '/u'\''Traceback/{n;d;}' | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep INFO | wc -l`
war=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | sed -e '/u'\''Traceback/{n;d;}' | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep WARNING | wc -l`
errwtb=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | sed -e '/u'\''Traceback/{n;d;}' | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep ERROR | wc -l`
errtb=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | grep "u'Traceback" | wc -l`
err=$(($errwtb+$errtb))

dat1=`head -n $start neutron-openvswitch-agent.log-20180129-1517214601 | tail -n 1 | cut -c 1-19`
dat2=`head -n $num neutron-openvswitch-agent.log-20180129-1517214601 | tail -n 1 | cut -c 1-19`


start="$num"


echo "<p> </p>
  <h2>Статистика лога с $dat1 по $dat2</h2>
  <p>INFO $inf</p>
  <p>WARNING $war</p>
  <p>ERROR $err</p>" >>./html/index.html

fi

done

<< 'MULTILINE-COMMENT'
MULTILINE-COMMENT


#dat3=`sed "$start!D" neutron-openvswitch-agent.log-20180129-1517214601 | cut -c 1-19`

#echo $dat3

#num=1


# date -d "$dat3" +%s

#inf=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | sed -e '/u'\''Traceback/{n;d;}' | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep INFO | wc -l`
#war=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | sed -e '/u'\''Traceback/{n;d;}' | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep WARNING | wc -l`
#errwtb=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | sed -e '/u'\''Traceback/{n;d;}' | grep -v "Failed reporting state" | sed '/Traceback/,/u'\''Traceback/d' | grep ERROR | wc -l`
#errtb=`sed -n "$start","$num"p neutron-openvswitch-agent.log-20180129-1517214601 | grep "u'Traceback" | wc -l`
#err=$(($errwtb+$errtb))

#echo "<p> </p>
#  <h2>Статистика лога с $dat1 по $dat2</h2>
#  <p>INFO $inf</p>
#  <p>WARNING $war</p>
#  <p>ERROR $err</p>" >>./html/index.html

ENDTIME=$(date +%s)

DIFFTIME=$(( $ENDTIME - $STARTTIME ))



echo "<p>start $start </p>
  <p>num $num </p>
  <p>Время выполнения $DIFFTIME</p>" >>./html/index.html

echo "</body>
</html>" >>./html/index.html

