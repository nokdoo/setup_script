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

install_i3();

# slim is deprecated by problem with login_conf and unmanaged display manager
# install_slim();

# install bash 
system("pkg install -y bash");

# set locale
system("cp .login_conf $userhome/");

install_nanum();

# install xfce4-terminal for hangul. xterm and uxterm do not support hangul
system("pkg install -y xfce4-terminal");

# install uim and uim manager
system("pkg install -y uim uim-gtk3");

install_vim();

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
    system("pw usermod $user -G sudo");
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
    system("mkdir -p $userhome/.config/i3 && cp config $userhome/.config/i3/");
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


# install nanum font
sub install_nanum {
    system("pkg install -y ko-nanumfonts-ttf"); 
    system("fc-cache");
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

    # aliasing
    system "echo \"alias vi='vim'\" >> $userhome/.profile";
}

sub combine_path {
    return join '/', @_;
}
