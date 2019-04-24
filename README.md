# Tekton Pipeline Examples




## MapIt Pipeline

![](images/mapit-pipeline.png)

```
oc new-project demo
oc adm policy add-scc-to-user privileged -z builder 

oc create -f tasks

oc create -f pipeline/mapit-resources.yml
oc create -f pipeline/mapit-build-pipeline.yml
oc create -f pipeline/mapit-build-pipeline.yml
```

