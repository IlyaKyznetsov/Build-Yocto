#for Shtrih
#LOADADDR=
#for Mikroelektronika
LOADADDR=0xb0008000
if [ $# -eq 2 ]; then
    ZIMAGE_PATH=$1
    UIMAGE_PATH=$2
elif [ $# -eq 3 ]; then
    ZIMAGE_PATH=$1
    UIMAGE_PATH=$2
    LOADADDR=$3
else
    echo "Need 2 or 3 args: [zImage uImage] paths or [zImage uImage LOADADDR] paths and uImage load address"
    exit 1
fi
mkimage -A arm -O linux -T kernel -C none -a ${LOADADDR} -e ${LOADADDR} -n "Linux kernel" -d ${ZIMAGE_PATH} ${UIMAGE_PATH}
