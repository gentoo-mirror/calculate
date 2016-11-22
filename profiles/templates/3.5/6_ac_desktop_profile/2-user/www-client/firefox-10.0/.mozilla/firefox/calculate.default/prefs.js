#размер дисковой квоты под кэш (в Кб)
user_pref("browser.cache.disk.capacity", 5000);
#сохранять файлы без запроса на выбор пути
user_pref("browser.download.useDownloadDir", false);
#отключить проверку браузера по умолчанию
user_pref("browser.shell.checkDefaultBrowser", false);
#домашняя страница
#?os_locale_language!=ru#
user_pref("browser.startup.homepage", "http://start.calculate-linux.org");
#!os_locale_language#
user_pref("browser.startup.homepage", "http://start.calculate-linux.ru");
#os_locale_language#
#версия последнего браузера, открывшего текущий профиль (нужно чтобы не отправлял на сайт firefox)
user_pref("browser.startup.homepage_override.mstone", "ignore");
#скрывать панель вкладок когда открыта только одна страница
user_pref("browser.tabs.autoHide", false);
#отключить вопрос при закрытии браузерв
user_pref("browser.tabs.warnOnClose", false);
#не показывать окно закачек при добавлении закачек
user_pref("browser.download.manager.showAlertOnComplete", false);
user_pref("browser.download.manager.showWhenStarting", false);
#установить google как поисковик по умолчанию
#?os_locale_language==ru#
user_pref("keyword.URL", "http://www.google.ru/search?q=");
#!os_locale_language#
user_pref("keyword.URL", "http://www.google.com/search?q=");
#os_locale_language#

#отключаем помощь mozilla
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.enabled", false);
