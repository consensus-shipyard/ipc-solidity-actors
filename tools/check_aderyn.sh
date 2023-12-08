#!/usr/bin/env bash

count=`(grep -e "Critical\s*|\s*0" ./report.md && grep -e  "High\s*|\s*0" ./report.md) | wc -l`

if [ $count -eq 2 ]; then
    echo "No critical or high issues found"
    exit 0
else
    echo "Critical or high issue found"
    exit 1;
fi
