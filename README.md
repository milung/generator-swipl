# SWIPL Prolog program generators for Yeoman

Collection of simple generators for SWIPL projects

## Usage

* Install [Yeoman](https://yeoman.io/learning/index.html)

  ```sh
  npm install -g yo
  ```

* Install SWIPL generator
  
  ```sh
  npm install -g generator-swipl
  ```

* Create your project folders and navigate there in your terminal
* Scaffold project structure

  ```sh
  yo swipl
  ```

Later you can use module generator to add additional modules to your project

```sh
you swipl:module some_module
```

This will create new prolog module in the current director - unless you are in
the root directory, in the such case it creates the module in `sources` directory -
and updates the `load.pl` accordingly.

## Generators

### yo swipl

The project structure is based on common recommendations of structuring the prolog project.
Typically you do not need to touch files in the root directory, rather place your modules into
the `sources` directory. The generated skeletons come with simple _hello-world_ http server and
command line interface, as well as with Dockerfile for encapsulating the program into container.

Durring debugging session you can load `[debug].` source into you top level session,
which enables various debugging features.

For starting the server you execute `swipl start.pl`. The handlers are placed into module `sources/routing.pl`.

The command line version can be executed by `swipl run.pl <args...>`. This invokes `main/4`, which is placed
into module `sources/main.pl`. The `main/4` gets already arguments processed by `opt_parse` and Input and Output stream
that refers to either `user_input` and `user_output` or to streams controlled by CLI's `--input` and `--output` options.
Additional options to `opt_parse`'s OptionSPec can be added by usage of multifile hook `cli_option/4` - see `run.pl` for
declaration. The `--help` option is automatically processed and prints the program's usage.

The docker image is optimized, based on the saved state of your program. If run without arguments,
it invokes the http server, any arguments passed to `docker run your-swipl-image` will lead to
invokation of command line interface.

The project allows for simple package management, specify external packages in the `packages.pl`. They will be
automatically installed into `.packages` folder and attached to the library search.

## yo swipl:package

Generates minimal swipl package structure with basic testing and debuging support

## yo swipl:module

Generates new prolog  module file with corresponding prolog unit tests file and registers it into `load.pl` script.
## Next steps

Created based on my needs, new features may come, but not guaranteed.