#  vagrant-observability

vagrant starter kit 

## Requirements
    Virtualbox                  => https://www.virtualbox.org
    Vagrant                     => http://www.vagrantup.com
    vagrant-hostmanager         => vagrant plugin install vagrant-hostmanager
    vagrant-puppet-install      => vagrant plugin install vagrant-puppet-install
    vagrant-cachier  (optional) => vagrant plugin install vagrant-cachier
    
## Preparation

    git submodule update --init
    bundle install
    
## Setup

    vagrant up
    (cd terraform; terraform apply -auto-approve)

    This project doesnt create the required s3 bucket automatically during the puppet run. This will need to be done manually or by running the provided terraform code.

## Inspec tests

    bundle exec rake
    bundle exec rake inspec[centos7] 

## TLDR

### (G)UI interfaces

    alertmanager    => alerts.observability.vagrant:9093
    consul          => consul.observability.vagrant:8500
    icinga          => alerts.observability.vagrant         icingaadmin:icinga
    grafana         => grafana.observability.vagrant:3000   admin:secret
    mailhog         => mailhog.observability.vagrant:8025
    minio           => s3.observability.vagrant:9090        admin:supersecret
    prometheus      => metrics.observability.vagrant:9090
