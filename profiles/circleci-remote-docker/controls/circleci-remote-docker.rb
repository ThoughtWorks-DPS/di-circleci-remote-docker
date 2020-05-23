control 'packages' do
  impact 1.0
  title 'confirm package installation'
  desc 'confirm all desired packages are installed'
  describe command('apk info -v') do
    its('stdout') { should include ('git-2.24.3-r0') }
    its('stdout') { should include ('openssh-8.1_p1-r0') }
    its('stdout') { should include ('tar-1.32-r1') }
    its('stdout') { should include ('gzip-1.10-r0') }
    its('stdout') { should include ('ca-certificates-20191127-r1') }
    its('stdout') { should include ('sudo-1.8.31-r0') }
    its('stdout') { should include ('libintl-0.20.1-r2') }
  end
end

control 'git version' do
  impact 1.0
  title 'confirm git version installed'
  desc 'confirm version reported by git matches the desired version'
  describe command('git --version') do
    its('stdout') { should include ('2.24') }
  end
end

control 'openssh version' do
  impact 1.0
  title 'confirm openssh version installed'
  desc 'confirm version reported by openssh matches the desired version'
  describe command('ssh -V') do
    its('stderr') { should include ('8.1') }
  end
end

control 'tar version' do
  impact 1.0
  title 'confirm tar version installed'
  desc 'confirm version reported by tar matches the desired version'
  describe command('tar --version') do
    its('stdout') { should include ('1.32') }
  end
end

control 'gzip version' do
  impact 1.0
  title 'confirm gzip version installed'
  desc 'confirm version reported by gzip matches the desired version'
  describe command('gzip --version') do
    its('stdout') { should include ('1.10') }
  end
end

control 'ca-certificates installed' do
  impact 1.0
  title 'confirm ca-certificates installed'
  desc 'confirm certificate authorities have been installed for secure remote communication'
  describe command('ls /etc/ssl/certs/') do
    its('stdout') { should include ('ca-cert-DigiCert_Assured_ID_Root_CA.pem') }
  end
end

control 'sudo version' do
  impact 1.0
  title 'confirm sudo version installed'
  desc 'confirm version reported by sudo matches the desired version'
  describe command('sudo --version') do
    its('stdout') { should include ('1.8') }
  end
end

control 'localization' do
  impact 1.0
  title 'confirm locales for alpine'
  desc 'confirm localization installed'
  describe command('locale -a') do
    its('stdout') { should include ('C.UTF-8') }
    its('stdout') { should include ('fr_FR.UTF-8') }
    its('stdout') { should include ('de_CH.UTF-8') }
  end
  describe command('locale') do
    its('stdout') { should include ('LANG=C.UTF-8') }
    its('stdout') { should include ('LC_ALL=en_US.UTF-8') }
  end
end

describe user('circleci') do
  it { should exist }
  its('uid') { should eq 3434 }
  its('gid') { should eq 3434 }
  its('group') { should eq 'circleci' }
  its('home') { should eq '/home/circleci' }
end

describe directory('/home/circleci') do
  its('owner') { should eq 'circleci' }
  its('group') { should eq 'circleci' }
end

describe directory('/home/circleci/project') do
  its('owner') { should eq 'circleci' }
  its('group') { should eq 'circleci' }
end
