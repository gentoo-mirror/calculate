# Calculate format=patch path=/usr/share/gnome-shell/js/gdm
<reg>(_onSessionOpened: function\(client, serviceName\)\s*\{
)(\s*)(this._greeterClient.call_start_session_when_ready\(serviceName, true\);)</reg>
<text>\1\2this.close();
\2\3</text>
