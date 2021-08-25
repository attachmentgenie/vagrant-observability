#!/usr/bin/env sh

vagrant ssh dc1 -c "sudo mysqldump --single-transaction --flush-logs --master-data --hex-blob --routines --triggers --databases grafana | gzip > /tmp/vagrant-puppet/environments/grafana.sql.gz"

vagrant ssh dc1 -c 'sudo mysql -e "stop slave;"'
vagrant ssh dc2 -c 'sudo mysql -e "stop slave;"'

vagrant ssh dc1 -c "sudo mysql -e \"CHANGE MASTER TO MASTER_HOST='192.168.43.41', MASTER_USER='repl_user', MASTER_PASSWORD='secret';\""
vagrant ssh dc2 -c "sudo mysql -e \"CHANGE MASTER TO MASTER_HOST='192.168.43.40', MASTER_USER='repl_user', MASTER_PASSWORD='secret';\""

vagrant ssh dc2 -c "zcat /tmp/vagrant-puppet/environments/grafana.sql.gz | sudo mysql"
vagrant ssh dc2 -c 'sudo mysql -e "start slave;"'
vagrant ssh dc2 -c 'sudo mysql -e "flush tables with read lock;"'

repl_file=$(vagrant ssh dc2 -c 'sudo mysql -e "show master status\G" | grep "File"| cut -d ":" -f2')
repl_position=$(vagrant ssh dc2 -c 'sudo mysql -e "show master status\G" | grep "Position"| cut -d ":" -f2')
vagrant ssh dc1 -c "sudo mysql -e \"change master to MASTER_LOG_FILE='${repl_file}', MASTER_LOG_POS=${repl_position};\""
vagrant ssh dc1 -c 'sudo mysql -e "start slave;"'

vagrant ssh dc2 -c 'sudo mysql -e "unlock tables;"'
