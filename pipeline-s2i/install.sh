#!/bin/bash

oc apply -f fix/
oc create -f apps/
oc create -f conf/
oc create -f tasks/
oc create -f pipelines/
oc create -f triggers/
# oc create -f pipelinerun/