docker run -i -p 3000:3000 \
  -v /home/torkel/dev/grafana-docker/data:/var/lib/grafana \
  -e "GF_SERVER_ROOT_URL=http://localhost:3000"  \
  grafana/grafana
