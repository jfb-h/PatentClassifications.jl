struct CPC end

const CPC_REF = Ref{Dictionary}()

gettitle(code) = GLOBAL_CLASSIFICATION[][code]
gettitle(code, ::CPC) = CPC_REF[][code]


const CPC_DEPNAME = "CPC"
const CPC_LINK = "https://www.cooperativepatentclassification.org/sites/default/files/cpc/bulk/"
const CPC_DATA = "CPCTitleList202205.zip"

function __init__cpc()
    dep = DataDeps.DataDep(
        CPC_DEPNAME,
        """
        Dataset: Cooperative Patent Classification (CPC) titles
        Website: $CPC_LINK
        """,
        CPC_LINK * CPC_DATA,
        "4b4922a477c4b4276164adbd822fa5e08368616e8b851f6aa8ce656fa6fc8196"
    )
    DataDeps.register(dep)
end

function _unzip_and_read(file)
    r = ZipFile.Reader(file)
    csv = CSV.File(read.(r.files), header=[:code, :level, :title], quoted=false)
    close(r)
    return csv
end

_make_dict(csv) = Dictionary(csv.code, csv.title)

function load_cpc(setglobal=true)
    file = DataDeps.@datadep_str CPC_DEPNAME * "/" * CPC_DATA
    csv  = _unzip_and_read(file)
    dict = _make_dict(csv)
    CPC_REF[] = dict
    if setglobal 
        GLOBAL_CLASSIFICATION[] = dict
    end
    return nothing
end

precompile(load_cpc, (Nothing,))

