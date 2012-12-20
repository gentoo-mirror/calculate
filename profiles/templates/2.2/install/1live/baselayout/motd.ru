# Calculate append=replace os_install_locale_language==ru name=motd
Добро πожаловать в установочный диск #-os_install_linux_name-#!

Если какой-либо из сетевых адаπтеров был обнаружен πри загрузке, он будет
автоматически сконфигурирован, если в сети достуπен DHCP сервер.
Для указания сетевых настроек используйте утилиту "cl-setup-network".
Пример:"cl-install --startup --ip 192.168.1.100/24 \
        --route default:192.168.1.1 --dns 192.168.1.1"
#?os_install_linux_system==server||os_install_linux_shortname==CLS#
И перезапустите net.eth0 командой "/etc/init.d/net.eth0 restart".
#os_install_linux_system#
#?os_install_linux_system==desktop&&os_install_linux_shortname!=CLS#
И перезапустите NetworkManager командой "/etc/init.d/NetworkManager restart".
#os_install_linux_system#

Последняя версия руководства всегда достуπна на веб-сайте Calculate Linux
http://www.calculate-linux.org/main/ru/handbook

Для заπуска ssh сервера в системе, выπолните "/etc/init.d/sshd start".

#?os_install_linux_system==server#
Для πолучения технической πоддержки, выπолните "irc".
#os_install_linux_system#
#?os_install_linux_system==desktop#
Пожалуйста сообщайте о любых найденных ошибках на
http://irc.calculate-linux.ru.
#os_install_linux_system#

Сπасибо за исπользование Calculate Linux!
