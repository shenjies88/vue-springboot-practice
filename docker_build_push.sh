#!/bin/bash
version=$1
backend_name=$2
front_name=$3
repo=$4
namespace=$5
docker login -u ${PLUGIN_DOCKER_USERNAME} -p ${PLUGIN_DOCKER_PASSWORD} ${repo};
# 后端
docker build --rm=true -f dockerfile-backend -t ${repo}/${namespace}/${backend_name}:${version} .;
docker push ${repo}/${namespace}/${backend_name}:${version};
docker rmi ${repo}/${namespace}/${backend_name}:${version};
# 前端
docker build --rm=true -f dockerfile-front -t ${repo}/${namespace}/${front_name}:${version} .;
docker push ${repo}/${namespace}/${front_name}:${version};
docker rmi ${repo}/${namespace}/${front_name}:${version};
docker volume prune -f
docker system prune -f