#!/bin/bash

project_name=${1:demo}

oc new-project $project_name-stage
oc new-project $project_name-dev

# deploy app in dev
oc create -f https://raw.githubusercontent.com/siamaksade/spring-petclinic-config/dev/deployment.yaml -n $project_name-dev
oc create -f https://raw.githubusercontent.com/siamaksade/spring-petclinic-config/dev/service.yaml -n $project_name-dev
oc create -f https://raw.githubusercontent.com/siamaksade/spring-petclinic-config/dev/route.yaml -n $project_name-dev

oc apply -f fix/
oc create -f conf/ -n $project_name-dev
oc create -f tasks/ -n $project_name-dev
oc create -f pipelines/ -n $project_name-dev
oc create -f triggers/ -n $project_name-dev
# oc create -f pipelinerun/

# deploy argocd

oc new-project argocd
oc create -f argo/argocd.yaml -n argocd

sleep 10

oc rollout status deployment/argocd-server -n argocd
# oc create -f argo/spring-petclinic-application.yaml
oc policy add-role-to-user edit system:serviceaccount:argocd:argocd-application-controller -n $project_name-stage
oc policy add-role-to-user edit system:serviceaccount:argocd:argocd-application-controller -n $project_name-dev
argocd_pwd=$(oc get secret argocd-cluster -n argocd -o jsonpath='{.data.admin\.password}' | base64 -d)
argocd_url=$(oc get route argocd-server -n argocd -o template --template='{{.spec.host}}')

argocd login $argocd_url --username admin --password $argocd_pwd
argocd app create spring-petclinic-stage --repo https://github.com/siamaksade/spring-petclinic-config --path . --dest-namespace $project_name-stage --dest-server https://kubernetes.default.svc --directory-recurse --revision stage
