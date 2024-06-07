# Dynamo AI Helm Charts
<img src="./logo.svg" alt="Sunset" title="Beautiful Sunset" width="175" height="">

## Helm Deployment

First, add the Dynamo helm repo.

```bash
helm repo add dynamoai https://documentation.dynamofl.com/helm --force-update
```

### `dynamoai-kube-system` (Recommended)
NOTE: Resources for the `dynamoai-kube-system` pertain to infrastructure services; therefore, they are deployed in the `kube-system` namespace.

#### Prerequisites

1. Permissions to create resources in the `kube-system` namespace
2. [KEDA](https://keda.sh/docs/2.14/deploy/) prerequisites (recommended, necessary for autoscaling)
3. [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/) prerequisites (recommended) 

#### Installing the Chart
```
helm upgrade -i dynamoai-kube-system dynamoai/dynamoai-kube-system \
  --version $DAI_VERSION \
  --values $DYNAMOAI_KUBE_SYSTEM_VALUES_FILE \
  --namespace kube-system 
```


#### Uninstalling the Chart
```
helm uninstall dynamoai-kube-system -n kube-system
```


### `dynamoai-base`

#### Installing the Chart
Deploy the base charts:
```bash
helm upgrade --install dynamoai-base dynamoai/dynamoai-base \
  --values $DYNAMOAI_BASE_VALUES_FILE \
  --namespace $DYNAMOAI_NAMESPACE \
  --create-namespace 
```
#### Uninstalling the Chart
```bash
helm uninstall dynamoai-base -n $DYNAMOAI_NAMESPACE
```

### `dynamoai-dynamoeval`

#### Installing the Chart
Deploy the base charts:
```bash
helm upgrade --install dynamoai-dynamoeval dynamoai/dynamoai-dynamoeval \
  --values $DYNAMOAI_DYNAMOEVAL_VALUES_FILE \
  --namespace $DYNAMOAI_NAMESPACE \
  --create-namespace 
```
#### Uninstalling the Chart
```bash
helm uninstall dynamoai-dynamoeval -n $DYNAMOAI_NAMESPACE
```

### `dynamoai-dynamoguard`

#### Installing the Chart
Deploy the base charts:
```bash
helm upgrade --install dynamoai-dynamoguard dynamoai/dynamoai-dynamoguard \
  --values $DYNAMOAI_DYNAMOGUARD_VALUES_FILE \
  --namespace $DYNAMOAI_NAMESPACE \
  --create-namespace 
```
#### Uninstalling the Chart
```bash
helm uninstall dynamoai-dynamoguard -n $DYNAMOAI_NAMESPACE
```
