function run_config_env_value(env_names)
    for env_name in env_names
        value = strip(get(ENV, env_name, ""))
        isempty(value) || return value
    end
    return ""
end

function resolve_run_config_path(case_dir::AbstractString; env_names=("DOGFISH_RUN_CONFIG",))
    raw_path = run_config_env_value(env_names)
    isempty(raw_path) && return nothing
    return isabspath(raw_path) ? raw_path : normpath(joinpath(case_dir, raw_path))
end

function load_run_config(case_dir::AbstractString; env_names=("DOGFISH_RUN_CONFIG",))
    path = resolve_run_config_path(case_dir; env_names)
    path === nothing && return (path=nothing, data=Dict{String, Any}())
    isfile(path) || error("run config file does not exist: $path")
    data = TOML.parsefile(path)
    return (path=path, data=data)
end

function run_config_section(run_config, section::AbstractString)
    haskey(run_config.data, section) || return Dict{String, Any}()
    value = run_config.data[section]
    value isa AbstractDict || error("run config section [$section] must be a table")
    return Dict{String, Any}(String(key) => item for (key, item) in value)
end

function merged_run_config_sections(run_config, sections)
    merged = Dict{String, Any}()
    for section in sections
        for (key, value) in run_config_section(run_config, String(section))
            merged[key] = value
        end
    end
    return merged
end

function run_config_env_present(env_name::String)
    return !isempty(strip(get(ENV, env_name, "")))
end

function run_config_value(config::AbstractDict, key::String, default)
    return haskey(config, key) ? config[key] : default
end

function run_config_int(value, key::String)
    value isa Integer && return Int(value)
    value isa AbstractFloat && isinteger(value) && return Int(value)
    return parse(Int, string(value))
end

function run_config_float32(value, key::String)
    value isa Real && return Float32(value)
    return parse(Float32, string(value))
end

function run_config_bool(value, key::String)
    value isa Bool && return value
    normalized = lowercase(strip(string(value)))
    normalized in ("1", "true", "yes", "on") && return true
    normalized in ("0", "false", "no", "off") && return false
    error("Unsupported boolean run config value for $key: `$value`")
end

function configured_string(config::AbstractDict, key::String, env_name::String, default::String)
    run_config_env_present(env_name) && return env_string(env_name, default)
    return string(run_config_value(config, key, default))
end

function configured_int(config::AbstractDict, key::String, env_name::String, default::Int)
    run_config_env_present(env_name) && return env_int(env_name, default)
    return run_config_int(run_config_value(config, key, default), key)
end

function configured_float32(config::AbstractDict, key::String, env_name::String, default::Float32)
    run_config_env_present(env_name) && return env_float32(env_name, default)
    return run_config_float32(run_config_value(config, key, default), key)
end

function configured_bool(config::AbstractDict, key::String, env_name::String, default::Bool)
    run_config_env_present(env_name) && return env_bool(env_name, default)
    return run_config_bool(run_config_value(config, key, default), key)
end

function configured_optional_float32(config::AbstractDict, key::String, env_name::String)
    run_config_env_present(env_name) && return env_float32(env_name, 0.0f0)
    haskey(config, key) || return nothing
    value = config[key]
    value isa AbstractString && lowercase(strip(value)) in ("", "none", "nothing", "null") && return nothing
    return run_config_float32(value, key)
end
