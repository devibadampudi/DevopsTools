log_location             STDOUT
node_name                'chefuser'
client_key               'chefuser.pem'
validation_client_name   'orguser-validator'
validation_key           'orguser-validator.pem'
chef_server_url          'https://<chef automate DNS name >/organizations/orguser'
syntax_check_cache_path  '~/chef-repo/.chef/syntax_check_cache'
cookbook_path            [ '~/chef-repo/cookbooks' ]


