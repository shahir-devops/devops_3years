Here, I used deployment to deploy the application which are built on java and nodejs. where i used service as clusterIP for internal traffic and routed to external using ingress controller which create on loadbalancer and uses reverse proxy to distribute the traffic amoung the servers(private) in aws eks cluster

i have updated the image tag 1.2.0 --> 2.1.0 after the deployment by this method
kubectl set image deployment/mavenwebapp maven:shahir5890/maven:2.1.0 -n prod

## i check using this command 
kubectl rollout history deployment/mavenwebapp -n prod

## if any issues happens i need to rollback previous once using this commands
kubectl rollout undo deployment/mavenwebapp -n prod  

## to change to particular version i use this commands
kubectl rollout history deployment/mavenwebapp -n prod  --revision=2

## keep cause for the rollout 
kubectl annotate deployment mavenwebapp kubernetes.io/change-cause="update image" -n prod

## another method 
kubectl edit deployment mavenwebapp -n prod

  -> change image tag to 2.1.0 

zero deployment, trigger rolling update

## for helm 
helm upgrade my-release my-chart --set image.tag=2.1.0

## livenessProbe: 
check the container if it fails , it restart the container (restart if container struck)

## readinessProbe: 
check if the container is ready to accept the traffic, if fails k8s removes from the service endpoints(k8s cluster) -> (control service routing)

readinessProbe -> startupProbe -> livenesprobe

## startupProbe
a startupProbe checks whether the application has successfully started

it is used to prevent livenessProbe from killing slow starting apps, gives the app enough time to initialize (like load db, config )

## Troubleshoot application

-> kubectl get pods -n prod

-> kubectl describe pod <podname> -n prod -> check events, (livessprobe, readinessprobe) connection refused, backoff restarting container failure

-> kubectl logs <podname> -n prod -->App crash, port mismatch, endpoint not available

-> kubectl exec -it <podname> -n prod -- /bin/sh -> manually check inside the pod
    curl localhost:8080/health
 
## problem                                    cause                               solution

App restarting repeating -> livenesswrong, less initialdelayseconds,  -> increase initialsec, give correct path

pod not ready -> readiness failing, server not available -> fix end points or path, restart node or kubectl

connection refused -> wrong port, already allocated -> match containerport, change (nodeport, Loadbalancer)

404 error -> wrong path -> change the path

## how canary deployment works 
old version on one server, new version on another server

by default kubenetes doesnt deploy based on servers, it deploys based on labels + scheduling rules

kubectl label node <nodeIP> env=canary
kubectl label node <nodeIP> env=stable

ex: 

    nodeSelctor:

      env=stable

    containers:

    - name: 

## Blue-green deployment
we maintain two identical environment, one new verison is deployed to green, and then traffic is switched via service selector. it ensure zero downtime ad instant rollback

green works -> traffic to blue ->X failed blue <-- rollback

ex:

node1:    

        selector:

            matchLabels: 

              version: blue
    
node2:  
          selector:

            matchLabels:

               version: green

service:
          selector:  #route the traffic

            version: blue

## error:

ImagePullBackOff: incorrect image tag, Repo permission

sol: kubectl describe pod <pod> check events & ImagePull errors

OOMkilled: out of memory -> increase memory, 

sol: kubectl top pod <pod-name>
     kubectl scale deployment <name> --replicas=3
     