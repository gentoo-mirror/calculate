# Calculate comment=# name=ini.env.example append=after in(os_linux_pkglist,CLD,CLDL,CLDC,CLDM,CLDX,CCDX)!=
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
#=========================== User profile settings ===========================
#os_install_locale_language#
#?os_install_locale_language==ru#
#======================= Настройки профиля пользователя ======================
#os_install_locale_language#
#?os_install_locale_language==fr#
#======================= Paramètres de profil utilisateur ====================
#os_install_locale_language#
[profile]

#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Window border size
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер границы окна
#os_install_locale_language#
#?os_install_locale_language==fr#
# Épaisseur de la bordure des fenêtres
#os_install_locale_language#
; appearance-border =

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Mouse cursor theme
#os_install_locale_language#
#?os_install_locale_language==ru#
# Тема курсора мышки
#os_install_locale_language#
#?os_install_locale_language==fr#
# Thème du curseur de la souris
#os_install_locale_language#
; appearance-cursor = Calculate

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Icon theme
#os_install_locale_language#
#?os_install_locale_language==ru#
# Тема иконок
#os_install_locale_language#
#?os_install_locale_language==fr#
# Thème des icônes
#os_install_locale_language#
; appearance-icons = Calculate

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Look and feel
#os_install_locale_language#
#?os_install_locale_language==ru#
# Внешний вид
#os_install_locale_language#
#?os_install_locale_language==fr#
# Apparence
#os_install_locale_language#
; appearance-style =

#in#
#?in(os_linux_pkglist, CLD)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Desktop settings
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка рабочего стола
#os_install_locale_language#
#?os_install_locale_language==fr#
# Paramètres de bureau
#os_install_locale_language#
; appearance-theme =

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Desktop wallpaper. To change it, we recommended to use the parameters in
# the “theme” section
#os_install_locale_language#
#?os_install_locale_language==ru#
# Фоновое изображение рабочего стола. Рекомендуется менять обои при помощи
# настройки темы в секции "theme"
#os_install_locale_language#
#?os_install_locale_language==fr#
# Fond d’écran utilisateur. Il est recommandé d’utiliser les réglages
# appropriés de la section “thème” pour changer de fond d’écran
#os_install_locale_language#
; appearance-wallpaper =

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Font size
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер шрифта
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taille de la police
#os_install_locale_language#
; font-size = 10

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Keyboard delay (milliseconds)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Задержка нажатия клавиш в миллисекундах
#os_install_locale_language#
#?os_install_locale_language==fr#
# Délai de frappe du clavier (millisecondes)
#os_install_locale_language#
; keyboard-delay = 330

#in#
#?in(os_linux_pkglist, CLD, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Keyboard repeat rate (characters per second)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Частота повтора (знаков в секунду)
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taux de répétition du clavier (caractères/sec)
#os_install_locale_language#
; keyboard-rate = 30

#in#
#?in(os_linux_pkglist, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Mouse click policy ('single' or 'double')
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка клика мышки ('single' or 'double')
#os_install_locale_language#
#?os_install_locale_language==fr#
# Configuration du clic de la souris ('single' ou 'double')
#os_install_locale_language#
; mouse-clickpolicy = single

#in#
#?in(os_linux_pkglist, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Mouse double click delay (milliseconds)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Задержка в миллисекундах двойного клика мышки
#os_install_locale_language#
#?os_install_locale_language==fr#
# Délai du double-clic (millisecondes)
#os_install_locale_language#
; mouse-doubleclick-delayed = 400

#in#
#?in(os_linux_pkglist, CLDC, CLDC, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Left hand mouse configuration
#os_install_locale_language#
#?os_install_locale_language==ru#
# Настройка мышки для левшей.
#os_install_locale_language#
#?os_install_locale_language==fr#
# Configuration de la souris pour gaucher
#os_install_locale_language#
; mouse-lefthanded = off

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Time in seconds before an inactive computer is put to sleep, '0' - never
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в секундах, после которого усыпляется неактивный компьютер, '0' -
# никогда
#os_install_locale_language#
#?os_install_locale_language==fr#
# Hibernation après (secondes), '0', ne jamais faire hiberner
#os_install_locale_language#
; power-computer-sleep = 0

#in#
#?in(os_linux_pkglist, CLDC, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Time in seconds before the display is turned off when idle, '0' - never
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в секундах, после которого дисплей переходит в режим ожидания, '0' -
# никогда
#os_install_locale_language#
#?os_install_locale_language==fr#
# Mettre en veille après (secondes), '0', ne jamais arrêter
#os_install_locale_language#
; power-display-sleep = 30

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Activate screensaver when computer is idle
#os_install_locale_language#
#?os_install_locale_language==ru#
# Включать экранную заставку во время простоя компьютера
#os_install_locale_language#
#?os_install_locale_language==fr#
# Mettre en veille si l’ordinateur est inactif
#os_install_locale_language#
; screensaver-activation = on

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Screensaver activated after (minutes)
#os_install_locale_language#
#?os_install_locale_language==ru#
# Время в минутах до включения экранной заставки
#os_install_locale_language#
#?os_install_locale_language==fr#
# Économiseur d’écran activé après (minutes)
#os_install_locale_language#
; screensaver-delay = 10

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Lock screen when screensaver is active
#os_install_locale_language#
#?os_install_locale_language==ru#
# Блокировать доступ при отображении экранной заставки
#os_install_locale_language#
#?os_install_locale_language==fr#
# Verrouiller l'écran quand l'économiseur d'écran est actif
#os_install_locale_language#
; screensaver-lock = on

#in#
#?in(os_linux_pkglist, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Wallpaper change interval in minutes, '0' - newer
#os_install_locale_language#
#?os_install_locale_language==ru#
# Интервал смены обоев в минутах, '0' - никогда.
#os_install_locale_language#
#?os_install_locale_language==fr#
# Intervalle de changement de fond d’écran (minutes), '0', ne jamais changer
#os_install_locale_language#
; wallpaper-cycle = 0

#in#
#?in(os_linux_pkglist, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Icon size
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер иконок
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taille des icônes
#os_install_locale_language#
; wm-icon-size = 48

#in#
#?in(os_linux_pkglist, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Automatically hide the main panel
#os_install_locale_language#
#?os_install_locale_language==ru#
# Автоматически скрывать главную панель
#os_install_locale_language#
#?os_install_locale_language==fr#
# Cacher automatiquement la barre d’outils principale
#os_install_locale_language#
; wm-panel-main-autohide = off

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Main panel location: 'top', 'bottom', 'left', 'right'
#os_install_locale_language#
#?os_install_locale_language==ru#
# Расположение главной панели: 'top', 'bottom', 'left', 'right'
#os_install_locale_language#
#?os_install_locale_language==fr#
# Emplacement de la barre d’outils principale : 'top', 'bottom', 'left',
# 'right'
#os_install_locale_language#
; wm-panel-main-position = top

#in#
#?in(os_linux_pkglist, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Main panel size
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер главной панели
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taille de la barre d’outils principale
#os_install_locale_language#
; wm-panel-main-size = 32

#in#
#?in(os_linux_pkglist, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Automatically hide the menu panel
#os_install_locale_language#
#?os_install_locale_language==ru#
# Автоматически скрывать панель меню
#os_install_locale_language#
#?os_install_locale_language==fr#
# Cacher automatiquement la barre des menus
#os_install_locale_language#
; wm-panel-menu-autohide = on

#in#
#?in(os_linux_pkglist, CLDM)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Quick Launch toolbar location: 'top', 'bottom', 'left', 'right'
#os_install_locale_language#
#?os_install_locale_language==ru#
# Расположение панели быстрого запуска: 'top', 'bottom', 'left', 'right'
#os_install_locale_language#
#?os_install_locale_language==fr#
# Emplacement de la barre de lancement rapide : 'top', 'bottom', 'left', 'right'
#os_install_locale_language#
; wm-panel-menu-position = bottom

#in#
#?in(os_linux_pkglist, CLDM, CLDX, CCDX)!=#
#?os_install_locale_language!=ru&&os_install_locale_language!=fr#
# Quick Launch panel size
#os_install_locale_language#
#?os_install_locale_language==ru#
# Размер панели быстрого запуска
#os_install_locale_language#
#?os_install_locale_language==fr#
# Taille de la barre de lancement rapide
#os_install_locale_language#
; wm-panel-menu-size = 56

#in#

