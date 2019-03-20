
include_recipe 'datadog::dd-agent'

group 'nginx' do
  action	:modify
  members 	["dd-agent"]
  append	true
end

ddconfig = node['dd-agent-configs'] || node.dig('deploy', 'dd-agent-configs')

begin
  unless node['datadog']['agent6_config_dir'].nil? then
    ddbasedir = node['datadog']['agent6_config_dir']
  else
    ddbasedir = "/etc/datadog-agent"
  end
rescue
  ddbasedir = "/etc/datadog-agent"
end

unless ddconfig['rails'].nil? then
    unless ddconfig['rails']['installed'].nil? then
        execute 'update_logrotate' do
          user    'root'
          command 'grep "create 664" /etc/logrotate.d/opsworks_app_diaandco || sed -i -e "s/\}/        create 644 deploy nginx\n\}/" /etc/logrotate.d/opsworks_app_diaandco'
        end
        execute 'chmod_shared_dir' do
          user    'root'
          command 'chmod 771 /srv/www/diaandco/shared'
        end
        execute 'chmod_log_dir' do
          user    'root'
          command 'chmod 771 /srv/www/diaandco/shared/log'
        end
        for log_file in ddconfig['rails']['logs'] do
          next if log_file['path'].nil?
          file log_file['path'] do
            action    :touch
            mode	0644
          end
        end
        directory File.join(ddbasedir, 'conf.d/rails.d') do
            owner 'dd-agent'
            group 'dd-agent'
            mode '0755'
            action :create
        end
        unless ddconfig['rails'].nil? then
            template File.join(ddbasedir, 'conf.d/rails.d/conf.yaml') do
                source 'rails.yaml.erb'
                owner 'dd-agent'
                group 'dd-agent'
                mode '0755'
		variables vars: {'logs' => ddconfig['rails']['logs']}
                notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
            end
        end
    end
end

unless ddconfig['sidekiq'].nil? then
    unless ddconfig['sidekiq']['installed'].nil? then
        execute 'update_logrotate' do
          user    'root'
          command 'grep "create 664" /etc/logrotate.d/opsworks_app_diaandco || sed -i -e "s/\}/        create 644 deploy nginx\n\}/" /etc/logrotate.d/opsworks_app_diaandco'
        end
        execute 'chmod_shared_dir' do
          user    'root'
          command 'chmod 771 /srv/www/diaandco/shared'
        end
        execute 'chmod_log_dir' do
          user    'root'
          command 'chmod 771 /srv/www/diaandco/shared/log'
        end
        for log_file in ddconfig['sidekiq']['logs'] do
          next if log_file['path'].nil?
          file log_file['path'] do
            action    :touch
            mode	0644
          end
        end
        directory File.join(ddbasedir, 'conf.d/sidekiq.d') do
            owner 'dd-agent'
            group 'dd-agent'
            mode '0755'
            action :create
        end
        unless ddconfig['sidekiq'].nil? then
            template File.join(ddbasedir, 'conf.d/sidekiq.d/conf.yaml') do
                source 'sidekiq.yaml.erb'
                owner 'dd-agent'
                group 'dd-agent'
                mode '0755'
		variables vars: {'logs' => ddconfig['sidekiq']['logs']}
                notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
            end
        end
    end
end

unless ddconfig['whenever'].nil? then
    unless ddconfig['whenever']['installed'].nil? then
        execute 'update_logrotate' do
          user    'root'
          command 'grep "create 664" /etc/logrotate.d/opsworks_app_diaandco || sed -i -e "s/\}/        create 644 deploy nginx\n\}/" /etc/logrotate.d/opsworks_app_diaandco'
        end
        execute 'chmod_shared_dir' do
          user    'root'
          command 'chmod 771 /srv/www/diaandco/shared'
        end
        execute 'chmod_log_dir' do
          user    'root'
          command 'chmod 771 /srv/www/diaandco/shared/log'
        end
        for log_file in ddconfig['whenever']['logs'] do
          next if log_file['path'].nil?
          file log_file['path'] do
            action    :touch
            mode	0644
          end
        end
        directory File.join(ddbasedir, 'conf.d/whenever.d') do
            owner 'dd-agent'
            group 'dd-agent'
            mode '0755'
            action :create
        end
        unless ddconfig['whenever'].nil? then
            template File.join(ddbasedir, 'conf.d/whenever.d/conf.yaml') do
                source 'whenever.yaml.erb'
                owner 'dd-agent'
                group 'dd-agent'
                mode '0755'
		variables vars: {'logs' => ddconfig['whenever']['logs']}
                notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
            end
        end
    end
end
