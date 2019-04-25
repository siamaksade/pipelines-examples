# Tekton Pipeline Examples


## Prepare Project

```
oc new-project pipeline-demo

oc create serviceaccount pipeline
oc adm policy add-scc-to-user privileged -z pipeline
oc adm policy add-role-to-user edit -z pipeline

oc create -f tasks
oc create -f pipeline/mapit-resources.yml
```

## MapIt Build Pipeline

![](images/mapit-build-pipeline.png)

```
oc create -f pipeline/mapit-build-pipeline.yml
oc create -f pipeline/mapit-build-pipeline-run.yml
```

## MapIt Deploy Pipeline

![](images/mapit-deploy-pipeline.png)

```
# deploy app
oc create -f apps/mapit-spring.yml

# create pipeline
oc create -f pipeline/mapit-deploy-pipeline.yml
oc create -f pipeline/mapit-deploy-pipeline-run.yml
```