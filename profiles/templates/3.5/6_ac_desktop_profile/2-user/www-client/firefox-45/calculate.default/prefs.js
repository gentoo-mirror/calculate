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
user_pref("dom.push.connection.enabled", false);
user_pref("dom.push.enabled", false);
user_pref("dom.push.serverURL", "");
user_pref("dom.serviceWorkers.enabled", false);
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.webnotifications.serviceworker.enabled", false);
#!env#
user_pref("network.proxy.type", 0);
#env#

user_pref("beacon.enabled", false);
user_pref("browser.cache.disk.capacity", 51200);
user_pref("browser.cache.use_new_backend", 1);
user_pref("browser.download.dir", "#-ini(resource.downloads)-#");
user_pref("browser.download.folderList", 2);
user_pref("browser.eme.ui.enabled", false);
user_pref("browser.reader.detectedFirstArticle", true);
user_pref("browser.search.defaultenginename", "Google");
user_pref("browser.search.geoip.url", "");
user_pref("browser.search.order.1", "Google");
user_pref("browser.search.order.2", "");
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.selfsupport.url", "");
user_pref("browser.sessionhistory.max_total_viewers", 3);
user_pref("browser.sessionstore.interval", 60000);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.tabs.animate", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.tabs.remote.autostart", true);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("camera.control.face_detection.enabled", false);
user_pref("datareporting.healthreport.about.reportUrl", "");
user_pref("datareporting.healthreport.infoURL", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("dom.battery.enabled", false);
user_pref("dom.disable_beforeunload", true);
user_pref("dom.disable_window_move_resize", true);
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true);
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
user_pref("dom.enable_performance", false);
user_pref("dom.ipc.plugins.asyncdrawing.enabled", true);
user_pref("dom.ipc.plugins.asyncInit.enabled", true);
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.pocket.api", "");
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.oAuthConsumerKey", "");
user_pref("extensions.pocket.site", "");
user_pref("font.name.monospace.x-cyrillic", "Droid Sans Mono Slashed");
user_pref("font.name.sans-serif.x-cyrillic", "Droid Sans");
user_pref("font.name.serif.x-cyrillic", "Times New Roman");
user_pref("general.warnonaboutconfig", false);
user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("javascript.options.asyncstack", true);
user_pref("media.eme.apiVisible", false)
user_pref("media.getusermedia.screensharing.allowed_domains", "");
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.navigator.enabled", false);
user_pref("media.video_stats.enabled", false);
user_pref("memory.free_dirty_pages", true);
user_pref("memory.free_dirty_pages", true);
user_pref("network.allow-experiments", false);
user_pref("network.http.pipelining.aggressive", true);
user_pref("network.http.pipelining.max-optimistic-requests", 8);
user_pref("network.http.pipelining.ssl", true);
user_pref("network.http.pipelining", true);
user_pref("network.http.proxy.pipelining", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.introCount", 20);
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("social.directories", "");
user_pref("social.remote-install.enabled", false);
user_pref("social.share.activationPanelEnabled", false);
user_pref("social.shareDirectory", "");
user_pref("social.toast-notifications.enabled", false);
user_pref("social.whitelist", "");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.infoURL", "");
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.unified", false);
