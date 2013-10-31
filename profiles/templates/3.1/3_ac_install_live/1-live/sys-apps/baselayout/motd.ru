# Calculate append=replace os_install_locale_language==ru name=motd
Добро пожаловать в установочный диск #-os_install_linux_name-#!

Если какой-либо из сетевых адаптеров был обнаружен при загрузке, он будет
автоматически сконфигурирован, если в сети доступен DHCP сервер.
Для указания сетевых настроек используйте утилиту "cl-setup-network".
Пример:"cl-setup-network --ip enp0s0:no:192.168.1.100:24 \
        --route default:192.168.1.1 --dns 192.168.1.1"
#?os_install_linux_system==server||os_install_linux_shortname==CLS#
И перезапустите net.eth0 командой "/etc/init.d/net.eth0 restart".
#os_install_linux_system#
#?os_install_linux_system==desktop&&os_install_linux_shortname!=CLS#
И перезапустите NetworkManager командой "/etc/init.d/NetworkManager restart".
#os_install_linux_system#

Последняя версия руководства всегда доступна на веб-сайте Calculate Linux
http://www.calculate-linux.org/main/ru/handbook

Для запуска ssh сервера в системе, выполните "/etc/init.d/sshd start".

#?os_install_linux_system==server#
Для получения технической поддержки, выполните "irc".
#os_install_linux_system#
#?os_install_linux_system==desktop#
Пожалуйста сообщайте о любых найденных ошибках на
http://irc.calculate-linux.ru.
#os_install_linux_system#

Спасибо за использование Calculate Linux!
