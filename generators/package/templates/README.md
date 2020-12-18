# <%=packageTitle%>

Prolog module `<%=packageName%>`

## USAGE

Use module `<%=packageName%>` 

Example: 

```prolog
:- use_module(library(`<%=packageName%>`)).

hallo :-
    % do something.
```

## Details

 
## Exported predicates

### `predicate(+Name:atom, +Type, +Options:list)` is det.

Succedds if ....

Options can be one of:

* `long(Long)` - specifies the long name of ....
   
* `short(Short)` - specifies the short ....
*
* `default(Value)` - Specifies the default values ...

### `predicate_2(+Variable, -Value)` is semidet

Unifies Value with ...


## Testing

The script `run-tests.ps1` executes the tests

## Development

To debug the module, load the `debug.pl` file into prolog top.