docker build -t chendu36/multi-client:latest -t chendu36/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chendu36/multi-server:latest -t chendu36/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chendu36/multi-worker:latest -t chendu36/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chendu36/multi-client:latest
docker push chendu36/multi-server:latest
docker push chendu36/multi-worker:latest
docker push chendu36/multi-client:$SHA
docker push chendu36/multi-server:$SHA
docker push chendu36/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chendu36/multi-server:$SHA
kubectl set image deployments/client-deployment client=chendu36/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chendu36/multi-worker:$SHA


