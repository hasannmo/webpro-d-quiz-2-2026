#!/usr/bin/env bash
# Maven Wrapper helper for Mijusan Store
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
"$DIR/.maven/bin/mvn" -Dmaven.repo.local="$DIR/.m2/repository" "$@"
