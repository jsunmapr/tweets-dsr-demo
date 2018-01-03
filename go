cp template-converged-600-400.yaml /tmp
chmod 755 /tmp/template-converged-600-400.yaml
su - mapr -c "/opt/mapr/installer/bin/mapr-installer-cli install -fnv -t /tmp/template-converged-600-400.yaml -u mapr:mapr@localhost:9443"
