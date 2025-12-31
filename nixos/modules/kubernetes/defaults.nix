{ config
, pkgs
, ...
}:
let
  kubeMasterIP = "10.1.1.2";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
  api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
in
{
  # Packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  # Kubernetes services configuration
  services.kubernetes = {
    roles = [ "node" ];
    masterAddress = kubeMasterHostname;
    easyCerts = true;

    # Point kubelet and other services to kube-apiserver
    kubelet.kubeconfig.server = api;
    apiserverAddress = api;

    # Use CoreDNS
    addons.dns.enable = true;

    # Needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false";
  };
}
