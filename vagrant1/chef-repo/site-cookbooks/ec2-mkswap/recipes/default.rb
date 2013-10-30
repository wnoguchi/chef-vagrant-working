#
# Cookbook Name:: ec2-mkswap
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "this is ec2 swap creation recipe."
log "Instance Type is: #{node[:ec2][:instance_type]}"

bash 'create swapfile' do

  code <<-EOC
    dd if=/dev/zero of=/swap.img bs=1M count=2048 && chmod 600 /swap.img
    mkswap /swap.img
  EOC
  only_if { not node[:ec2].nil? and node[:ec2][:instance_type] == 't1.micro' }
  creates "/swap.img"

end

# swapファイルの定義をfstabに書くやつ
# 何回走らせても1エントリだけ？
mount '/dev/null' do
  action :enable
  device '/swap.img'
  fstype 'swap'
  only_if { not node[:ec2].nil? and node[:ec2][:instance_type] == 't1.micro' }
end

bash 'activate swap' do
  code 'swapon -ae'
  # スワップ領域がひとつもなければスワップを有効にする
  only_if "test `cat /proc/swaps | wc -l` -eq 1"
end
