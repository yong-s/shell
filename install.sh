a=arm64
gitpro = 'https://ghproxy.com/'
if [[ $(uname -a | grep "x86_64") != "" ]]; then 
    a=amd64
fi ;

v=`curl ${gitpro}https://raw.githubusercontent.com/cdle/binary/main/compile_time.go --silent | tr -cd "[0-9]"`
d="${gitpro}https://raw.githubusercontent.com/cdle/binary/main/sillyGirl_linux_${a}_${v}"
echo "检测到版本 $v"
echo "正在从 $d 下载..."
curl -O $d 
mv sillyGirl sillyGirlBack && mv sillyGirl_linux_${a}_${v} sillyGirl
chmod +x sillyGirl
echo "已安装，开始运行..."
./sillyGirl -d