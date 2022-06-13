module PatentClassifications

using Dictionaries
using DataDeps
using CSV
using ZipFile

export gettitle, load_cpc

# abstract type PatentClassification end

const GLOBAL_CLASSIFICATION = Ref{Dictionary}()

include("CPC.jl")

function __init__()
    __init__cpc()
end

end