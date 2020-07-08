# <%=applicationName%>

<%=applicationName%> server and CLI

## USAGE

### Docker image

In powershell navigate to the folder where you have placed your source files and execute:

```bash
docker run --rm -it -v ${PWD}:/app/workdir <%=registry%>/<%=commandName%> -- -i <Input File> -o <Output File>
```

Eventually you can use `<%=commandName%>.ps1` script stored in this folder (assuming it is on your search path).

```bash
<%=commandName%> -i <Input File> -o <Output File>
```

### SWI Prolog

Alternatively you may install [SWI Prolog](https://www.swi-prolog.org/) to your environment and then execute

```bash
swipl run.pl -- -i <Input File Path> -o <Output File Path>
```

## More details
