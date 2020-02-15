docker build -t tema14/multi-client:latest -t tema14/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tema14/multi-server:latest -t tema14/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tema14/multi-worker:latest -t tema14/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tema14/multi-client:latest
docker push tema14/multi-server:latest
docker push tema14/multi-worker:latest
docker push tema14/multi-client:$SHA
docker push tema14/multi-server:$SHA
docker push tema14/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tema14/multi-server:$SHA
kubectl set image deployments/client-deployment client=tema14/multi-client:$SHA
kubectl set image deployments/worker-deployment client=tema14/multi-worker:$SHA