# Tekton Pipeline Examples


## Pre-requisites
* [OpenShift 4 cluster](http://cloud.redhat.com)
* [Tekton CLI](https://github.com/tektoncd/cli/releases/latest)

## Prepare Project

```
oc new-project pipeline-demo

# create service account

oc create serviceaccount pipeline
oc adm policy add-scc-to-user privileged -z pipeline
oc adm policy add-role-to-user edit -z pipeline

# create pipline tasks and resources

oc create -f tasks
oc create -f https://raw.githubusercontent.com/tektoncd/catalog/master/buildah/buildah.yaml
oc create -f https://raw.githubusercontent.com/tektoncd/catalog/master/openshift-client/openshift-client-task.yaml
oc create -f pipelines/mapit-resources.yml
```

## MapIt Build Pipeline

<img align="center" width="600" src="images/mapit-build-pipeline.png">

```
oc create -f pipelines/build-pipeline.yml
tkn pipeline start build-pipeline -s pipeline
```

## MapIt Deploy Pipeline

<img align="center" width="700" src="images/mapit-deploy-pipeline.png">

```
# deploy mapit
oc apply -f apps/mapit-spring.yml

# create pipeline
oc create -f pipelines/deploy-pipeline.yml
tkn pipeline start deploy-pipeline -s pipeline
```

# PetClinic Demo

```
oc create -f http://bit.ly/pipelines-demo
oc project pipelines-demo
tkn pipeline start petclinic-s2i-pipeline -s pipeline
```