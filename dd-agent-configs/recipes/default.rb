if node['dd-agent-configs']['rails']['installed']
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
