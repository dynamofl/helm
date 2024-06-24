## Installation Instructions

The following commands are used to install various components in Kubernetes using Helm. These components are organized into different namespaces to keep resources isolated and manageable. Ensure Helm is installed on your system before running these commands.

# Install Base Kubernetes Setup for DynamoAI
helm upgrade --install dynamoai-k8s-base dynamoai-kube-system --namespace kube-system --create-namespace

# Install NGINX Ingress Controller
helm upgrade --install dynamoai-nginx dynamoai-nginx --namespace dynamoai-nginx --create-namespace --values dynamoai-nginx/values.yaml

# Install KEDA for Event-driven Autoscaling
helm upgrade --install dynamoai-keda dynamoai-keda --namespace keda --create-namespace --values dynamoai-keda/values.yaml

# Install NVIDIA Device Plugin for Kubernetes
helm upgrade --install dynamoai-nvidia dynamoai-nvidia --namespace nvidia-device-plugin --create-namespace --values dynamoai-nvidia/values.yaml

# Install Karpenter for Provisioning
helm upgrade --install dynamoai-karpenter dynamoai-karpenter --namespace kube-system --create-namespace --values dynamoai-karpenter/values.yaml

# install Prometheus for Monitoring
helm upgrade --install dynamoai-prometheus dynamoai-prometheus --namespace monitoring --create-namespace --values dynamoai-prometheus/values.yaml

# To uninstall the Charts

helm uninstall dynamoai-karpenter --namespace kube-system
helm uninstall dynamoai-nvidia --namespace nvidia-device-plugin
helm uninstall dynamoai-keda --namespace keda
helm uninstall dynamoai-nginx --namespace dynamoai-nginx 
helm uninstall dynamoai-k8s-base --namespace kube-system 
helm uninstall dynamoai-prometheus --namespace monitoring


