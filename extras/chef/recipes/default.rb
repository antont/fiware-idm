# fix source
bash :fix_source do
  code <<-EOH
    rm /bin/sh && ln -s /bin/bash /bin/sh
  EOH
end

# Install Ubuntu dependencies
bash :set_dependencies do
  code <<-EOH
    sudo apt-get update && \
    sudo apt-get install -y wget python python-dev git && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py
  EOH
end


# Install virtualenvwrapper
bash :install_wrapper do
  code <<-EOH
    pip install virtualenvwrapper && \
    export WORKON_HOME=~/venvs && \
    mkdir -p $WORKON_HOME
  EOH
end


# Download latest version of the code
bash :download_version do
  code <<-EOH
    git clone https://github.com/ging/fiware-idm #{node['fiware-idm'][:app_dir]} && \
    cd #{node['fiware-idm'][:app_dir]} && \
    cp conf/settings.py.example conf/settings.py
  EOH
end

# Install python dependecies
bash :install_pydeps do
  code <<-EOH
    cd #{node['fiware-idm'][:app_dir]} && \
    source /usr/local/bin/virtualenvwrapper.sh && \
    mkvirtualenv idm_tools && \
    pip install -r requirements.txt
  EOH
end