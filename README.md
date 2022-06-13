# PatentClassifications

At the moment, this package only allows you to obtain titles for CPC classification codes:

```julia
using PatentClassifications
load_cpc()
gettitle("A61K")
```

In the future, other features such as traversals of the classification hierarchy and a type system might be added.

The necessary data are automatically downloaded from the [CPC website](https://www.cooperativepatentclassification.org/cpcSchemeAndDefinitions/bulk) via [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl).
