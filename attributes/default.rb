case node['platform_family']
when 'windows'
  default['push_jobs']['package_url']      = 'https://packages.chef.io/stable/windows/2008r2/push-jobs-client-2.1.4-1-x86.msi'
  default['push_jobs']['package_checksum'] = '3b979f8d362738c8ac126ace0e80122a4cbc53425d5f8cf9653cdd79eca16d62'
end

default['push_jobs']['allow_unencrypted']           = true

if node['os'] = 'linux'
  default['authorization']['sudo']['include_sudoers_d']
end

default['workflow_infra_base']['workflow_enterprise'] = nil
default['workflow_infra_base']['workflow_org'] = nil
default['workflow_infra_base']['enable_inspec'] = false
