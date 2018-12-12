group 'nginx' do
  action	:modify
  members 	["dd-agent"]
  append	true
end

if node['dd-agent-configs']['rails']['installed']
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
    for log_file in node['dd-agent-configs']['rails']['logs'] do
      file log_file['path'] do
        action    :touch
        mode	0644
      end
    end
    directory File.join(node['datadog']['agent6_config_dir'], 'conf.d/rails.d') do
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        action :create
    end
    template File.join(node['datadog']['agent6_config_dir'], 'conf.d/rails.d/conf.yaml') do
        source 'rails.yaml.erb'
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
    end
end

if node['dd-agent-configs']['sidekiq']['installed']
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
    for log_file in node['dd-agent-configs']['sidekiq']['logs'] do
      file log_file['path'] do
        action    :touch
        mode	0644
      end
    end
    directory File.join(node['datadog']['agent6_config_dir'], 'conf.d/sidekiq.d') do
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        action :create
    end
    template File.join(node['datadog']['agent6_config_dir'], 'conf.d/sidekiq.d/conf.yaml') do
        source 'sidekiq.yaml.erb'
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
    end
end

if node['dd-agent-configs']['whenever']['installed']
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
    for log_file in node['dd-agent-configs']['whenever']['logs'] do
      file log_file['path'] do
        action    :touch
        mode	0644
      end
    end
    directory File.join(node['datadog']['agent6_config_dir'], 'conf.d/whenever.d') do
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        action :create
    end
    template File.join(node['datadog']['agent6_config_dir'], 'conf.d/whenever.d/conf.yaml') do
        source 'whenever.yaml.erb'
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
    end
end
