include_recipe 'delayed_job::default'

node[:deploy].each do |application, deploy|

  # This stops all delayed jobs which have a pid file
  bash "delayed_job-#{application}-stop" do
    cwd "#{deploy[:deploy_to]}/current"
    user 'deploy'
    code 'bin/delayed_job stop'

    action :nothing
  end

  bash "delayed_job-#{application}-reload" do
    user 'root'

    # We unmonitor the delayed jobs because we will stop them manually
    # They will become monitored again when restarted
    code <<CODE
monit -g delayed_job unmonitor
monit reload
CODE

    action :nothing
    subscribes :run, "template[/etc/monit.d/#{application}_delayed_job.monitrc]", :immediately
    notifies :run, "bash[delayed_job-#{application}-stop]", :immediately
  end
end

include_recipe 'delayed_job::restart'