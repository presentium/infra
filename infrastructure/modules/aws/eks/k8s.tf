resource "kubernetes_storage_class_v1" "ebs" {
  metadata {
    name = "ebs"
  }
  storage_provisioner = "ebs.csi.aws.com"
  reclaim_policy      = "Retain"
  volume_binding_mode = "WaitForFirstConsumer"
  parameters = {
    tagSpecification1 = "Managed_by=aws-ebs-csi-driver"
  }
}
