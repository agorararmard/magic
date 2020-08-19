mkdir -p logs/docker
echo "dir created"
docker build --rm -t magic . | tee logs/docker/magic.build.txt

