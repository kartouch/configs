#!/bin/sh
dnf update -y
unalias cp
echo "Installing git"
dnf install git -y && 
echo "Cloning configs from repo into /root" &&
cd /root && git clone https://github.com/kartouch/configs.git

echo "Installing vim"
dnf install vim-enhanced vim-filesystem -y &&
echo "copy vim configs from repo" &&  
cp -Rf /root/configs/.vim /root/configs/.vimrc /home/kartouch
chown -R kartouch.kartouch /home/kartouch

echo "Installing zsh"
dnf install zsh -y && 
chsh -s /bin/zsh kartouch

echo "Install Oh My Zsh"
su -c 'sh -c "cd /home/kartouch; git clone https://github.com/robbyrussell/oh-my-zsh.git"' kartouch

echo "Copy zsh and oh my zsh config files"
cp -Rf /root/configs/.zshrc /home/kartouch/
mv /home/kartouch/oh-my-zsh /home/kartouch/.oh-my-zsh
chown -R kartouch.kartouch /home/kartouch

echo "Installing i3wm"
dnf install i3 i3status feh -y &&
echo "copy configs from repo" &&
cp -Rf /root/configs/.i3 /home/kartouch
cp -Rf /root/configs/i3status.conf /etc/
cp -Rf /root/configs/Skull-Linux.jpg /home/kartouch/Pictures
chown -R kartouch.kartouch /home/kartouch

echo "Installing Terminator"
dnf install -y powerline tmux-powerline powerline-docs vim-plugin-powerline terminator
su -c 'sh -c "cd /home/kartouch; git clone https://github.com/powerline/fonts.git"' kartouch
su -c 'sh -c "cd /home/kartouch/fonts; ./install.sh"' kartouch
cp -Rf /root/configs/.config/terminator /home/kartouch/.config
chown -R kartouch.kartouch /home/kartouch

echo "Installing Google Chrome"
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
dnf install google-chrome-stable -y

echo "Installing FlashPlayer"
rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
dnf install flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl -y
echo "Installing RPM Fusion"
rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-22.noarch.rpm

echo "Installing RVM"
su -c 'sh -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"' kartouch
su -c 'sh -c "gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"' kartouch
su -c 'sh -c "curl -sSL https://get.rvm.io | bash -s stable"' kartouch

