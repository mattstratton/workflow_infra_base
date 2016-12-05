# workflow_infra_base

This cookbook configures infrastructure nodes (Acceptance, Union, Rehearsal, Delivered) for use in Chef Workflow.

### InSpec Support

If you would like to enable your nodes to be able to run inspec tests (using the [workflow_inspec_helper cookbook](https://github.com/mattstratton/workflow_inspec_helper)), you will need to do the following:

Create a data bag with the name `delivery-secrets` with an item named `<YOUR_WORKFLOW_ENTERPRISE_NAME>-<YOUR_WORKFLOW_ORG_NAME`. The key used to encrypt this databag needs to be set as `encrypted_databag_secret` on your infrastructure nodes.

Set the following attributes (either via a role or in a wrapper cookbook):

```
default['workflow_infra_base']['workflow_enterprise'] = '<YOUR_WORKFLOW_ENTERPRISE_NAME'
default['workflow_infra_base']['workflow_org'] = '<YOUR_WORKFLOW_ORG_NAME'
default['workflow_infra_base']['enable_inspec'] = true
```

See the [workflow_inspec_helper cookbook](https://github.com/mattstratton/workflow_inspec_helper) for more information on the contents of this data bag.
