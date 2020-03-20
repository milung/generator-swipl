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

## Details

The project structure is based on common recommendations of structuring the prolog project.
Typically you do not need to touch files in the root directory, rather place your modules into
the `sources` directory. The generated skeletons come with simple _hello-world_ http server and
command line interface, as well as with docker file for encapsulating the program into container.

Durring debugging session you can load `[debug].` source into you top level session,
which enables various debugging features.

For starting the server you execute `swipl start.pl`. The handlers are placed into module `sources/routing.pl`.

The command line version can be executed by `swipl run.pl <args...>`. This invokes `main/1`, which is placed
into module `sources/main.pl`.

The docker image is optimized, based on the saved state of your program. If run without arguments,
it invokes the http server, any arguments passed to `docker run your-swipl-image` will lead to
invokation of command line interface.

## Next steps

Created based on my needs, new features may come, but not guaranteed.