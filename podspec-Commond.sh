#! /bin/bash
DIR=$(cd $(dirname $0); pwd);
cd $DIR

paths="$( find  $DIR  -name *.podspec )"


funWithPod() {
while :
do
	podParams="--sources=https://gitlab.com/private-snipper-group/THSpecs,https://github.com/CocoaPods/Specs.git --allow-warnings --use-libraries --verbose"
	echo '1:本地验证（pod lib lint)；2:远程验证(pod spec lint);3:提交到远程仓库(pod repo push)'
	read aNum
	case $aNum in
	1)  commond="pod lib lint $1 $podParams"
		echo $commond
		$commond
	break;;
	2) commond="pod spec lint $1 $podParams"
		echo $commond
		$commond
	break;;
	3) commond="pod repo push $2 $1 $podParams"
		echo $commond
		$commond
	break;;
	*) echo '没有找到你想操作的命令'
	 	continue
	 	;;
	esac
done
	
}



funcWithPod() {

int=0
for file in ./*
do
    if test -f $file && [[ $file =~ \.podspec$ ]] #匹配文件名以.podspec 结尾
    then
       array[int]=$file
       let "int++"
    fi
done

length=${#array[@]}

if [[ $length == 1 ]]; then
	path=${array[0]}
	echo $path
	return

fi

spec="请选择一个spec文件:"
for (( i = 0; i < $int; i++ )); do
	spec+="$i:"${array[i]}";"
done

while :
do 
	echo $spec
	read aNum
	if [[ $aNum -lt $length ]]; then
		#statements
		#echo ${array[$aNum]}
		path=${array[$aNum]}
		#return ${array[$aNum]}
		break

	else
		continue
	fi

done
}

funcWithPod


podStorage="THLabSpec"
funWithPod $path $podStorage



