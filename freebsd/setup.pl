#!/usr/env/bin perl

use strict;
use warnings;

my $user = "nokdoot";
my $userhome = "/usr/home/$user";
my $read;
my $write;
my @content;

# update/upgrade pkg
update_pkg();

# change the url of pkg repository 
change_repo();

# turn off beep sound
system("echo 'allscreens_kbdflags=\"-b quiet.off\"' >> /etc/rc.conf");

# install sudo and add $user to sudo
install_sudo();

install_xorg();

install_xdm();

install_i3();

# slim is deprecated by problem with login_conf and unmanaged display manager
# install_slim();

# install bash 
system("pkg install -y bash");

# set locale
system("cp .login_conf $userhome/");
system "chown $user:$user $userhome/.login_conf";

install_nanum();

install_xfce4_terminal();

# install uim and uim manager
system("pkg install -y uim uim-gtk3");

install_vim();

system "echo 'autoboot_delay=\"2\"' >> /boot/loader.conf";

install_fn_key();

install_redshift();

install_audacious();

install_firefox();

install_caja();

install_okular();

set_fdescfs();

install_openjdk11();

conf_linux_bin_compatibility();

# removing vesa error on /var/log/messsages by this
system "echo kern.vty=sc >> /boot/loader.conf";




print "		open uim-pref-gtk3\n";
print "		'chsh -s bash $user'\n";
print "		reboot!!!!\n";




# update/upgrade pkg
sub update_pkg {
    system("pkg update -f");
    system("pkg upgrade -f");
}

# change the url of pkg repository 
sub change_repo {
    open ( $read, '<', '/etc/pkg/FreeBSD.conf') or die;
    for my $line ( <$read> ) {
        $line =~ s/pkg\.FreeBSD\.org/pkg0\.twn\.FreeBSD\.org/;
        push @content, $line;
    }
    close $read;

    open ( $write, '>', '/etc/pkg/FreeBSD.conf') or die;
    for ( @content ) {
        print $write $_;
    } 
    close $write;
    undef @content;
}

# install sudo and add $user to sudo
sub install_sudo {
    system("pkg install -y sudo");
    system("pw groupadd sudo");
    system("echo '%sudo ALL=(ALL:ALL) ALL' >> /usr/local/etc/sudoers");
    system "pw groupmod sudo -m $user";
}

# install xorg
sub install_xorg {
    system("pkg install -y xorg");
    system("echo 'hald_enable=\"YES\"' >> /etc/rc.conf");
    system("echo 'dbus_enable=\"YES\"' >> /etc/rc.conf");
}

# install i3
sub install_i3 {
    system("pkg install -y i3 i3lock i3status dmenu");
    system("echo 'exec /usr/local/bin/i3' >> $userhome/.xinitrc");
    system "chown $user:$user $userhome/.xinitrc";
    system("sudo -u $user mkdir -p $userhome/.config/i3");
    system "cp config $userhome/.config/i3/";
    system "chown $user:$user $userhome/.config/i3/config";
    system("cp i3-new-workspace /usr/local/bin/");
}

# install slim(is deprecated by problem with login_conf and unmanaged display manager)
sub install_slim {
    system("pkg install -y x11/slim");

    # convert display manager from xdm to slim
    open ( $read, '<', '/etc/ttys') or die;
    for my $line ( <$read> ) {
        if ( $line =~ /^ttyv8/ ) {
            $line =~ s/xdm/slim/;
            $line =~ s/off/on/;
        }	
        push @content, $line;
    }
    close $read;

    open ( $write, '>', '/etc/ttys') or die;
    for ( @content ) {
        print $write $_;
    }
    close $write;

    undef @content;
}

sub install_xdm {
    system("pkg install -y x11/xdm");

    open ( $read, '<', '/etc/ttys') or die;
    for my $line ( <$read> ) {
        if ( $line =~ /^ttyv8/ ) {
            $line =~ s/off/on/;
        }	
        push @content, $line;
    }
    close $read;

    open ( $write, '>', '/etc/ttys') or die;
    for ( @content ) {
        print $write $_;
    }
    close $write;
    undef @content;

    open ( $read, '<', '/usr/local/etc/X11/xdm/xdm-config') or die;
    for my $line ( <$read> ) {
        $line =~ s/^/!/ if $line =~ '/usr/local/etc/X11/xdm/Xsetup_0';
        $line =~ s/^/!/ if $line =~ '/usr/local/etc/X11/xdm/GiveConsole';
        $line =~ s/^/!/ if $line =~ '/usr/local/etc/X11/xdm/TakeConsole';
        push @content, $line;
    }
    close $read;

    open ( $write, '>', '/usr/local/etc/X11/xdm/xdm-config') or die;
    for ( @content ) {
        print $write $_;
    }
    close $write;
    undef @content;

    # copy .xsession to home
    system("cp .xsession $userhome/");
    system "chown $user:$user $userhome/.xsession";
    # for root
    system("cp .xsession /root/");

    system "pkg install -y xsm";
}


# install nanum font
sub install_nanum {
    system("pkg install -y ko-nanumfonts-ttf"); 
    system("fc-cache");
}

# install xfce4-terminal for hangul. xterm and uxterm do not support hangul
sub install_xfce4_terminal {
    system("pkg install -y xfce4-terminal");
    system("sudo -u $user mkdir -p $userhome/.config/xfce4/terminal");
    system "cp terminalrc $userhome/.config/xfce4/terminal/";
    system "chown $user:$user $userhome/.config/xfce4/terminal/terminalrc";
}

# install vim
sub install_vim {
    system("git clone https://github.com/vim/vim.git");
    chdir "vim";
    system("make");
    system("make install");
    system("make install clean");
    chdir "../";
    system("rm -r vim");
    system("pkg install -y xclip");

    # .vimrc
    system("cp .vimrc $userhome/");
    system "chown $user:$user $userhome/.vimrc";
    # for root
    system("cp .vimrc /root/");

    # aliasing
    system "echo 'alias vi=\"vim\"' >> $userhome/.profile";
    # for root
    system "echo 'alias vi=\"vim\"' >> /root/.profile";
}

# install fn_key controller
sub install_fn_key {
    # fn_audio
    system "pkg install -y pulseaudio";
    # fn_bright
    system "pkg install -y xbacklight";
}

sub install_redshift {
    system "pkg install -y redshift";
}

# music player
sub install_audacious {
    system "pkg install -y audacious";
    system "pkg install -y audacious-plugins";
    system "pkg install -y audacious-skins";
}

sub install_firefox {
    system "pkg install -y firefox";
}

# file manager
sub install_caja {
    system "pkg install -y caja";
    system "pkg install -y caja-extensions";

    # extractor
    system "pkg install -y file-roller";
    system "pkg install -y xarchiver";
}

# pdf viewer
sub install_okular {
    system "pkg install -y okular";
}

sub set_fdescfs {
    system "mount -t fdescfs fdesc /dev/fd";
    system "mount -t procfs proc /proc";

    system "echo 'fdesc	/dev/fd		fdescfs		rw	0	0' >> /etc/fstab";
    system "echo 'proc	/proc		procfs		rw	0	0' >> /etc/fstab";
}

sub install_openjdk11 {
    system "pkg install -y openjdk11";
    system "echo 'export JAVA_HOME=/usr/local/openjdk11' >> $userhome/.profile";
    system "echo 'export PATH=\$JAVA_HOME/bin:\$PATH' >> $userhome/.profile";
    system "source $userhome/.profile";
}

sub conf_linux_bin_compatibility {
    system "kldload linux64";
    system "pkg install -y linux_base-c6";
    system "echo 'linux_enable=\"YES\"' >> /etc/rc.conf";
    system "echo 'linux64_enable=\"YES\"' >> /etc/rc.conf";
    system "echo 'linprocfs   /compat/linux/proc	linprocfs	rw	0	0' >> /etc/fstab";
    system "mount /compat/linux/proc";
    system "echo 'linsysfs    /compat/linux/sys	linsysfs	rw	0	0' >> /etc/fstab";
    system "mount /compat/linux/sys";
    system "echo 'tmpfs    /compat/linux/dev/shm	tmpfs	rw,mode=1777	0	0' >> /etc/fstab";
    system "mount /compat/linux/dev/shm";
}
