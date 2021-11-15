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
    prometheus      => metrics.observability.vagrant:9090
    statping        => statping.observability.vagrant:8080  admin:secret

### Exposed Ports

    alertmanager 9093, 9094
    blackbox_exporter 9115
    grafana 3000
    grafana-agent 12345 12346, 9411
    graphite_exporter 9108, 9109
    loki 3100, 9095
    mailhog 1025, 8025
    mysql 3306
    node_exportert 9100
    prometheus 9090
    promtail 9080 38826
    pushgrateway 9091
    statsd_exporter 9102, 9125
    tempo 3200, 4317, 9096, 55680
