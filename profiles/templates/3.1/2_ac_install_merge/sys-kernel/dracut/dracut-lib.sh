# Calculate dotall format=patch path=/usr/lib/dracut/modules.d/99base
<reg>(\nwait_for_dev.*?_name.*?str_replace.*)'\\x2f'</reg>
<text>\1'\\\\x2f'</text>
