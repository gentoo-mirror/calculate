# Calculate format=patch path=/usr/lib/qt5/qml/SddmComponents
<reg>\n([ \t]+)(passwordCharacter[^\n]+\n)(\s+\})</reg>
<text>
\1\2
\1Timer {
\1\1interval: 200
\1\1running: true
\1\1onTriggered: txtMain.forceActiveFocus()
\1}
\3</text>
