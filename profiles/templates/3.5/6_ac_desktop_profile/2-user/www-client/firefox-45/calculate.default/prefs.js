#?os_locale_language!=ru#
user_pref("browser.startup.homepage", "http://start.calculate-linux.org");
#!os_locale_language#
user_pref("browser.startup.homepage", "http://start.calculate-linux.ru");
user_pref("browser.fixup.alternate.suffix", ".ru");
#os_locale_language#
#?hr_cpu_num>1#
user_pref("browser.tabs.remote.autostart", true);
user_pref("dom.ipc.processCount", #-hr_cpu_num-#);
#hr_cpu_num#
#?env(client.os_remote_auth)!=&&ur_domain_set==on#
user_pref("browser.cache.disk.capacity", 51200);
user_pref("browser.cache.use_new_backend", 1);
user_pref("browser.download.dir", "#-ini(resource.downloads)-#");
user_pref("browser.download.folderList", 2);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.sessionhistory.max_total_viewers", 3);
user_pref("browser.sessionstore.interval", 60000);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.tabs.animate", false);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("dom.enable_performance", false);
user_pref("dom.ipc.plugins.asyncdrawing.enabled", true);
user_pref("dom.ipc.plugins.asyncInit.enabled", true);
user_pref("extensions.pocket.enabled", false);
user_pref("font.name.monospace.x-cyrillic", "Droid Sans Mono Slashed");
user_pref("font.name.sans-serif.x-cyrillic", "Droid Sans");
user_pref("font.name.serif.x-cyrillic", "Times New Roman");
user_pref("javascript.options.asyncstack", true);
user_pref("memory.free_dirty_pages", true);
user_pref("network.http.pipelining.max-optimistic-requests", 8);
user_pref("network.http.pipelining.ssl", true);
user_pref("network.http.pipelining", true);
user_pref("network.http.proxy.pipelining", true);
user_pref("privacy.trackingprotection.enabled", true);
