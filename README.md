## About this project

This project is a script installer related to [GoBase project](https://github.com/lucasnv/gobase) Which give you the opportunity to start a GoLang app from scratch in seconds.

## How to use?

The easiest way is first of all download the script and then run it in your terminal.

You can follow the two commands described below:

```shell
$  wget https://raw.githubusercontent.com/lucasnv/gobase-installer/master/install-go-base-project.sh
```

```shell
$  ./install-go-base-project.sh [MODULE PATH] [DOCKER CONTAINER NAME] [FOLDER PROJECT NAME]
```

### What does it means each parameter?

- **MODULE PATH:** It is the name of your GoLang module, in the most of the cases is something like **github.com/orgnanization/project-name**

- **DOCKER CONTAINER NAME:** It is the name of your docker container, take into account the name must be unique in your environment.

- **FOLDER PROJECT NAME:** It is the location of your project in your local environment.

TODO:

- Change the owner files of go.mod and go.sum
- I have the problem when I work locally the editors can find the information libs that I need to import, because dont use the golan version installed in the container.
