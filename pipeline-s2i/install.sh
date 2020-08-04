#!/bin/bash

oc create -f apps/
oc apply -f conf/
oc create -f tasks/
oc create -f pipelines/
oc create -f pipelinerun/