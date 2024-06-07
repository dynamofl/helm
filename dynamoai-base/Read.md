helm install dynamoai-k8s-base dynamoai-kube-system --namespace kube-system --create-namespace      
helm install dynamoai-nginx dynamoai-nginx --namespace dynamoai-nginx --create-namespace --values dynamoai-nginx/values.yaml
helm install dynamoai-keda dynamoai-keda --namespace keda --create-namespace --values dynamoai-keda/values.yaml
helm install dynamoai-nvidia dynamoai-nvidia --namespace nvidia-device-plugin --create-namespace --values dynamoai-nvidia/values.yaml
helm install dynamoai-karpenter dynamoai-karpenter --namespace kube-system --create-namespace --values dynamoai-karpenter/values.yaml
