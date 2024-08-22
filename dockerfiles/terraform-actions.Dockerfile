ARG BASE_VERSION="latest"
FROM danielflook/terraform-github-actions:$BASE_VERSION

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash -s /usr/local/bin
RUN curl -s "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3" | bash
RUN curl "https://releases.hashicorp.com/vault/1.17.3/vault_1.17.3_linux_amd64.zip" -o "vault.zip" && \
    unzip vault.zip && install -o root -g root -m 0755 vault /usr/local/bin/vault
