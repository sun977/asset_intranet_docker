#!/bin/bash
# 1. 初始化防火墙
systemctl enable firewalld
systemctl restart firewalld
# 2. 添加rsync密钥
echo "abdkljfd1233ERGH12yfdfdfas996ndfjasdf22GHD" > /etc/rsync.pass
chmod 600 /etc/rsync.pass
# 3. 其它
rm -Rf /opt/python/GodV/
mkdir -p /opt/python/GodV_Intranet
mkdir -p /opt/python/GodV_Intranet/log
touch /opt/python/GodV_Intranet/log/run.log
#
rsync -vrtopg scanner@10.95.58.94::python/GodV_Intranet /opt/python/ --password-file=/etc/rsync.pass --exclude 'nohup.out'


# 计划任务
# 0  */6  *  *  *       root            sync && echo 3 >/proc/sys/vm/drop_caches
# *  *  *  *  *         root            rsync -vrtopg scanner@10.95.58.94::python/GodV_Intranet /opt/python/ --password-file=/etc/rsync.pass --exclude 'nohup.out'

# 安装Python模块 【可以安装成功---sun977】
/bin/python3 -m pip install --upgrade pip
pip3 --proxy http://10.252.16.53:3128/ install selenium impacket

# 安装浏览器驱动
yum install GConf2 chromium fontconfig freetype -y
