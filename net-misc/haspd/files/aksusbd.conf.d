# -l <level>    sets logging level: [0] errors only [1] normal [2] verbose  [3] ultra verbose
# -q <entries>  sets the length of the work queue (default: 64)
# -s <file>     sets the communication socket file name
# -u <mask>     sets the communication socket file access rights
# -d <millisec> sets the delay after plugging in a key until it is accessed for the first time (0 - 2000)

AKSUSBD_ARGS="-l 2 -u 0666"
