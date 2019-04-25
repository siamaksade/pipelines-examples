# Tekton Pipeline Examples


## Prepare Project

```
oc new-project pipeline-demo

# create service account

oc create serviceaccount pipeline
oc adm policy add-scc-to-user privileged -z pipeline
oc adm policy add-role-to-user edit -z pipeline

# create pipline tasks and resources

oc create -f tasks
oc create -f pipelines/mapit-resources.yml
```

## MapIt Build Pipeline

<img align="center" width="600" src="images/mapit-build-pipeline.png">

```
oc create -f pipelines/mapit-build-pipeline.yml
oc create -f pipelines/mapit-build-pipeline-run.yml
```

## MapIt Deploy Pipeline

<img align="center" width="700" src="images/mapit-deploy-pipeline.png">

```
# deploy mapit
oc apply -f apps/mapit-spring.yml

# create pipeline
oc create -f pipelines/mapit-deploy-pipeline.yml
oc create -f pipelines/mapit-deploy-pipeline-run.yml
```