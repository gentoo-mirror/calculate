# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/etercifs/etercifs-999.ebuild,v 1.1 2008/11/29 20:39:49 vapier Exp $

# XXX: the tarball here is just the kernel modules split out of the binary
#      package that comes from virtualbox-bin

inherit eutils

DESCRIPTION="Kernel Modules for Etersoft CIFS"
HOMEPAGE="http://www.etersoft.ru/"
SRC_URI="http://updates.etersoft.ru/pub/Etersoft/CIFS@Etersoft/4.3.6/Gentoo/2009/etercifs-4.3.6-eter1gentoo.tbz2"
SRC_PN="kernel-source-etercifs"
SRC_LEGACY_VER="1.50c"
SRC_2_6_1623_VER="1.50"
SRC_2_6_2425_VER="1.52"
SRC_2_6_26_VER="1.53"
SRC_2_6_27_VER="1.54"
SRC_2_6_28_VER="1.55"
SRC_2_6_29_VER="1.57"
FILE_URI="/var/tmp/portage/net-fs/etercifs-4.3.6/work/usr/share/etercifs/sources"
FILE1_URI="$FALE_URI/${P}.tar.bz2 $FALE_URI/${SRC_PN}-legacy-${SRC_LEGACY_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2 $FALE_URI/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2"
FILE2_URI="/var/tmp/portage/net-fs/etercifs-4.3.6/work/usr/share/etercifs/"
FILE3_URI="/var/tmp/portage/net-fs/etercifs-4.3.6/work/etc/init.d"
FILE4_URI="/var/tmp/portage/net-fs/etercifs-4.3.6/work/"
FILE5_URI="/var/tmp/portage/net-fs/etercifs-4.3.6/work/usr/sbin"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE="kernel_linux"

DEPEND="kernel_linux? ( virtual/linux-sources )"


src_unpack() {
	unpack etercifs-4.3.6-eter1gentoo.tbz2
}

src_install() {

    mkdir -p ${D}/etc
    echo DATADIR=/usr/share/${PN} > ${D}/etc/${PN}.conf
    echo SRC_DIR=/usr/src/${P} >> ${D}/etc/${PN}.conf
    echo MODULENAME=${PN} >> ${D}/etc/${PN}.conf
    echo MODULEVERSION=${PV} >> ${D}/etc/${PN}.conf

    mkdir -p ${D}/usr/share/${PN}
    install -m755 ${FILE2_URI}buildmodule.sh ${D}/usr/share/${PN}
    install -m755 ${FILE2_URI}functions.sh ${D}/usr/share/${PN}

    mkdir -p ${D}/usr/sbin
    install -m755 ${FILE5_URI}/etermount ${D}/usr/sbin/etermount
    mkdir -p ${D}/etc/init.d
    mkdir -p ${D}/etc/conf.d
    install -m755 ${FILE3_URI}/etercifs ${D}/etc/init.d/etercifs
    install -m755 ${FILE3_URI}/etercifs.outformat ${D}/etc/init.d/etercifs.outformat
    install -m755 ${FILE3_URI}/etercifs ${D}/etc/conf.d/etercifs
    install -m755 ${FILE3_URI}/etercifs.outformat ${D}/etc/conf.d/etercifs.outformat


    ETERCIFS_SRC="usr/share/${PN}/sources"

    mkdir -p ${D}/${ETERCIFS_SRC}

    cp ${FILE_URI}/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.29-${SRC_2_6_29_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.29-${SRC_2_6_29_VER}.tar.bz2

}

pkg_preinst() {
	KERN_MOD="/lib/modules/$(uname -r)"
	find "${KERN_MOD}" -name cifs.ko | gawk '{print $1,$1".orig"}' | xargs mv
}


pkg_postinst() {

ln -s /lib/modules/`uname -r`/build/arch/x86 /lib/modules/`uname -r`/build/arch/amd64

ln -s /etc/init.d/etercifs /etc/runlevels/boot/etercifs

if [ -f /etc/etercifs.conf ] ; then
  . /etc/etercifs.conf
else
  fatal "Not found configuration file /etc/etercifs.conf"
fi

MODULEFILENAME=etercifs.ko
[ -n "$TESTBUILD" ] || TESTBUILD=0
[ -n "$DKMSBUILD" ] || DKMSBUILD=0

fatal()
{
    echo $@
    exit 1
}

exit_handler()
{
    local rc=$?
    trap - EXIT
    [ -z "$tmpdir" ] || rm -rf -- "$tmpdir"
    exit $rc
}

detect_etercifs_sources()
{
    [ -n "$ETERCIFS_SOURCES_LIST" ] || ETERCIFS_SOURCES_LIST=$DATADIR/sources/kernel-source-etercifs*
    [ -n "`ls $ETERCIFS_SOURCES_LIST`" ] || fatal "Etercifs kernel module sources does not installed!"
    KERNEL_SOURCE_ETERCIFS_LINK=`ls -1 $ETERCIFS_SOURCES_LIST | grep $KERNEL | sort -r | head -n 1`

    # CentOS-RHEL specific part
    SPECIFIC_CENTOS=0
    grep 'CentOS' /etc/redhat-release &>/dev/null && SPECIFIC_CENTOS=1
    grep 'Red Hat' /etc/redhat-release &>/dev/null && SPECIFIC_CENTOS=1
    if [ "$SPECIFIC_CENTOS" -eq 1 ] ; then
        echo
        echo "Found CentOS or RHEL."

        kernel_release4
        N1=`echo $KERNEL4 | cut -d"." -f 1`
        N2=`echo $KERNEL4 | cut -d"." -f 2`
        N3=`echo $KERNEL4 | cut -d"." -f 3 | cut -d"-" -f 1`
        N4=`echo $KERNEL4 | cut -d"-" -f 2 | cut -d"." -f 1`

        CENTOS=0
        if [ "$N1" -eq '2' ] && [ "$N2" -eq '6' ] ; then
            if [ "$N3" -eq 18 ] ; then
                if [ "$N4" -eq 128 ] ; then
                    echo "Your kernel is 2.6.18-128.x"
                    CENTOS=53
                elif [ "$N4" -gt 128 ] ; then
                    echo "Warning! Your kernel is newer, then 2.6.18-128.x"
                    CENTOS=53
                elif [ "$N4" -gt 92 ] && [ "$N4" -lt 128 ] ; then
                    echo "Warning! Your kernel is newer, then 2.6.18-92.x and older, then 2.6.18-128.x"
                    CENTOS=52
                elif [ "$N4" -lt 92 ] ; then
                    echo "Warning! Your kernel is older, then 2.6.18-92.x"
                    CENTOS=52
                else
                    echo "Your kernel is 2.6.18-92.x"
                    CENTOS=52
                fi
            elif [ "$N3" -gt 18 ] && [ "$N3" -lt 23 ] ; then
                echo "Warning! Your kernel is newer, then 2.6.18 and older, then 2.6.23"
                CENTOS=53
            else
                echo "Warning! Your kernel is older, then 2.6.18 or newer, then 2.6.22"
            fi
        else
            echo "Warning! Your kernel in not 2.6.x"
        fi
        if [ "$CENTOS" -eq 53 ] ; then
            echo "Building from sources, adapted for kernels 2.6.18-128.x from CentOS 5.3."
            KERNEL_SOURCE_ETERCIFS_LINK=`ls -1 $ETERCIFS_SOURCES_LIST | grep 'centos53' | sort -r | head -n 1`
        elif [ "$CENTOS" -eq 52 ] ; then
            echo "Building from legacy sources with patch for kernels 2.6.18-92.x from CentOS 5.2."
            KERNEL_SOURCE_ETERCIFS_LINK=`ls -1 $ETERCIFS_SOURCES_LIST | grep 'centos52' | sort -r | head -n 1`
        else
            echo "Building from legacy sources."
        fi
        echo
    fi
    # end of CentOS-RHEL specific part

    [ -f "$KERNEL_SOURCE_ETERCIFS_LINK" ] || fatal "Etercifs kernel module sources for current kernel does not installed!"
    KERNEL_SOURCE_ETERCIFS=`readlink -f $KERNEL_SOURCE_ETERCIFS_LINK`
    [ "$KERNEL_SOURCE_ETERCIFS" ] || fatal "Etercifs kernel module sources for current kernel does not installed!"
}

create_builddir()
{
    if [ -n "$BUILDDIR" ] ; then
        tmpdir=$BUILDDIR
    else
        tmpdir=
        tmpdir="$(mktemp -dt "Etercifs.XXXXXXXX")"
    fi
    tar -xjf $KERNEL_SOURCE_ETERCIFS -C $tmpdir
    trap exit_handler HUP PIPE INT QUIT TERM EXIT
    FILENAME=`basename $KERNEL_SOURCE_ETERCIFS`
    BUILDDIR=$tmpdir/${FILENAME%.tar.bz2}
}

kernel_release()
{
    # 2.6.27
    KERNEL=`echo $KERNELVERSION | sed 's/\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/'`
}

kernel_release4()
{
    # 2.6.18-128 or 2.6.29.1
    KERNEL4=`echo $KERNELVERSION | sed 's/\([0-9]\+\.[0-9]\+\.[0-9]\+[\.-][0-9]\+\).*/\1/'`
}

# Heuristic
detect_kernel()
{
    # Detect kernel version
    if [ -f $KERNSRC/.kernelrelease ] ; then
        KERNELVERSION=`head -n 1 $KERNSRC/.kernelrelease`
    elif [ -f $KERNSRC/include/config/kernel.release ] ; then
        KERNELVERSION=`head -n 1 $KERNSRC/include/config/kernel.release`
    elif [ -f $KERNSRC/include/linux/version.h ] ; then
        KERNELVERSION=`head -n 1 $KERNSRC/include/linux/version.h | grep UTS_RELEASE | cut -d" " -f 3 | sed -e 's|"||g'`
    fi
    if [ -z "$KERNELVERSION" ] ; then
        head -n 5 $KERNSRC/Makefile | sed -e "s| ||g" >get_version
        . ./get_version
        KERNELVERSION=$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION
        # Hack for strange SUSE 10.2
        if [ -z "$EXTRAVERSION" ] ; then
            KERNELVERSION=`grep KERNELSRC $KERNSRC/Makefile | head -n 1 | sed -e "s|.*linux-||g"`
            [ -n "$KERNELVERSION" ] && KERNELVERSION=$KERNELVERSION-`basename $KERNSRC`
        fi
    fi
    kernel_release
}

detect_host_kernel()
{
    [ -n "$KERNELVERSION" ] || KERNELVERSION=`uname -r`
    kernel_release

    if [ -z "$KERNSRC" ]; then
        KERNSRC=/lib/modules/$KERNELVERSION/build
    fi
}

check_headers()
{
    if [ ! -f $KERNSRC/include/linux/version.h ]; then
        cat >&2 <<EOF
Error: no kernel headers found at $KERNSRC
Please install package
    kernel-headers-modules-XXXX for ALT Linux
    kernel-XXXX-devel for FCx / ASP Linux
    dkms-etercifs for Mandriva 2009
    linux-headers-XXXX for Debian / Ubuntu
    kernel-source-XXXX for SuSe
    kernel-source-XXXX for Slackware / MOPSLinux
or use KERNSRC variable to set correct location
Exiting...
EOF
        exit 1
    fi
}

set_gcc()
{
    if [ -f $KERNSRC/gcc_version.inc ] ; then
        . $KERNSRC/gcc_version.inc
        if [ $TESTBUILD -ne 1 ] ; then
            echo "Use GCC $GCC_VERSION"
        fi
        export GCCNAME=gcc-$GCC_VERSION
        export USEGCC="CC=$GCCNAME"
    else
        export GCCNAME=gcc
    fi

    [ `which make` ] || fatal "GNU make utility have not found. Please install make package."

    PATHGCC=`which $GCCNAME`
    [ $PATHGCC ] || fatal "GCC compiler have not found. Please install gcc package."
    echo $PATHGCC
}

dkms_build_module()
{
    detect_etercifs_sources
    STATUS=`dkms status -m $MODULENAME -v $MODULEVERSION`
    [ "$STATUS" ] || dkms add -m $MODULENAME -v $MODULEVERSION
    tar -xjf $KERNEL_SOURCE_ETERCIFS -C $SRC_DIR
    FILENAME=`basename $KERNEL_SOURCE_ETERCIFS`
    DIRNAME=${FILENAME%.tar.bz2}
    mv -f $SRC_DIR/$DIRNAME/* $SRC_DIR
    BUILDDIR=$SRC_DIR
    change_cifsversion
    rm -rf $SRC_DIR/$DIRNAME
    dkms uninstall -m $MODULENAME -v $MODULEVERSION --rpm_safe_upgrade
    dkms build -m $MODULENAME -v $MODULEVERSION --rpm_safe_upgrade
    dkms install -m $MODULENAME -v $MODULEVERSION --rpm_safe_upgrade
}

change_cifsversion()
{
    if [ -f $BUILDDIR/cifsfs.h ] ; then
        CIFSVERSION=`cat $BUILDDIR/cifsfs.h | grep CIFS_VERSION`
        CIFSVERSION=`echo $CIFSVERSION | sed 's|#define CIFS_VERSION||g'`
        CIFSVERSION=`echo $CIFSVERSION | sed 's|"||g'`
        CIFSVERSION=`echo $CIFSVERSION | sed 's| ||g'`
        sed -i "s/$CIFSVERSION/$MODULEVERSION/g" $BUILDDIR/cifsfs.h
        echo "Setting etercifs version: OK"
    else
        echo "Setting etercifs version: FAIL"
    fi
}

compile_module()
{
    detect_etercifs_sources
    create_builddir
    check_headers
    set_gcc

    # SMP build
    [ -z "$RPM_BUILD_NCPUS" ] && RPM_BUILD_NCPUS=`/usr/bin/getconf _NPROCESSORS_ONLN`
    [ "$RPM_BUILD_NCPUS" -gt 1 ] && MAKESMP="-j$RPM_BUILD_NCPUS" || MAKESMP=""

    echo "Checking the kernel configuration..."
    if [ -r "$KERNSRC" ]; then
        CONF_STRING=`cat $KERNSRC/.config | grep CONFIG_CIFS=`
        CONF_LETTER=`echo $CONF_STRING | cut -b 13-13`
        case "$CONF_LETTER" in
            "m")
                echo "OK"
                ;;
            "y")
                echo "WARNING: the kernel is configured with cifs supporting, but not as a module!"
                ;;
            *)
                echo "WARNING: the kernel is configured without cifs supporting!"
        esac
    else
        echo "WARNING: the .config file in kernel source directory does not exist!"
    fi

    change_cifsversion
    make $USEGCC -C $KERNSRC here=$BUILDDIR SUBDIRS=$BUILDDIR clean
    make $USEGCC -C $KERNSRC here=$BUILDDIR SUBDIRS=$BUILDDIR modules $MAKESMP
}

install_module()
{
    if [ -z "$INSTALL_MOD_PATH" ]; then
        INSTALL_MOD_PATH=/lib/modules/$KERNELVERSION/kernel/fs/cifs
    fi
    test -r "$BUILDDIR/$MODULEFILENAME" || { echo "can't locate built module $MODULEFILENAME" ; exit 1 ; }
    strip --strip-debug --discard-all $BUILDDIR/$MODULEFILENAME
    echo "Copying built module to $INSTALL_MOD_PATH"

    mkdir -p $INSTALL_MOD_PATH
    install -m 644 -o root -g root $BUILDDIR/$MODULEFILENAME $INSTALL_MOD_PATH/ || exit 1
    depmod -ae || exit 1
}

check_build_module()
{
    if [ -r "$BUILDDIR/$MODULEFILENAME" ] ; then
        echo "$KERNELVERSION - OK"
        BUILTLIST="$BUILTLIST---DONE"
    else
        echo "can't locate built module $MODULEFILENAME"
        echo "$KERNELVERSION - FAIL"
    fi
}

if [ $TESTBUILD -ne 1 ] ; then
    if [ $DKMSBUILD -eq 1 ] ; then
        detect_host_kernel
        echo
        echo "Building for $KERNELVERSION Linux kernel with dkms"
        dkms_build_module
    else
        detect_host_kernel
        echo
        echo "Building for $KERNELVERSION Linux kernel (headers in $KERNSRC)"
        compile_module
        install_module
    fi
else
    echo
    echo "====================================================================="
    echo "Check build etercifs module for all founded kernels"
    BUILTLIST=
    for LM in `ls /lib/modules` ; do
        KERNSRC=`readlink /lib/modules/$LM/build`
        if [ $KERNSRC ] ; then
            [ -L $KERNSRC ] && continue
            [ -f $KERNSRC/.config ] || continue
            echo "---------------------------------------------------------------------"
            detect_kernel
            if [ -z "$KERNELVERSION" ] ; then
                echo "Can't detect kernel version in $KERNSRC"
            else
                echo "Build for $KERNSRC (detected as $KERNELVERSION)"
                BUILTLIST="$BUILTLIST $KERNELVERSION"
                compile_module
                check_build_module
            fi
        fi
    done
    echo "====================================================================="
    echo "CIFS Linux kernel module built for follow kernels (marked as ---DONE):"
    echo "---------------------------------------------------------------------"
    for i in $BUILTLIST ; do echo "    $i" ; done
    echo "====================================================================="
fi


}
