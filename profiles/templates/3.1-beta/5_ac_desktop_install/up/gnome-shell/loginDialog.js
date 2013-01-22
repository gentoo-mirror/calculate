# Calculate format=patch path=/usr/share/gnome-shell/js/gdm
<reg>(_onSessionOpened: function\(client, serviceName\)\s*\{
)(\s*)(this._greeterClient.call_start_session_when_ready\(serviceName, true\);)</reg>
<text>\1\2this.close();
\2if(!this.readyId) {
\2\2this.readyId = this._greeterClient.connect('ready',
\2\2\2Lang.bind(this, function() {
\2\2\2\2this.open();
\2\2\2}));
\2}
\2\3</text>
<reg>(_onSessionOpened: function\(client, serviceName\)\s*\{
)(\s*)(this._greeter.call_start_session_when_ready_sync\(serviceName, true, null\);)</reg>
<text>\1\2this.close();
\2\3</text>
