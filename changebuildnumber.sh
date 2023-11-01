#!/bin/bash
sed "s/buildNumber/$1/g" task.json > task-new.json
