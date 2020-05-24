# GT Spotter
Spotter is the moldable search interface

## How to load

The ideal way to load the code is by loading the entire [Glamorous Toolkit project](https://github.com/feenkcom/gtoolkit).


## Programming Spotter

### Creating a new instance of a default Spotter

```smalltalk
spotter := GtSpotter new.
```

### Spotter instance on a domain object

```smalltalk
spotter := GtSpotter on: MyObject new.
```

### Spotter UI

With preview support:
```smalltalk
spotterElement := GtSpotterElementWithPreview new.
spotterElement spotterModel: spotter
```

Without preview support:
```smalltalk
spotterElement := GtSpotterElement new.
spotterElement spotterModel: spotter
```

### Opening in a borderless window

```smalltalk
space := BlSpace new.
space root: spotterElement.
space borderless: true.
space show
```
