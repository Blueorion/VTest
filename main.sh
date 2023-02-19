#!/bin/sh
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
blue(){ echo -e "\033[36m\033[01m$1\033[0m";}
chmod a+x ./python/web
uuid=${uuid:-$REPL_ID}
cp -f ./python/config.json /tmp/config.json
sed -i "s|uuid|$uuid|g" /tmp/config.json
sed -i "s#[0-9a-f]\{8\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{12\}#$uuid#g" /tmp/config.json
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
v4=$(curl -s4m6 ip.sb -k)
v4l=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"'`
    xver=`./python/web version | sed -n 1p | awk '{print $2}'`
    echo
    green "当前已安装Xray正式版本：$xver"
    echo
    green "当前检测到的IP：$v4    地区：$v4l"
    echo
     blue "五大协议相关信息如下------------------------------"
echo
    yellow "1：vmess+ws+tls配置明文如下，相关参数可复制到客户端"
    echo "服务器地址：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "端口：443"
    echo "uuid：$uuid"
    echo "传输协议：ws"
    echo "host/sni：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "path路径：/$uuid-vm"
    echo "tls：开启"
    echo
replit_vmess="vmess://$(echo -n "\
{\
\"v\": \"2\",\
\"ps\": \"replit_vmess\",\
\"add\": \"${REPL_SLUG}.${REPL_OWNER}.repl.co\",\
\"port\": \"443\",\
\"id\": \"$uuid\",\
\"aid\": \"0\",\
\"net\": \"ws\",\
\"type\": \"none\",\
\"host\": \"${REPL_SLUG}.${REPL_OWNER}.repl.co\",\
\"path\": \"/$uuid-vm\",\
\"tls\": \"tls\"\
}"\
    | base64 -w 0)"   
yellow "分享链接如下"    
echo "${replit_vmess}"
echo
yellow "二维码如下"
qrencode -t ansiutf8 ${replit_vmess}
echo
blue "-------------------------------------------"
echo
yellow "2：vless+ws+tls配置明文如下，相关参数可复制到客户端"
    echo "服务器地址：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "端口：443"
    echo "uuid：$uuid"
    echo "传输协议：ws"
    echo "host/sni：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "path路径：/$uuid-vl"
    echo "tls：开启"
    echo
replit_vless="vless://${uuid}@${REPL_SLUG}.${REPL_OWNER}.repl.co:443?encryption=none&security=tls&type=ws&host=${REPL_SLUG}.${REPL_OWNER}.repl.co&path=/$uuid-vl#replit_vless"
yellow "分享链接如下"    
echo "${replit_vless}"
echo
yellow "二维码如下"
qrencode -t ansiutf8 ${replit_vless}
echo
blue "-------------------------------------------"
echo
yellow "3：trjan+ws+tls配置明文如下，相关参数可复制到客户端"
    echo "服务器地址：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "端口：443"
    echo "密码：$uuid"
    echo "传输协议：ws"
    echo "host/sni：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "path路径：/$uuid-tr"
    echo "tls：开启"
    echo
echo 
replit_trojan="trojan://${uuid}@${REPL_SLUG}.${REPL_OWNER}.repl.co:443?security=tls&type=ws&host=${REPL_SLUG}.${REPL_OWNER}.repl.co&path=/$uuid-tr#replit_trojan"
yellow "分享链接如下"    
echo "${replit_trojan}"
echo
yellow "二维码如下"
qrencode -t ansiutf8 ${replit_trojan}
echo 
blue "-------------------------------------------"
echo
yellow "4：shadowsocks+ws+tls配置明文如下，相关参数可复制到客户端"
    echo "服务器地址：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "端口：443"
    echo "密码：$uuid"
    echo "加密方式：chacha20-ietf-poly1305"
    echo "传输协议：ws"
    echo "host/sni：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "path路径：/$uuid-ss"
    echo "tls：开启"
    blue "-------------------------------------------"
    echo
    yellow "5：socks+ws+tls配置明文如下，相关参数可复制到客户端"
    echo "服务器地址：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "端口：443"
    echo "用户名：$uuid"
    echo "密码：$uuid"
    echo "传输协议：ws"
    echo "host/sni：${REPL_SLUG}.${REPL_OWNER}.repl.co"
    echo "path路径：/$uuid-so"
    echo "tls：开启"
    blue "-------------------------------------------"
    echo
green "安装完毕===================================="
echo
echo "更新日志：
23.1.20更新：集成每10分钟自动唤醒功能
23.2.17更新：修复更新一键五协议共存

视频教程：https://www.youtube.com/@ygkkk
博客地址：https://ygkkk.blogspot.com"
echo
while true; do curl -s "https://${REPL_SLUG}.${REPL_OWNER}.repl.co" >/dev/null; echo "$(date +'%Y%m%d%H%M%S') 我还活着 ..."; sleep 600; done &
./python/web -c /tmp/config.json 2>&1 >/dev/null 
tail -f