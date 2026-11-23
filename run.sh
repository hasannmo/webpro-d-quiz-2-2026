#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "==> Building web application..."
"$DIR/mvnw" -DskipTests package

echo "==> Deploying to local Tomcat..."
rm -rf "$DIR/.tomcat/webapps/ROOT" "$DIR/.tomcat/webapps/ROOT.war"
cp "$DIR/target/ROOT.war" "$DIR/.tomcat/webapps/ROOT.war"

echo "==> Starting Tomcat on http://localhost:8080 ..."
echo "==> Press Ctrl+C to stop the server."
export CATALINA_BASE="$DIR/.tomcat"
export CATALINA_HOME="$DIR/.tomcat"
"$DIR/.tomcat/bin/catalina.sh" run
