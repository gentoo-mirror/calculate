# Calculate comment=# name=ini.env.example append=after in(os_linux_pkglist,CLD,CLDL,CLDC,CLDM,CLDX)!=
#?os_install_locale_language!=ru#
#=========================== User profile settings ===========================
#os_install_locale_language#
#?os_install_locale_language==ru#
#======================= Настройки профиля пользователя ======================
#os_install_locale_language#
[profile]

#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Window border.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер границы окна.
#os_install_locale_language#
; appearance-border =

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Mouse cursor theme.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Тема курсора мышки.
#os_install_locale_language#
; appearance-cursor = Calculate

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Icon theme.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Тема иконок.
#os_install_locale_language#
; appearance-icons = Calculate

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Look and feel.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Внешний вид.
#os_install_locale_language#
; appearance-style =

#in#
#?in(os_linux_pkglist, CLD)!=#
#?os_install_locale_language!=ru#
# Desktop theme.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка рабочего стола.
#os_install_locale_language#
; appearance-theme =

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Desktop background.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Фоновое изображение рабочего стола. Эффективней менять обои при помощи
# настройки темы в секции "theme".
#os_install_locale_language#
; appearance-wallpaper =

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Font size.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер шрифта.
#os_install_locale_language#
; font-size = 10

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Keyboard delay.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Задержка нажатия клавиш в миллисекундах.
#os_install_locale_language#
; keyboard-delay = 330

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Keyboard rate.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Частота повтора (знаков в секунду).
#os_install_locale_language#
; keyboard-rate = 30

#in#
#?in(os_linux_pkglist, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Mouse click policy ('single' or 'double').
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка клика мышки ('single' or 'double').
#os_install_locale_language#
; mouse-clickpolicy = single

#in#
#?in(os_linux_pkglist, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Mouse doubleclick delayed.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Задержка в миллисекундах двойного клика мышки.
#os_install_locale_language#
; mouse-doubleclick-delayed = 400

#in#
#?in(os_linux_pkglist, CLDC, CLDC, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Setting up the mouse for left-handers.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка мышки для левшей.
#os_install_locale_language#
; mouse-lefthanded = off

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru#
# Time in seconds after which put the to sleep an inactive computer,
# '0' - newer.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в секундах, после которого усыпляется неактивный компьютер,
# '0' - никогда.
#os_install_locale_language#
; power-computer-sleep = 0

#in#
#?in(os_linux_pkglist, CLDC, CLDM)!=#
#?os_install_locale_language!=ru#
# Time in seconds after which the display is turned off when idle,
# '0' - newer.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в секундах, после которого дисплей переходит в режим ожидания,
# '0' - никогда.
#os_install_locale_language#
; power-display-sleep = 30

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru#
# Activate screensaver when computer is idle.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Включать экранной заставки во время простоя компьютера.
#os_install_locale_language#
; screensaver-activation = on

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru#
# Time in minutes, after which the computer is idle.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в минутах до включения экранной заставки.
#os_install_locale_language#
; screensaver-delay = 10

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru#
# Lock screen when screensaver is active.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Блокировать доступ при отображении экранной заставки.
#os_install_locale_language#
; screensaver-lock = on

#in#
#?in(os_linux_pkglist, CLDX)!=#
#?os_install_locale_language!=ru#
# The interval of changing wallpaper in minutes, '0' - newer.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Интервал смены обоев в минутах, '0' - никогда.
#os_install_locale_language#
; wallpaper-cycle = 0

#in#
#?in(os_linux_pkglist, CLDX)!=#
#?os_install_locale_language!=ru#
# Icon size.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер иконок.
#os_install_locale_language#
; wm-icon-size = 48

#in#
#?in(os_linux_pkglist, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Automatically hide the main panel.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Автоматически скрывать главную панель.
#os_install_locale_language#
; wm-panel-main-autohide = off

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru#
# Main panel location: 'top', 'bottom', 'left', 'right'.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Расположение главной панели: 'top', 'bottom', 'left', 'right'.
#os_install_locale_language#
; wm-panel-main-position = top

#in#
#?in(os_linux_pkglist, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# The size of the Main toolbar.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер главной панели.
#os_install_locale_language#
; wm-panel-main-size = 32

#in#
#?in(os_linux_pkglist, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# Automatically hide the menu panel.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Автоматически скрывать панель меню.
#os_install_locale_language#
; wm-panel-menu-autohide = on

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru#
# Quick Launch toolbar location: 'top', 'bottom', 'left', 'right'.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Расположение панели быстрого запуска: 'top', 'bottom', 'left', 'right'.
#os_install_locale_language#
; wm-panel-menu-position = bottom

#in#
#?in(os_linux_pkglist, CLDM, CLDX)!=#
#?os_install_locale_language!=ru#
# The size of the Quick Launch toolbar.
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер панели быстрого запуска.
#os_install_locale_language#
; wm-panel-menu-size = 56

#in#

