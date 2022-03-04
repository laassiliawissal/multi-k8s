docker build -t wissallaassilia/multi-client:latest -t wissallaassilia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wissallaassilia/multi-server:latest -t wissallaassilia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wissallaassilia/multi-worker:latest -t wissallaassilia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wissallaassilia/multi-client:latest
docker push wissallaassilia/multi-server:latest
docker push wissallaassilia/multi-worker:latest

docker push wissallaassilia/multi-client:$SHA
docker push wissallaassilia/multi-server:$SHA
docker push wissallaassilia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wissallaassilia/multi-server:$SHA
kubectl set image deployments/client-deployment client=wissallaassilia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wissallaassilia/multi-worker:$SHA