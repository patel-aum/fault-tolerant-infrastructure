## Automated Infrastructure Deployment | Terraform, AWS, Docker, Kubernetes
## commands i used to deploy
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack


kubectl apply -f https://download.elastic.co/downloads/eck/1.8.0/all-in-one.yaml

kubectl apply -f prometheus-config.yaml
kubectl apply -f elk-stack.yaml



## Technologies Used

- Java Spring Boot for microservices
- Docker for containerization
- Kubernetes for orchestration
- Terraform for infrastructure as code
- AWS as the cloud provider
- Prometheus and Grafana for monitoring
- ELK Stack (Elasticsearch, Logstash, Kibana) for logging

### Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed
- kubectl installed
- Docker and Docker Compose installed
- Helm installed


