ARG ARGOCD_VERSION="v2.11.7"
FROM quay.io/argoproj/argocd:$ARGOCD_VERSION

ARG SOPS_VERSION=3.9.0
ARG HELM_SECRETS_VERSION=4.6.0
ARG KUBECTL_VERSION=1.30.3

# vals or sops
ENV HELM_SECRETS_BACKEND="sops" \
    HELM_SECRETS_HELM_PATH=/usr/local/bin/helm \
    HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/" \
    HELM_SECRETS_VALUES_ALLOW_SYMLINKS=false \
    HELM_SECRETS_VALUES_ALLOW_ABSOLUTE_PATH=false \
    HELM_SECRETS_VALUES_ALLOW_PATH_TRAVERSAL=false \
    HELM_SECRETS_WRAPPER_ENABLED=false \
    HELM_PLUGINS=/gitops-tools/helm-plugins/ \
    HELM_SECRETS_CURL_PATH=/gitops-tools/curl \
    HELM_SECRETS_SOPS_PATH=/gitops-tools/sops \
    HELM_SECRETS_KUBECTL_PATH=/gitops-tools/kubectl \
    PATH="$PATH:/gitops-tools"

USER root

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /gitops-tools/helm-plugins

RUN \
    GO_ARCH=$(uname -m | sed -e 's/x86_64/amd64/') && \
    wget -qO "/gitops-tools/curl" "https://github.com/moparisthebest/static-curl/releases/latest/download/curl-${GO_ARCH}" && \
    true

RUN \
    GO_ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/') && \
    wget -qO "/gitops-tools/kubectl" "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${GO_ARCH}/kubectl" && \
    true

RUN \
    GO_ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/') && \
    wget -qO "/gitops-tools/sops" "https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.${GO_ARCH}" && \
    true

RUN \
    wget -qO- "https://github.com/jkroepke/helm-secrets/releases/download/v${HELM_SECRETS_VERSION}/helm-secrets.tar.gz" | tar -C /gitops-tools/helm-plugins -xzf- && \
    true

RUN chmod +x /gitops-tools/* && ln -sf /gitops-tools/helm-plugins/helm-secrets/scripts/wrapper/helm.sh /usr/local/sbin/helm

USER argocd
