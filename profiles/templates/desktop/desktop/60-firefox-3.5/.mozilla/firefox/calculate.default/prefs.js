#размер дисковой квоты под кэш (в Кб)
user_pref("browser.cache.disk.capacity", 5000);
#сохранять файлы без запроса на выбор пути
user_pref("browser.download.useDownloadDir", false);
#отключить проверку браузера по умолчанию
user_pref("browser.shell.checkDefaultBrowser", false);
#домашняя страница
user_pref("browser.startup.homepage", "http://www.calculate-linux.org");
#?os_locale_language==ru#
user_pref("browser.startup.homepage", "http://www.calculate-linux.ru");
#os_locale_language#
#версия последнего браузера, открывшего текущий профиль (нужно чтобы не отправлял на сайт firefox)
user_pref("browser.startup.homepage_override.mstone", "rv:1.9.2");
#скрывать панель вкладок когда открыта только одна страница
user_pref("browser.tabs.autoHide", false);
#отключить вопрос при закрытии браузерв
user_pref("browser.tabs.warnOnClose", false);
#переместить иконку adblock из toolbar в statusbar
#?pkg(www-plugins/adblock-mozilla-plugin)!=#
user_pref("extensions.adblockplus.showinstatusbar", true);
user_pref("extensions.adblockplus.showintoolbar", false);
#pkg#
#активировать тему kde oxygen
#?pkg(www-plugins/oxygen-mozilla-plugin)!=#
user_pref("general.skins.selectedSkin", "oxygen");
user_pref("ui.allow_platform_file_picker", false);
#pkg#
#не показывать окно закачек при добавлении закачек
user_pref("browser.download.manager.showAlertOnComplete", false);
user_pref("browser.download.manager.showWhenStarting", false);
#установить google как поисковик по умолчанию
#?os_locale_language==ru#
user_pref("keyword.URL", "http://www.google.ru/search?q=");
#os_locale_language#
#?os_locale_language!=ru#
user_pref("keyword.URL", "http://www.google.com/search?q=");
#os_locale_language#

#?pkg(www-plugins/spell-mozilla-plugin)!=#
# не определять автоматически словарь
user_pref("spellchecker.autoChangeDictionary", false);
# не определять словарь по набору
user_pref("spellchecker.detectDictionaryAsIType", false);
#pkg#

# установка словаря по локали
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==de#
user_pref("spellchecker.dictionary", "de-DE");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==en#
user_pref("spellchecker.dictionary", "en-US");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==es#
user_pref("spellchecker.dictionary", "es-ES");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==fr#
user_pref("spellchecker.dictionary", "fr-reforme1990");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==it#
user_pref("spellchecker.dictionary", "it-IT");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==pl#
user_pref("spellchecker.dictionary", "pl");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==pt_BR#
user_pref("spellchecker.dictionary", "pt-BR");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==pt#
user_pref("spellchecker.dictionary", "pt");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==ru#
user_pref("spellchecker.dictionary", "ru");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==ro#
user_pref("spellchecker.dictionary", "ro");
#pkg#
#?pkg(www-plugins/spell-mozilla-plugin)!=&&os_locale_language==uk#
user_pref("spellchecker.dictionary", "uk-UA");
#pkg#
