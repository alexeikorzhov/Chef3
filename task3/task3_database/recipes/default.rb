#
# Cookbook:: task3_database
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

bash "Install mysql" do
  code <<-SHELL
  cd /opt/
  wget  https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
  rpm -Uvh mysql57-community-release-el7-8.noarch.rpm
  rm -rf mysql57-community-release-el7-8.noarch.rpm
  SHELL
end

#execute 'mysql-community-repo' do
#command 'yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm -y'
#action :run
#end

mysql_service 'default' do
version '5.7'
bind_address '0.0.0.0'
port '3306'
initial_root_password '12345678'
action [:create, :start]
end

bash 'create database' do  
  code <<-SHELL  
  mysql -S /var/run/mysql-default/mysqld.sock -uroot -p12345678 -e "create database task3 character set utf8 collate utf8_bin;"  
  SHELL
end
