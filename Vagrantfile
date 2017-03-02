# frozen_string_literal: true
# -*- mode: ruby -*-
# vi: set ft=ruby :

SCRIPT = <<_EOF_
  # Dependencies / Utiles
  echo "Updating package definitions ..."
  sudo apt-get -y update

  echo "Installing git and build tools ..."
  sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev \
  libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
  libcurl4-openssl-dev python-software-properties libffi-dev > /dev/null 2>&1

  # Rbenv
  if [ ! -d ~/.rbenv ]; then
    echo "Installing rbenv and ruby-build ..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  else
    echo "Updating rbenv and ruby-build ..."
    cd ~/.rbenv && git pull
    cd ~/.rbenv/plugins/ruby-build && git pull
  fi

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # Ruby
  if [ ! -d "$HOME/.rbenv/versions/$(cat /vagrant/.ruby-version)" ]; then
    echo "Installing ruby ..."
    rbenv install $(cat /vagrant/.ruby-version)
    rbenv global $(cat /vagrant/.ruby-version)

    gem update --system && gem update && gem install bundler --no-rdoc --no-ri
    rbenv rehash
  fi

  # Postgres
  echo "Installing postgresql ..."
  sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
  wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install -y postgresql-common libpq-dev postgresql-9.5 > /dev/null 2>&1

  if sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='vagrant'" | grep -q 0; then
    sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
    sudo -u postgres psql -c "ALTER USER vagrant CREATEDB;"
  fi

  # PhantomJS
  echo "Installing PhantomJS ..."
  PHANTOMJS="phantomjs-2.1.1-linux-x86_64"
  cd && wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS.tar.bz2
  sudo tar xvjf $PHANTOMJS.tar.bz2
  sudo mv $PHANTOMJS /usr/local/share
  sudo ln -sf /usr/local/share/$PHANTOMJS/bin/phantomjs /usr/local/bin

  # Redis
  # echo "Installing Redis ..."
  # cd && wget http://download.redis.io/redis-stable.tar.gz
  # tar xvzf redis-stable.tar.gz
  # cd redis-stable && make
  # sudo make install
  # cd .. && rm -rf redis-stable

  # Rails
  # cd /vagrant && gem install rails -v 5.0.1 && rbenv rehash

  # Gems
  # cd /vagrant && bundle install

  echo "DONE"
_EOF_

Vagrant.configure(2) do |config|
  config.vm.box      = 'ubuntu/xenial64'
  config.vm.hostname = 'dev'

  config.vm.network 'private_network', ip: '172.168.35.10'

  config.vm.provider :virtualbox do |vb|
    vb.memory = '2048'
  end

  config.vm.provision :shell, privileged: false, inline: SCRIPT
end
