# Autogenerated wrapper script for Tk_jll for arm-linux-gnueabihf
export libtk, wish

using Tcl_jll
using Xorg_libXft_jll
## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `libtk`
const libtk_splitpath = ["lib", "libtk8.6.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libtk_path = ""

# libtk-specific global declaration
# This will be filled out by __init__()
libtk_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libtk = "libtk8.6.so"


# Relative path to `wish`
const wish_splitpath = ["bin", "wish8.6"]

# This will be filled out by __init__() for all products, as it must be done at runtime
wish_path = ""

# wish-specific global declaration
function wish(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', ENV[LIBPATH_env])
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(wish_path)
    end
end


"""
Open all libraries
"""
function __init__()
    global prefix = abspath(joinpath(@__DIR__, ".."))

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    append!.(Ref(PATH_list), (Tcl_jll.PATH_list, Xorg_libXft_jll.PATH_list,))
    append!.(Ref(LIBPATH_list), (Tcl_jll.LIBPATH_list, Xorg_libXft_jll.LIBPATH_list,))

    global libtk_path = abspath(joinpath(artifact"Tk", libtk_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libtk_handle = dlopen(libtk_path)
    push!(LIBPATH_list, dirname(libtk_path))

    global wish_path = abspath(joinpath(artifact"Tk", wish_splitpath...))

    push!(PATH_list, dirname(wish_path))
    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

