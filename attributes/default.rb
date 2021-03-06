include_attribute "logstash"
include_attribute "elasticsearch"
include_attribute "kibana"
include_attribute "ktc-rsyslog"

# Override these recipe lists in 'per-env' attribute file.
default[:logging][:recipes_server_logstash] = %w{
  ktc-logging::logstash
}

default[:logging][:recipes_server_es] = %w{
  java
  elasticsearch::default
  logstash::default
  logstash::index_cleaner
}

default[:logging][:recipes_server_kibana] = %w{
  ktc-logging::kibana
}

default[:logging][:recipes_client] = %w{
  ktc-rsyslog::default
}

# Logstash attributes
default[:logstash][:server][:version] = '1.2.1'
default[:logstash][:server][:enable_embedded_es] = false
default[:logstash][:server][:source_url] =
  'https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar'
default[:logstash][:server][:inputs] = [:syslog => { :type=>'syslog', :port=>'5514' }]
default[:logstash][:server][:outputs] = []

default[:logstash][:server][:filter_list] = ["dmesg", "json_tag", "json_parse"]

default[:logstash][:index_cleaner][:days_to_keep] = 28
default[:logstash][:index_cleaner][:cron][:minute] = '0'
default[:logstash][:index_cleaner][:cron][:hour] = '1'
default[:logstash][:index_cleaner][:cron][:log_file] = '/dev/null'

default[:logstash][:splunk_host] = ''
default[:logstash][:splunk_port] = ''
default[:logstash][:log_level_for_splunk] = ['CRITICAL', 'ERROR', 'WARN', 'INFO']

# This search keyword is used for both logstash and kibana.
default[:logging][:elasticsearch_recipe] = "ktc-logging\\:\\:server_es"
default[:logging][:elasticsearch_query] = "recipes:#{node[:logging][:elasticsearch_recipe]} \
AND chef_environment:#{node.chef_environment}"

# These two attributes should have same value.
default[:logstash][:elasticsearch_cluster] = 'es-cluster-test'
default[:elasticsearch][:cluster][:name] = 'es-cluster-test'

# Kibana attributes
default[:kibana][:webserver] = 'apache'
default[:kibana][:apache][:enable_default_site] = true

# Rsyslog attributes
default[:rsyslog][:logstash_server] = ''

# common logging config
default[:logging][:separate_logs] = 'true'

# process monitoring
default[:logging][:logstash_processes] = [
  { "name" =>  "java", "shortname" =>  "java" }
]

default[:logging][:es_processes] = [
  { "name" =>  "java", "shortname" =>  "java" }
]

default[:logging][:kibana_processes] = [
  { "name" =>  "apache2", "shortname" =>  "apache2" }
]
