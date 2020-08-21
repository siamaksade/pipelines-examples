#!/bin/bash

cat <<EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: pipelines
  namespace: openshift-operators
spec:
  channel: preview
  name: openshift-pipelines-operator-rh
  source: redhat-operators
  sourceNamespace: openshift-marketplace
EOF

oc new-project argocd

sleep 2

cat <<EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: argocd-operator
  namespace: argocd
spec:
  channel: alpha
  name: argocd-operator
  source: community-operators
  sourceNamespace: openshift-marketplace
EOF

oc rollout status deployment/argocd-operator -n argocd

cat <<EOF | oc apply -f -
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
  namespace: argocd
spec:
  server:
    route:
      enabled: true
  dex:
    openShiftOAuth: true
EOF

oc rollout status deployment/argocd-server -n argocd


