#!/bin/sh
# root 용 .profile 을 넣어야 하려나.
# root 는 csh 을 사용하고, .login 은 안읽고 .cshrc 만 읽나봄
# (터미널 킬 때 말고 로그인 순간에)
. $HOME/.profile
. $HOME/.xinitrc
