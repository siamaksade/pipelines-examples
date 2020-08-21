#!/bin/bash

project_name=${1:-demo}
project_suffix=("ui" "qa" "perf")

# deploy app in dev
oc new-project $project_name-dev
oc create -f https://raw.githubusercontent.com/siamaksade/spring-petclinic-config/dev/deployment.yaml -n $project_name-dev
oc create -f https://raw.githubusercontent.com/siamaksade/spring-petclinic-config/dev/service.yaml -n $project_name-dev
oc create -f https://raw.githubusercontent.com/siamaksade/spring-petclinic-config/dev/route.yaml -n $project_name-dev

oc apply -f fix/
oc create -f conf/ -n $project_name-dev
oc create -f tasks/ -n $project_name-dev
oc create -f pipelines/ -n $project_name-dev
oc create -f triggers/ -n $project_name-dev
# oc create -f pipelinerun/

# configure argocd
argocd_pwd=$(oc get secret argocd-cluster -n argocd -o jsonpath='{.data.admin\.password}' | base64 -d)
argocd_url=$(oc get route argocd-server -n argocd -o template --template='{{.spec.host}}')
argocd login $argocd_url --username admin --password $argocd_pwd --insecure

for suffix in $project_suffix; 
do
  oc new-project $project_name-$suffix; 
  oc policy add-role-to-user edit system:serviceaccount:argocd:argocd-application-controller -n $project_name-$suffix
  argocd app create spring-petclinic-$suffix --repo https://github.com/siamaksade/spring-petclinic-config --path . --dest-namespace $project_name-$suffix --dest-server https://kubernetes.default.svc --directory-recurse --revision stage
  argocd app sync spring-petclinic-$suffix
done 


echo "\n\nArgoCD URL: $argocd_url\nUser: admin\nPassword: $argocd_pwd"