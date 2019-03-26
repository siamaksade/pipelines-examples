# Tekton Pipeline Examples




## MapIt Pipeline

![](images/mapit-pipeline.png)

```
kubectl create -f tasks
kubectl create -f pipelines/mapit-pipeline.yml
kubectl create -f pipelines/mapit-pipeline-run.yml
```

