#
# Cookbook Name:: workflow_infra_base
# Recipe:: default
#
# Copyright 2016 Matt Stratton
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'push-jobs'

if node['workflow_infra_base']['enable_inspec'] = true
  inspec_data = data_bag_item('delivery-secrets', "#{node['workflow_infra_base']['automate_enterprise']}-#{node['workflow_infra_base']['automate_org']}")

  case node['os']
  when 'linux'
    user inspec_data['inspec']['ssh-user'] do
      manage_home true
      home "/home/#{inspec_data['inspec']['ssh-user']}"
    end
    directory "/home/#{inspec_data['inspec']['ssh-user']}/.ssh" do
      owner inspec_data['inspec']['ssh-user']
      group inspec_data['inspec']['ssh-user']
      mode '0700'
    end
    # Add the authorized key - note: if you add keys by hand, they will be over-written.
    # This user should ONLY be used for inspec testing.
    file "/home/#{inspec_data['inspec']['ssh-user']}/.ssh/authorized_keys" do
      owner inspec_data['inspec']['ssh-user']
      group inspec_data['inspec']['ssh-user']
      mode '0644'
      content inspec_data['inspec']['ssh-public-key']
    end
    sudo 'inspec-user' do
      user "%#{inspec_data['inspec']['ssh-user']}"
      nopasswd true
    end
  when 'windows'
    user inspec_data['inspec']['winrm-user'] do
      password inspec_data['inspec']['winrm-password']
    end
    group 'Administrators' do
      action :modify
      members inspec_data['inspec']['winrm-user']
      append true
    end
end
