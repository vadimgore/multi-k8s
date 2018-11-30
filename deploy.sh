docker build -t vadimgore/multi-client:latest -t vadimgore/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vadimgore/multi-server:latest -t vadimgore/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vadimgore/multi-worker:latest -t vadimgore/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vadimgore/multi-client:latest
docker push vadimgore/multi-server:latest
docker push vadimgore/multi-worker:latest
docker push vadimgore/multi-client:$SHA
docker push vadimgore/multi-server:$SHA
docker push vadimgore/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vadimgore/multi-server:$SHA
kubectl set image deployments/client-deployment client=vadimgore/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vadimgore/multi-worker:$SHA