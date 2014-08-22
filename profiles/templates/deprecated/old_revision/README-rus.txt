# Calculate append=skip

Устаревшие обновления world файла состава пакетов дистрибутивов и ревизии.

Начиная с версии CL14, world файл формируется из calculate-overlay для базовых
пакетов и в distros-overlay для пакетов дистрибутивов. Ревизии так же разделены
на базовые ревизии для всех дистрибутивов, включая производные и ревизии
дистрибутивов.

Настройки /etc/calculate/ini.env, было:

[update]
rev = ..
world = ..

будет:

[update]
revision = ..
world = ..

[update-distros]
revision = ..
world = ..
