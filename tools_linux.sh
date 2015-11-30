sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
sudo wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install mercurial tar vim vim-gnome wget zlib1g-dev
sudo apt-get -y install postgresql-client-9.2 pgadmin3

# This is needed by Mercurial when installing Go and the Go libs
echo "[trusted]
users = *
groups = *
" > ~/.hgrc
