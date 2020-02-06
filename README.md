# Tekton Pipeline Examples


## Pre-requisites
* [OpenShift 4 cluster](http://cloud.redhat.com)
* [Tekton CLI](https://github.com/tektoncd/cli/releases/latest)

# PetClinic Pipeline Demo

```
oc new-project pipelines-demo
oc apply -f pipelines/petclinic-all.yml
tkn pipeline start petclinic-deployment-pipeline

$ oc get route el-webhook
# Fork spring-petclinic GitHub repository and add a json webhook
```