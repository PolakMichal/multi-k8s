docker build -t michalpolakisdd/multi-client:latest -t michalpolakisdd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t michalpolakisdd/multi-server:latest -t michalpolakisdd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t michalpolakisdd/multi-worker:latest -t michalpolakisdd/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push michalpolakisdd/multi-client:latest
docker push michalpolakisdd/multi-server:latest
docker push michalpolakisdd/multi-worker:latest

docker push michalpolakisdd/multi-client:$SHA
docker push michalpolakisdd/multi-server:$SHA
docker push michalpolakisdd/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=michalpolakisdd/multi-server:$SHA
kubectl set image deployments/client-deployment client=michalpolakisdd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=michalpolakisdd/multi-worker:$SHA