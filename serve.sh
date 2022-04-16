#!/bin/sh

MODE=$1; shift;
SAGE_ENDPOINT=$1
SAGE_WEB_HOME=$(realpath .)
SAGE_CLIENT_HOME="$SAGE_WEB_HOME/submodules/sage-client"

node_purge(){
    rm -rf node_modules yarn.lock;
}

yarn_install(){
    yarn install --check-files;
}

clean_after(){
    #echo 'Pruning sparql-engine...' && cd "$SAGE_CLIENT_HOME/submodules/sparql-engine" && node_purge
    #echo 'Pruning sage-client...' && cd "$SAGE_CLIENT_HOME" && node_purge
    echo 'Pruning sage-widget...' && cd "$SAGE_WEB_HOME/submodules/sage-widget" && node_purge
    #node-prune
    yarn cache clean --all
}

if [ "$MODE" = "serve" ]; then
    echo "Recompiling sage-web..."
    rm -rf build/
    mkdir -p build build/see
    npm run cli compile $SAGE_ENDPOINT && npm run cli serve $SAGE_ENDPOINT
elif [ "$MODE" = "clean" ]; then
    echo "Clean up residues..."
    #echo 'Cleaning sparql-engine...' && cd "$SAGE_CLIENT_HOME/submodules/sparql-engine" && node_purge
    #echo 'Cleaning sage-client...' && cd "$SAGE_CLIENT_HOME" && node_purge
    echo 'Cleaning sage-widget...' && cd "$SAGE_WEB_HOME/submodules/sage-widget" && node_purge
    echo 'Cleaning sage-web...' && cd "$SAGE_WEB_HOME" && node_purge
else
    #echo 'Setting up...' && cd "$SAGE_WEB_HOME" && yarn install && \
    #echo 'Rebuilding sparql-engine...' && cd "$SAGE_CLIENT_HOME/submodules/sparql-engine" && yarn_install && npm run lint && npm run build && \
    #echo 'Rebuilding sage-client...' && cd "$SAGE_CLIENT_HOME" && yarn_install && npm run lint && npm run build-ts && npm run build && \
    echo 'Rebuilding sage-widget...' && cd "$SAGE_WEB_HOME/submodules/sage-widget" && yarn_install && npm run lint && npm run build && \
    echo 'Rebuilding sage-web...' && cd "$SAGE_WEB_HOME" && yarn_install && \
    clean_after
fi