#!/bin/bash

#detect and refuse to run under WSL
if [ -d /mnt/c ]; then
    echo "WSL is NOT supported."
    exit 1
fi

sed -i 's/tencentyun/aliyun/g' /etc/apt/sources.list
sed -i 's/cn.archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list

apt update && apt -y upgrade

apt install -y software-properties-common
add-apt-repository universe
add-apt-repository multiverse
add-apt-repository restricted


apt update && apt -y upgrade

/usr/sbin/useradd -m -u 1536 judge
cd /home/judge/ || exit


#svn co https://github.com/zhblue/hustoj/trunk/trunk/  src

#手工解决阿里云软件源的包依赖问题
apt install libssl1.1=1.1.1f-1ubuntu2.8 -y --allow-downgrades
apt-get install -y libmysqlclient-dev
apt-get install -y libmysql++-dev 

for pkg in net-tools make g++ tzdata
do
	while ! apt-get install -y "$pkg" 
	do
		echo "Network fail, retry... you might want to change another apt source for install"
		echo "Or you might need to add [universe] [multiverse] to your /etc/apt/sources.list"
	done
done

CPU=$(grep "cpu cores" /proc/cpuinfo |head -1|awk '{print $4}')

mkdir etc data log backup

cp src/install/java0.policy  /home/judge/etc
cp src/install/judge.conf  /home/judge/etc

# create enough runX dirs for each CPU core
if grep "OJ_SHM_RUN=0" etc/judge.conf ; then
	for N in `seq 0 $(($CPU-1))`
	do
	   mkdir run$N
	   chown judge run$N
	done
fi

sed -i "s/OJ_COMPILE_CHROOT=1/OJ_COMPILE_CHROOT=0/g" etc/judge.conf
sed -i "s/OJ_RUNNING=1/OJ_RUNNING=$CPU/g" etc/judge.conf

chmod 700 backup
chmod 700 etc/judge.conf

chown judge:judge data
chmod 711 -R data

COMPENSATION=$(grep 'mips' /proc/cpuinfo|head -1|awk -F: '{printf("%.2f",$2/5000)}')
sed -i "s/OJ_CPU_COMPENSATION=1.0/OJ_CPU_COMPENSATION=$COMPENSATION/g" etc/judge.conf

cd src/core || exit 
chmod +x ./make.sh
./make.sh
if grep "bak.sh" /var/spool/cron/crontabs/root ; then
	echo "auto backup added!"
else
	crontab -l > conf && echo "1 0 * * * /home/judge/src/install/bak.sh" >> conf && crontab conf && rm -f conf
	service cron reload
fi
ln -s /usr/bin/mcs /usr/bin/gmcs

/usr/bin/judged
cp /home/judge/src/install/hustoj /etc/init.d/hustoj
update-rc.d hustoj defaults
systemctl enable hustoj

mkdir /var/log/hustoj/
chown www-data -R /var/log/hustoj/
cd /home/judge/src/install
cls
reset

echo "Remember your database account for HUST Online Judge:"
echo "username:$USER"
echo "password:$PASSWORD"
echo "DO NOT POST THESE INFORMATION ON ANY PUBLIC CHANNEL!"
echo "Register a user as 'admin' on http://127.0.0.1/ "
echo "打开http://127.0.0.1/ 注册用户admin，获得管理员权限。"
