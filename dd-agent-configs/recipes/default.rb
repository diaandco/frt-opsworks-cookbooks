if node['dd-agent-configs']['rails']['installed']
    directory '/etc/dd-agent/conf.d/rails' do
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        action :create
    end
    template '/etc/dd-agent/conf.d/rails/conf.yaml' do
        source 'rails.yaml.erb'
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
    end
end

if node['dd-agent-configs']['sidekiq']['installed']
    directory '/etc/dd-agent/conf.d/sidekiq' do
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        action :create
    end
    template '/etc/dd-agent/conf.d/sidekiq/conf.yaml' do
        source 'sidekiq.yaml.erb'
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
    end
end

if node['dd-agent-configs']['whenever']['installed']
    directory '/etc/dd-agent/conf.d/whenever' do
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        action :create
    end
    template '/etc/dd-agent/conf.d/whenever/conf.yaml' do
        source 'whenever.yaml.erb'
        owner 'dd-agent'
        group 'dd-agent'
        mode '0755'
        notifies :restart, 'service[datadog-agent]', :delayed unless node['datadog']['agent_start'] == false
    end
end
