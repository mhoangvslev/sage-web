# sage-web
[![Build Status](https://travis-ci.com/sage-org/sage-web.svg?branch=master)](https://travis-ci.com/sage-org/sage-web)

Generate an interactive Web interface for a SaGe SPARQL query server, similar to the one available at [http://sage.univ-nantes.fr](http://sage.univ-nantes.fr).

# Installation

**Requirements**: [Node.js](https://nodejs.org/en/) v8.11 or higher

```bash
npm install -g sage-web
```

# Usage

Use the `sage-web` CLI program to generate an interactive website for a SaGe server. 
It is divided into *two subcommands*, which both takes as first arguments the URL of the SaGe server.
* The `sage-web serve <url> -p <port>` command start the website using a local HTTP server on the given port.
* The `sage-web compile <url> -o <output>` command compile the website as static HTML into the output directory.

Additionnaly, the `save-web help <cmd>` command can be used to display the help for the subcommand `cmd`.

For example, `sage-web serve http://soyez-sage.univ-nantes.fr -p 8000` launch an interactive website, similar to the one available at [http://sage.univ-nantes.fr](http://sage.univ-nantes.fr), which can be accessed at [http://localhost:800](http://localhost:800).

## Help for `sage-web`
```
Usage: sage-web [options] [command]

Options:
  -V, --version  output the version number
  -h, --help     output usage information

Commands:
  serve <url>    Start a Web server to serve the SaGe interactive website
  compile <url>  Compile the SaGe interactive website as a static HTML website
  help [cmd]     Display help for [cmd]
```
## Help for `sage-web serve`
```
Usage: sage-web serve <url>

Start a Web server to serve the SaGe interactive website

Options:
  -p, --port <port>  Port on which the server should listen (default: 3000)
  -h, --help         Output usage information
```
## Help for `sage-web compile`
```
Usage: sage-web compile <url>

Compile the SaGe interactive website as static HTML

Options:
  -o, --output <output>  Output directory (default: "./build")
  -h, --help             Output usage information
```

# Manual Installation

**Requirements**:
* [Node.js](https://nodejs.org/en/) v8.11 or higher
* [yarn](https://yarnpkg.com/) v1.21 or higher

```bash
git clone --recurse-submodules https://github.com/sage-org/sage-web.git
cd sage-web
npm run rebuild
npm run serve <sage-endpoint>
```
# Docker
1. Add services in your `docker-compose.yml`:
```yaml
sage-engine:
    container_name: sage-engine
    image: callidon/sage:web
    ports:
      - '8080:8080'
    volumes:
      - '${SAGE_GRAPHS}:/root/sage-engine/graphs'
    entrypoint: 'poetry run sage graphs/sage.yaml --workers=1 --port=8080'

sage-web:
    container_name: sage-web
    depends_on:
        - sage-engine
    build:
        dockerfile: Dockerfile
        context: ./submodules/sage-web/
    # image: minhhoangdang/sage-web:amd64
    network_mode: "host"
    entrypoint: '/bin/sh -c "npm run serve http://localhost:8080/"'
```

2. Deploy 
```bash
SAGE_GRAPHS=path/to/hdt docker-compose up sage-web
```