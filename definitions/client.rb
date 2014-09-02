define :burp_client, cname: nil, server: '', password: '', includes: [] do

  template '/etc/burp/burp.conf' do
    source 'client/burp.conf.erb'
    owner 'root'
    group 'root'
    variables(
      cname: params[:cname] || params[:name],
      server: params[:server],
      password: params[:password],
      includes: params[:includes]
    )
    mode 0644
  end

end
