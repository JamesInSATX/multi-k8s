docker build -t jamesn8docker/multi-client:latest -t jamesn8docker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jamesn8docker/multi-server:latest -t jamesn8docker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jamesn8docker/multi-worker:latest -t jamesn8docker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jamesn8docker/multi-client:latest
docker push jamesn8docker/multi-server:latest
docker push jamesn8docker/multi-worker:latest

docker push jamesn8docker/multi-client:$SHA
docker push jamesn8docker/multi-server:$SHA
docker push jamesn8docker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jamesn8docker/multi-server:$SHA
kubectl set image deployments/client-deployment client=jamesn8docker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jamesn8docker/multi-worker:$SHA