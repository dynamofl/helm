# dynamoai-kube-system

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

Kubernetes: `>=1.20.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/aws-ebs-csi-driver/ | aws-ebs-csi-driver | 2.30.0 |
| https://aws.github.io/eks-charts/aws-vpc-cni | aws-vpc-cni | v1.16.0 |
| oci://public.ecr.aws/karpenter/karpenter | karpenter | 0.36.0 |
| https://kubernetes-sigs.github.io/metrics-server/ | metrics-server | 3.8.2 |
| https://charts.jetstack.io | cert-manager | v1.10.0 |
| https://kubernetes.github.io/ingress-nginx | ingress-nginx | 4.7.1 |
| file://./charts/aws-load-balancer-controller-crds-2-6-1 | aws-load-balancer-crds-2-6-1 | v0.0.1 |
| https://dynamoai.github.io/helm | kserve | v0.11.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k8Infra.subnetAzs | list | `[]` | Subnet availability zones |
| k8Infra.privateSubnetIds | list | `[]` | Private subnet IDs |
| k8Infra.secondaryPrivateSubnetIds | list | `[]` | Secondary private subnet IDs |
| k8Infra.clusterSecurityGroupId | string | `""` | Cluster security group ID |
| awsEbsCsiDriver.enabled | bool | `true` | Enable AWS EBS CSI Driver |
| awsEbsCsiDriver.image.repository | string | `"public.ecr.aws/ebs-csi-driver/aws-ebs-csi-driver"` | Repository for AWS EBS CSI Driver image |
| awsEbsCsiDriver.image.tag | string | `""` | Tag for AWS EBS CSI Driver image |
| awsEbsCsiDriver.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for AWS EBS CSI Driver image |
| awsEbsCsiDriver.customLabels | object | `{}` | Custom labels for AWS EBS CSI Driver |
| awsEbsCsiDriver.sidecars.provisioner.image.repository | string | `"public.ecr.aws/eks-distro/kubernetes-csi/external-provisioner"` | Repository for external provisioner image |
| awsEbsCsiDriver.sidecars.provisioner.image.tag | string | `"v4.0.1-eks-1-30-2"` | Tag for external provisioner image |
| awsEbsCsiDriver.sidecars.provisioner.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for external provisioner image |
| awsEbsCsiDriver.sidecars.provisioner.logLevel | int | `2` | Log level for external provisioner |
| awsEbsCsiDriver.sidecars.provisioner.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for external provisioner |
| awsEbsCsiDriver.sidecars.provisioner.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for external provisioner |
| awsEbsCsiDriver.sidecars.attacher.image.repository | string | `"public.ecr.aws/eks-distro/kubernetes-csi/external-attacher"` | Repository for external attacher image |
| awsEbsCsiDriver.sidecars.attacher.image.tag | string | `"v4.5.1-eks-1-30-2"` | Tag for external attacher image |
| awsEbsCsiDriver.sidecars.attacher.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for external attacher image |
| awsEbsCsiDriver.sidecars.attacher.logLevel | int | `2` | Log level for external attacher |
| awsEbsCsiDriver.sidecars.attacher.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for external attacher |
| awsEbsCsiDriver.sidecars.attacher.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for external attacher |
| awsEbsCsiDriver.sidecars.snapshotter.image.repository | string | `"public.ecr.aws/eks-distro/kubernetes-csi/external-snapshotter/csi-snapshotter"` | Repository for external snapshotter image |
| awsEbsCsiDriver.sidecars.snapshotter.image.tag | string | `"v7.0.2-eks-1-30-2"` | Tag for external snapshotter image |
| awsEbsCsiDriver.sidecars.snapshotter.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for external snapshotter image |
| awsEbsCsiDriver.sidecars.snapshotter.logLevel | int | `2` | Log level for external snapshotter |
| awsEbsCsiDriver.sidecars.snapshotter.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for external snapshotter |
| awsEbsCsiDriver.sidecars.snapshotter.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for external snapshotter |
| awsEbsCsiDriver.sidecars.livenessProbe.image.repository | string | `"public.ecr.aws/eks-distro/kubernetes-csi/livenessprobe"` | Repository for liveness probe image |
| awsEbsCsiDriver.sidecars.livenessProbe.image.tag | string | `"v2.12.0-eks-1-30-2"` | Tag for liveness probe image |
| awsEbsCsiDriver.sidecars.livenessProbe.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for liveness probe image |
| awsEbsCsiDriver.sidecars.livenessProbe.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for liveness probe |
| awsEbsCsiDriver.sidecars.livenessProbe.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for liveness probe |
| awsEbsCsiDriver.sidecars.resizer.image.repository | string | `"public.ecr.aws/eks-distro/kubernetes-csi/external-resizer"` | Repository for external resizer image |
| awsEbsCsiDriver.sidecars.resizer.image.tag | string | `"v1.10.1-eks-1-30-2"` | Tag for external resizer image |
| awsEbsCsiDriver.sidecars.resizer.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for external resizer image |
| awsEbsCsiDriver.sidecars.resizer.logLevel | int | `2` | Log level for external resizer |
| awsEbsCsiDriver.sidecars.resizer.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for external resizer |
| awsEbsCsiDriver.sidecars.resizer.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for external resizer |
| awsEbsCsiDriver.sidecars.nodeDriverRegistrar.image.repository | string | `"public.ecr.aws/eks-distro/kubernetes-csi/node-driver-registrar"` | Repository for node driver registrar image |
| awsEbsCsiDriver.sidecars.nodeDriverRegistrar.image.tag | string | `"v2.10.1-eks-1-30-2"` | Tag for node driver registrar image |
| awsEbsCsiDriver.sidecars.nodeDriverRegistrar.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for node driver registrar image |
| awsEbsCsiDriver.sidecars.nodeDriverRegistrar.logLevel | int | `2` | Log level for node driver registrar |
| awsEbsCsiDriver.sidecars.nodeDriverRegistrar.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for node driver registrar |
| awsEbsCsiDriver.sidecars.nodeDriverRegistrar.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for node driver registrar |
| awsEbsCsiDriver.sidecars.volumemodifier.image.repository | string | `"public.ecr.aws/ebs-csi-driver/volume-modifier-for-k8s"` | Repository for volume modifier image |
| awsEbsCsiDriver.sidecars.volumemodifier.image.tag | string | `"v0.3.0"` | Tag for volume modifier image |
| awsEbsCsiDriver.sidecars.volumemodifier.logLevel | int | `2` | Log level for volume modifier |
| awsEbsCsiDriver.sidecars.volumemodifier.securityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for volume modifier |
| awsEbsCsiDriver.sidecars.volumemodifier.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for volume modifier |
| awsEbsCsiDriver.proxy.http_proxy | string | `""` | HTTP proxy for AWS EBS CSI Driver |
| awsEbsCsiDriver.proxy.no_proxy | string | `""` | No proxy for AWS EBS CSI Driver |
| awsEbsCsiDriver.awsAccessSecret.name | string | `"aws-secret"` | Name of the AWS access secret |
| awsEbsCsiDriver.awsAccessSecret.keyId | string | `"key_id"` | Key ID for the AWS access secret |
| awsEbsCsiDriver.awsAccessSecret.accessKey | string | `"access_key"` | Access key for the AWS access secret |
| awsEbsCsiDriver.controller.batching | bool | `true` | Enable batching for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.volumeModificationFeature.enabled | bool | `false` | Enable volume modification feature for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.sdkDebugLog | bool | `false` | Enable SDK debug log for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.loggingFormat | string | `"text"` | Logging format for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.defaultFsType | string | `"ext4"` | Default filesystem type for volumes |
| awsEbsCsiDriver.controller.env | list | `[]` | Environment variables for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.envFrom | list | `[]` | Environment variables from sources for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.extraCreateMetadata | bool | `true` | Add PV/PVC metadata to plugin create requests |
| awsEbsCsiDriver.controller.extraVolumeTags | object | `{}` | Extra volume tags for dynamically provisioned volumes |
| awsEbsCsiDriver.controller.enableMetrics | bool | `false` | Enable metrics for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.serviceMonitor.forceEnable | bool | `false` | Force enable ServiceMonitor for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.serviceMonitor.labels.release | string | `"prometheus"` | Labels for ServiceMonitor |
| awsEbsCsiDriver.controller.serviceMonitor.interval | string | `"15s"` | Interval for ServiceMonitor |
| awsEbsCsiDriver.controller.logLevel | int | `2` | Log level for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.userAgentExtra | string | `"helm"` | User agent extra for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.nodeSelector | object | `{}` | Node selector for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.deploymentAnnotations | object | `{}` | Annotations for AWS EBS CSI Driver controller deployment |
| awsEbsCsiDriver.controller.podAnnotations | object | `{}` | Annotations for AWS EBS CSI Driver controller pods |
| awsEbsCsiDriver.controller.podLabels | object | `{}` | Labels for AWS EBS CSI Driver controller pods |
| awsEbsCsiDriver.controller.priorityClassName | string | `"system-cluster-critical"` | Priority class name for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.region | string | `""` | AWS region for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.replicaCount | int | `2` | Replica count for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.revisionHistoryLimit | int | `10` | Revision history limit for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.socketDirVolume.emptyDir | object | `{}` | EmptyDir volume for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.updateStrategy.type | string | `"RollingUpdate"` | Update strategy for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.updateStrategy.rollingUpdate.maxUnavailable | int | `1` | Max unavailable for rolling update |
| awsEbsCsiDriver.controller.resources.requests.cpu | string | `"10m"` | CPU request for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.resources.requests.memory | string | `"40Mi"` | Memory request for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.resources.limits.memory | string | `"256Mi"` | Memory limit for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.serviceAccount.create | bool | `true` | Create service account for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.serviceAccount.name | string | `"ebs-csi-controller-sa"` | Name of the service account for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.serviceAccount.annotations | object | `{}` | Annotations for the service account |
| awsEbsCsiDriver.controller.serviceAccount.automountServiceAccountToken | bool | `true` | Automount service account token for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.tolerations | list | `[{"key":"CriticalAddonsOnly","operator":"Exists"},{"effect":"NoExecute","operator":"Exists","tolerationSeconds":300}]` | Tolerations for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.topologySpreadConstraints | list | `[]` | Topology spread constraints for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.securityContext.runAsNonRoot | bool | `true` | Run as non-root for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.securityContext.runAsUser | int | `1000` | Run as user for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.securityContext.runAsGroup | int | `1000` | Run as group for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.securityContext.fsGroup | int | `1000` | FS group for AWS Ebs CSI Driver controller |
| awsEbsCsiDriver.controller.volumes | list | `[]` | Additional volumes for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.volumeMounts | list | `[]` | Volume mounts for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.containerSecurityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for AWS EBS CSI Driver controller container |
| awsEbsCsiDriver.controller.containerSecurityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation for AWS EBS CSI Driver controller container |
| awsEbsCsiDriver.controller.initContainers | list | `[]` | Init containers for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.controller.otelTracing | object | `{}` | OpenTelemetry tracing for AWS EBS CSI Driver controller |
| awsEbsCsiDriver.node.env | list | `[]` | Environment variables for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.envFrom | list | `[]` | Environment variables from sources for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.kubeletPath | string | `"/var/lib/kubelet"` | Kubelet path for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.loggingFormat | string | `"text"` | Logging format for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.logLevel | int | `2` | Log level for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.priorityClassName | string | `""` | Priority class name for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.additionalArgs | list | `[]` | Additional arguments for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms | list | `[{"matchExpressions":[{"key":"eks.amazonaws.com/compute-type","operator":"NotIn","values":["fargate"]},{"key":"node.kubernetes.io/instance-type","operator":"NotIn","values":["a1.medium","a1.large","a1.xlarge","a1.2xlarge","a1.4xlarge"]}]}]` | Node affinity for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.nodeSelector | object | `{}` | Node selector for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.daemonSetAnnotations | object | `{}` | Annotations for AWS EBS CSI Driver node DaemonSet |
| awsEbsCsiDriver.node.podAnnotations | object | `{}` | Annotations for AWS EBS CSI Driver node pods |
| awsEbsCsiDriver.node.podLabels | object | `{}` | Labels for AWS EBS CSI Driver node pods |
| awsEbsCsiDriver.node.tolerateAllTaints | bool | `true` | Tolerate all taints for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.tolerations | list | `[{"operator":"Exists","effect":"NoExecute","tolerationSeconds":300}]` | Tolerations for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.resources.requests.cpu | string | `"10m"` | CPU request for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.resources.requests.memory | string | `"40Mi"` | Memory request for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.resources.limits.memory | string | `"256Mi"` | Memory limit for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.revisionHistoryLimit | int | `10` | Revision history limit for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.probeDirVolume.emptyDir | object | `{}` | EmptyDir volume for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.serviceAccount.create | bool | `true` | Create service account for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.serviceAccount.name | string | `"ebs-csi-node-sa"` | Name of the service account for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.serviceAccount.annotations | object | `{}` | Annotations for the service account |
| awsEbsCsiDriver.node.serviceAccount.automountServiceAccountToken | bool | `true` | Automount service account token for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.enableLinux | bool | `true` | Enable Linux DaemonSet for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.enableWindows | bool | `false` | Enable Windows DaemonSet for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.reservedVolumeAttachments | string | `""` | Reserved volume attachments for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.volumeAttachLimit | string | `""` | Volume attach limit for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.updateStrategy.type | string | `"RollingUpdate"` | Update strategy for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.updateStrategy.rollingUpdate.maxUnavailable | string | `"10%"` | Max unavailable for rolling update |
| awsEbsCsiDriver.node.hostNetwork | bool | `false` | Use host network for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.securityContext.runAsNonRoot | bool | `false` | Run as non-root for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.securityContext.runAsUser | int | `0` | Run as user for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.securityContext.runAsGroup | int | `0` | Run as group for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.securityContext.fsGroup | int | `0` | FS group for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.volumes | list | `[]` | Additional volumes for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.volumeMounts | list | `[]` | Volume mounts for AWS EBS CSI Driver node |
| awsEbsCsiDriver.node.containerSecurityContext.readOnlyRootFilesystem | bool | `true` | Read-only root filesystem for AWS EBS CSI Driver node container |
| awsEbsCsiDriver.node.containerSecurityContext.privileged | bool | `true` | Privileged for AWS EBS CSI Driver node container |
| awsEbsCsiDriver.node.otelTracing | object | `{}` | OpenTelemetry tracing for AWS EBS CSI Driver node |
| awsEbsCsiDriver.additionalDaemonSets | object | `{}` | Additional DaemonSets for AWS EBS CSI Driver node |
| awsEbsCsiDriver.storageClasses | list | `[]` | Storage classes for AWS EBS CSI Driver |
| awsEbsCsiDriver.volumeSnapshotClasses | list | `[]` | Volume snapshot classes for AWS EBS CSI Driver |
| awsEbsCsiDriver.useOldCSIDriver | bool | `false` | Use old CSI Driver for AWS EBS CSI Driver |
| awsEbsCsiDriver.helmTester.enabled | bool | `true` | Enable Helm tester for AWS EBS CSI Driver |
| awsEbsCsiDriver.helmTester.image | string | `"gcr.io/k8s-staging-test-infra/kubekins-e2e:v20240311-b09cdeb92c-master"` | Image for Helm tester |
| awsVpcCni.enabled | bool | `true` | Enable AWS VPC CNI |
| awsVpcCni.nameOverride | string | `"aws-node"` | Override for AWS VPC CNI name |
| awsVpcCni.init.image.tag | string | `"v1.18.1"` | Tag for AWS VPC CNI init image |
| awsVpcCni.init.image.domain | string | `"amazonaws.com"` | Domain for AWS VPC CNI init image |
| awsVpcCni.init.image.region | string | `"us-west-2"` | Region for AWS VPC CNI init image |
| awsVpcCni.init.image.endpoint | string | `"ecr"` | Endpoint for AWS VPC CNI init image |
| awsVpcCni.init.image.account | string | `"602401143452"` | Account for AWS VPC CNI init image |
| awsVpcCni.init.image.pullPolicy | string | `"Always"` | Pull policy for AWS VPC CNI init image |
| awsVpcCni.init.env.DISABLE_TCP_EARLY_DEMUX | string | `"false"` | Disable TCP early demux for AWS VPC CNI init container |
| awsVpcCni.init.env.ENABLE_IPv6 | string | `"false"` | Enable IPv6 for AWS VPC CNI init container |
| awsVpcCni.init.securityContext.privileged | bool | `true` | Privileged for AWS VPC CNI init container |
| awsVpcCni.init.resources | object | `{}` | Resources for AWS VPC CNI init container |
| awsVpcCni.nodeAgent.enabled | bool | `true` | Enable node agent for AWS VPC CNI |
| awsVpcCni.nodeAgent.image.tag | string | `"v1.1.1"` | Tag for AWS VPC CNI node agent image |
| awsVpcCni.nodeAgent.image.domain | string | `"amazonaws.com"` | Domain for AWS VPC CNI node agent image |
| awsVpcCni.nodeAgent.image.region | string | `"us-west-2"` | Region for AWS VPC CNI node agent image |
| awsVpcCni.nodeAgent.image.endpoint | string | `"ecr"` | Endpoint for AWS VPC CNI node agent image |
| awsVpcCni.nodeAgent.image.account | string | `"602401143452"` | Account for AWS VPC CNI node agent image |
| awsVpcCni.nodeAgent.image.pullPolicy | string | `"Always"` | Pull policy for AWS VPC CNI node agent image |
| awsVpcCni.nodeAgent.securityContext.capabilities.add | list | `["NET_ADMIN"]` | Capabilities for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.securityContext.privileged | bool | `true` | Privileged for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.enableCloudWatchLogs | string | `"false"` | Enable CloudWatch logs for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.enablePolicyEventLogs | string | `"false"` | Enable policy event logs for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.enableIpv6 | string | `"false"` | Enable IPv6 for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.metricsBindAddr | string | `"8162"` | Metrics bind address for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.healthProbeBindAddr | string | `"8163"` | Health probe bind address for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.conntrackCacheCleanupPeriod | int | `300` | Conntrack cache cleanup period for AWS VPC CNI node agent |
| awsVpcCni.nodeAgent.resources | object | `{}` | Resources for AWS VPC CNI node agent |
| awsVpcCni.image.tag | string | `"v1.18.1"` | Tag for AWS VPC CNI image |
| awsVpcCni.image.domain | string | `"amazonaws.com"` | Domain for AWS VPC CNI image |
| awsVpcCni.image.region | string | `"us-west-2"` | Region for AWS VPC CNI image |
| awsVpcCni.image.endpoint | string | `"ecr"` | Endpoint for AWS VPC CNI image |
| awsVpcCni.image.account | string | `"602401143452"` | Account for AWS VPC CNI image |
| awsVpcCni.image.pullPolicy | string | `"Always"` | Pull policy for AWS VPC CNI image |
| awsVpcCni.env.ADDITIONAL_ENI_TAGS | string | `"{}"` | Additional ENI tags for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_CNI_NODE_PORT_SUPPORT | string | `"true"` | Node port support for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_ENI_MTU | string | `"9001"` | ENI MTU for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG | string | `"true"` | Custom network config for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_CNI_EXTERNALSNAT | string | `"false"` | External SNAT for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_CNI_LOG_FILE | string | `"/host/var/log/aws-routed-eni/ipamd.log"` | Log file for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_CNI_LOGLEVEL | string | `"DEBUG"` | Log level for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_CNI_RANDOMIZESNAT | string | `"prng"` | Randomize SNAT for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_CNI_VETHPREFIX | string | `"eni"` | VETH prefix for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_PLUGIN_LOG_FILE | string | `"/var/log/aws-routed-eni/plugin.log"` | Plugin log file for AWS VPC CNI |
| awsVpcCni.env.AWS_VPC_K8S_PLUGIN_LOG_LEVEL | string | `"DEBUG"` | Plugin log level for AWS VPC CNI |
| awsVpcCni.env.DISABLE_INTROSPECTION | string | `"false"` | Disable introspection for AWS VPC CNI |
| awsVpcCni.env.DISABLE_METRICS | string | `"false"` | Disable metrics for AWS VPC CNI |
| awsVpcCni.env.ENABLE_POD_ENI | string | `"false"` | Enable pod ENI for AWS VPC CNI |
| awsVpcCni.env.ENABLE_PREFIX_DELEGATION | string | `"false"` | Enable prefix delegation for AWS VPC CNI |
| awsVpcCni.env.WARM_ENI_TARGET | string | `"1"` | Warm ENI target for AWS VPC CNI |
| awsVpcCni.env.WARM_PREFIX_TARGET | string | `"1"` | Warm prefix target for AWS VPC CNI |
| awsVpcCni.env.DISABLE_NETWORK_RESOURCE_PROVISIONING | string | `"false"` | Disable network resource provisioning for AWS VPC CNI |
| awsVpcCni.env.ENABLE_IPv4 | string | `"true"` | Enable IPv4 for AWS VPC CNI |
| awsVpcCni.env.ENABLE_IPv6 | string | `"false"` | Enable IPv6 for AWS VPC CNI |
| awsVpcCni.env.VPC_CNI_VERSION | string | `"v1.18.1"` | VPC CNI version |
| awsVpcCni.env.NETWORK_POLICY_ENFORCING_MODE | string | `"standard"` | Network policy enforcing mode |
| awsVpcCni.env.ENABLE_SUBNET_DISCOVERY | string | `"true"` | Enable subnet discovery |
| awsVpcCni.env.ENI_CONFIG_LABEL_DEF | string | `"topology.kubernetes.io/zone"` | ENI config label definition |
| awsVpcCni.originalMatchLabels | bool | `false` | Use original match labels for AWS VPC CNI |
| awsVpcCni.enableNetworkPolicy | string | `"false"` | Enable network policy for AWS VPC CNI |
| awsVpcCni.enableWindowsIpam | string | `"false"` | Enable Windows IPAM for AWS VPC CNI |
| awsVpcCni.enableWindowsPrefixDelegation | string | `"false"` | Enable Windows prefix delegation for AWS VPC CNI |
| awsVpcCni.warmWindowsPrefixTarget | int | `0` | Warm Windows prefix target for AWS VPC CNI |
| awsVpcCni.warmWindowsIPTarget | int | `1` | Warm Windows IP target for AWS VPC CNI |
| awsVpcCni.minimumWindowsIPTarget | int | `3` | Minimum Windows IP target for AWS VPC CNI |
| awsVpcCni.branchENICooldown | int | `60` | Branch ENI cooldown for AWS VPC CNI |
| awsVpcCni.cniConfig.enabled | bool | `false` | Enable CNI config for AWS VPC CNI |
| awsVpcCni.cniConfig.fileContents | string | `""` | File contents for CNI config |
| awsVpcCni.fullnameOverride | string | `"aws-node"` | Override for AWS VPC CNI fullname |
| awsVpcCni.priorityClassName | string | `"system-node-critical"` | Priority class name for AWS VPC CNI |
| awsVpcCni.podSecurityContext | object | `{}` | Pod security context for AWS VPC CNI |
| awsVpcCni.podAnnotations | object | `{}` | Annotations for AWS VPC CNI pods |
| awsVpcCni.podLabels | object | `{}` | Labels for AWS VPC CNI pods |
| awsVpcCni.securityContext.capabilities.add | list | `["NET_ADMIN","NET_RAW"]` | Capabilities for AWS VPC CNI |
| awsVpcCni.serviceAccount.create | bool | `true` | Create service account for AWS VPC CNI |
| awsVpcCni.serviceAccount.name | string | `""` | Name of the service account for AWS VPC CNI |
| awsVpcCni.serviceAccount.annotations | object | `{}` | Annotations for the service account |
| awsVpcCni.livenessProbe.exec.command | list | `["/app/grpc-health-probe","-addr=:50051","-connect-timeout=5s","-rpc-timeout=5s"]` | Command for liveness probe |
| awsVpcCni.livenessProbe.initialDelaySeconds | int | `60` | Initial delay for liveness probe |
| awsVpcCni.livenessProbeTimeoutSeconds | int | `10` | Timeout for liveness probe |
| awsVpcCni.readinessProbe.exec.command | list | `["/app/grpc-health-probe","-addr=:50051","-connect-timeout=5s","-rpc-timeout=5s"]` | Command for readiness probe |
| awsVpcCni.readinessProbe.initialDelaySeconds | int | `1` | Initial delay for readiness probe |
| awsVpcCni.readinessProbeTimeoutSeconds | int | `10` | Timeout for readiness probe |
| awsVpcCni.resources.requests.cpu | string | `"25m"` | CPU request for AWS VPC CNI |
| awsVpcCni.updateStrategy.type | string | `"RollingUpdate"` | Update strategy for AWS VPC CNI |
| awsVpcCni.updateStrategy.rollingUpdate.maxUnavailable | string | `"10%"` | Max unavailable for rolling update |
| awsVpcCni.nodeSelector | object | `{}` | Node selector for AWS VPC CNI |
| awsVpcCni.tolerations | list | `[{"operator":"Exists"}]` | Tolerations for AWS VPC CNI |
| awsVpcCni.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms | list | `[{"matchExpressions":[{"key":"kubernetes.io/os","operator":"In","values":["linux"]},{"key":"kubernetes.io/arch","operator":"In","values":["amd64","arm64"]},{"key":"eks.amazonaws.com/compute-type","operator":"NotIn","values":["fargate"]}]}]` | Node affinity for AWS VPC CNI |
| awsVpcCni.eniConfig.create | bool | `false` | Create ENI configs for AWS VPC CNI |
| awsVpcCni.eniConfig.region | string | `"us-west-2"` | Region for ENI config |
| awsVpcCni.eniConfig.subnets | object | `{}` | Subnets for ENI config |
| karpenter.nameOverride | string | `""` | Override for Karpenter name |
| karpenter.fullnameOverride | string | `""` | Override for Karpenter fullname |
| karpenter.additionalLabels | object | `{}` | Additional labels for Karpenter |
| karpenter.additionalAnnotations | object | `{}` | Additional annotations for Karpenter |
| karpenter.imagePullPolicy | string | `"IfNotPresent"` | Image pull policy for Karpenter |
| karpenter.imagePullSecrets | list | `[]` | Image pull secrets for Karpenter |
| karpenter.serviceAccount.create | bool | `true` | Create service account for Karpenter |
| karpenter.serviceAccount.name | string | `""` | Name of the service account for Karpenter |
| karpenter.serviceAccount.annotations | object | `{}` | Annotations for the service account |
| karpenter.additionalClusterRoleRules | list | `[]` | Additional cluster role rules for Karpenter |
| karpenter.serviceMonitor.enabled | bool | `false` | Enable ServiceMonitor for Karpenter |
| karpenter.serviceMonitor.additionalLabels | object | `{}` | Additional labels for ServiceMonitor |
| karpenter.serviceMonitor.endpointConfig | object | `{}` | Endpoint config for ServiceMonitor |
| karpenter.replicas | int | `2` | Replicas for Karpenter |
| karpenter.revisionHistoryLimit | int | `10` | Revision history limit for Karpenter |
| karpenter.strategy.rollingUpdate.maxUnavailable | int | `1` | Max unavailable for rolling update strategy |
| karpenter.podLabels | object | `{}` | Labels for Karpenter pods |
| karpenter.podAnnotations | object | `{}` | Annotations for Karpenter pods |
| karpenter.podDisruptionBudget.name | string | `"karpenter"` | Name of the pod disruption budget for Karpenter |
| karpenter.podDisruptionBudget.maxUnavailable | int | `1` | Max unavailable for pod disruption budget |
| karpenter.podSecurityContext.fsGroup | int | `65532` | FS group for Karpenter pods |
| karpenter.priorityClassName | string | `"system-cluster-critical"` | Priority class name for Karpenter |
| karpenter.terminationGracePeriodSeconds | int | `""` | Termination grace period for Karpenter pods |
| karpenter.hostNetwork | bool | `false` | Use host network for Karpenter |
| karpenter.dnsPolicy | string | `"ClusterFirst"` | DNS policy for Karpenter |
| karpenter.dnsConfig | object | `{}` | DNS config for Karpenter |
| karpenter.nodeSelector | object | `{}` | Node selector for Karpenter |
| karpenter.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms | list | `[{"matchExpressions":[{"key":"karpenter.sh/nodepool","operator":"DoesNotExist"}]}]` | Node affinity for Karpenter |
| karpenter.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution | list | `[{"topologyKey":"kubernetes.io/hostname"}]` | Pod anti-affinity for Karpenter |
| karpenter.topologySpreadConstraints | list | `[{"maxSkew":1,"topologyKey":"topology.kubernetes.io/zone","whenUnsatisfiable":"ScheduleAnyway"}]` | Topology spread constraints for Karpenter |
| karpenter.tolerations | list | `[{"key":"CriticalAddonsOnly","operator":"Exists"}]` | Tolerations for Karpenter |
| karpenter.extraVolumes | list | `[]` | Extra volumes for Karpenter |
| karpenter.controller.image.repository | string | `"public.ecr.aws/karpenter/controller"` | Repository for Karpenter controller image |
| karpenter.controller.image.tag | string | `"0.36.0"` | Tag for Karpenter controller image |
| karpenter.controller.image.digest | string | `"sha256:90adaba9e8e9f66244324ca64408a5abbfe063f8c41fbbfebf226bdda4fadd58"` | Digest for Karpenter controller image |
| karpenter.controller.env | list | `[]` | Environment variables for Karpenter controller |
| karpenter.controller.envFrom | list | `[]` | Environment variables from sources for Karpenter controller |
| karpenter.controller.resources | object | `{}` | Resources for Karpenter controller |
| karpenter.controller.extraVolumeMounts | list | `[]` | Extra volume mounts for Karpenter controller |
| karpenter.controller.sidecarContainer | list | `[]` | Sidecar containers for Karpenter controller |
| karpenter.controller.sidecarVolumeMounts | list | `[]` | Sidecar volume mounts for Karpenter controller |
| karpenter.controller.metrics.port | int | `8000` | Metrics port for Karpenter controller |
| karpenter.controller.healthProbe.port | int | `8081` | Health probe port for Karpenter controller |
| karpenter.webhook.enabled | bool | `false` | Enable webhooks for Karpenter |
| karpenter.webhook.port | int | `8443` | Webhook port for Karpenter |
| karpenter.webhook.metrics.port | int | `8001` | Webhook metrics port for Karpenter |
| karpenter.logLevel | string | `"info"` | Log level for Karpenter |
| karpenter.logConfig.enabled | bool | `false` | Enable log config for Karpenter |
| karpenter.logConfig.outputPaths | list | `["stdout"]` | Output paths for Karpenter log config |
| karpenter.logConfig.errorOutputPaths | list | `["stderr"]` | Error output paths for Karpenter log config |
| karpenter.logConfig.logEncoding | string | `"json"` | Log encoding for Karpenter log config |
| karpenter.logConfig.logLevel.global | string | `"info"` | Global log level for Karpenter log config |
| karpenter.logConfig.logLevel.controller | string | `"info"` | Controller log level for Karpenter log config |
| karpenter.logConfig.logLevel.webhook | string | `"error"` | Webhook log level for Karpenter log config |
| karpenter.settings.batchMaxDuration | string | `"10s"` | Batch max duration for Karpenter |
| karpenter.settings.batchIdleDuration | string | `"1s"` | Batch idle duration for Karpenter |
| karpenter.settings.assumeRoleARN | string | `""` | Assume role ARN for Karpenter |
| karpenter.settings.assumeRoleDuration | string | `"15m"` | Assume role duration for Karpenter |
| karpenter.settings.clusterCABundle | string | `""` | Cluster CA bundle for Karpenter |
| karpenter.settings.clusterName | string | `""` | Cluster name for Karpenter |
| karpenter.settings.clusterEndpoint | string | `""` | Cluster endpoint for Karpenter |
| karpenter.settings.isolatedVPC | bool | `false` | Isolated VPC for Karpenter |
| karpenter.settings.vmMemoryOverheadPercent | float | `0.075` | VM memory overhead percent for Karpenter |
| karpenter.settings.interruptionQueue | string | `""` | Interruption queue for Karpenter |
| karpenter.settings.reservedENIs | string | `"0"` | Reserved ENIs for Karpenter |
| karpenter.settings.featureGates.drift | bool | `true` | Enable drift feature gate for Karpenter |
| karpenter.settings.featureGates.spotToSpotConsolidation | bool | `false` | Enable spot to spot consolidation feature gate for Karpenter |


Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)