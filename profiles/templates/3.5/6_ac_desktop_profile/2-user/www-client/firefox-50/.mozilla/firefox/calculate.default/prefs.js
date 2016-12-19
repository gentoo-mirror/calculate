#?os_locale_language!=ru#
user_pref("browser.startup.homepage", "http://start.calculate-linux.org");
#!os_locale_language#
user_pref("browser.startup.homepage", "http://start.calculate-linux.ru");
user_pref("browser.fixup.alternate.suffix", ".ru");
#os_locale_language#
user_pref("font.name.monospace.x-cyrillic", "Droid Sans Mono Slashed");
user_pref("font.name.sans-serif.x-cyrillic", "Droid Sans");
user_pref("font.name.serif.x-cyrillic", "Times New Roman");
# close a window with multiple tabs
user_pref("browser.tabs.warnOnClose", false);
# skip setting the first start
user_pref("browser.startup.homepage_override.mstone", "ignore");
# включение новой системы HTTP кэширования, улучшает отзывчивость интерфейса
user_pref("browser.cache.use_new_backend", 1);
# интервал автосохранения сессии в миллисекундах
user_pref("browser.sessionstore.interval", 60000);
user_pref("browser.tabs.animate", false);
# максимальное кол-во запросов в соединении
user_pref("network.http.pipelining.max-optimistic-requests", 8);
# включает конвейерные запросы через SSL соединение (https)
user_pref("network.http.pipelining.ssl", true);
user_pref("network.http.pipelining", true);
# использовать несколько запросов в одном соединении с сервером при использовании прокси
user_pref("network.http.proxy.pipelining", true);
# максимальное кол-во закэшированных страниц в каждой вкладке
user_pref("browser.sessionhistory.max_total_viewers", 3);
# асинхронная инициализация плагинов
user_pref("dom.ipc.plugins.asyncInit.enabled", true);
# асинхронный вызов стеков
user_pref("javascript.options.asyncstack", true);
user_pref("dom.ipc.plugins.asyncdrawing.enabled", true);
# высвобождает неиспользуемые страницы памяти после закрытия вкладок
user_pref("memory.free_dirty_pages", true);
#?hr_cpu_num>1#
# многопроцессорный режим
user_pref("browser.tabs.remote.autostart", true);
# кол-во используемых процессоров
user_pref("dom.ipc.processCount", #-hr_cpu_num-#);
#hr_cpu_num#
# использовать под кэш не более 50Мб
user_pref("browser.cache.disk.capacity", 51200);
