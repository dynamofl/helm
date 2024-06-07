## Installation Instructions

The following commands are used to install various components in Kubernetes using Helm. These components are organized into different namespaces to keep resources isolated and manageable. Ensure Helm is installed on your system before running these commands.

# Install Base Kubernetes Setup for DynamoAI
helm install dynamoai-k8s-base dynamoai-kube-system --namespace kube-system --create-namespace

# Install NGINX Ingress Controller
helm install dynamoai-nginx dynamoai-nginx --namespace dynamoai-nginx --create-namespace --values dynamoai-nginx/values.yaml

# Install KEDA for Event-driven Autoscaling
helm install dynamoai-keda dynamoai-keda --namespace keda --create-namespace --values dynamoai-keda/values.yaml

# Install NVIDIA Device Plugin for Kubernetes
helm install dynamoai-nvidia dynamoai-nvidia --namespace nvidia-device-plugin --create-namespace --values dynamoai-nvidia/values.yaml

# Install Karpenter for Provisioning
helm install dynamoai-karpenter dynamoai-karpenter --namespace kube-system --create-namespace --values dynamoai-karpenter/values.yaml