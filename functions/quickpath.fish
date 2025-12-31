function quickpath --description "Manages quickpath bindings in fish shell"
    argparse l/list set unset help -- $argv
    or return 1

    # --list/-l all quickpaths
    if set -q _flag_list
        if test (count $argv) -ne 0
            __quickpath_usage "Error: --list does not accept arguments"
            return 1
        end
        __quickpath_list
        return
    end

    # --set new (or modify) quickpath key
    if set -q _flag_set
        if test (count $argv) -ne 2
            __quickpath_usage "Error: --set requires exactly 2 arguments: <key> <path>"
            return 1
        end
        __quickpath_set $argv[1] $argv[2]
        return
    end

    # --unset quickpath key
    if set -q _flag_unset
        if test (count $argv) -ne 1
            __quickpath_usage "Error: --unset requires exactly 1 argument: <key>"
            return 1
        end
        __quickpath_unset $argv[1]
        return
    end

    # Show help when no flags are specified
    __quickpath_usage
    return 1
end

function __quickpath_usage --argument-names error_msg
    if test -n "$error_msg"
        echo >&2 "$error_msg"
        echo >&2
    end

    echo >&2 "Usage: quickpath [OPTIONS]"
    echo >&2
    echo >&2 "Options:"
    echo >&2 "  -l, --list              List all quickpath mappings"
    echo >&2 "  --set <key> <path>      Create or update a quickpath mapping"
    echo >&2 "  --unset <key>           Remove a quickpath mapping"
    echo >&2
    echo >&2 "Examples:"
    echo >&2 "  quickpath --set c \\~/.config/"
    echo >&2 "  quickpath --set d \\~/Documents/"
    echo >&2 "  quickpath --list"
    echo >&2 "  quickpath --unset c"
    echo >&2
end

function __quickpath_set --argument-names key path
    if test -z "$key"
        echo >&2 "Error: key cannot be empty"
        return 1
    end

    if test -z "$path"
        echo >&2 "Error: path cannot be empty"
        return 1
    end

    set -l new_list (__quickpath_filter_key $key)
    set -l entry (string join "/" $key $path)
    set -g __quickpath_maps $new_list $entry
end

function __quickpath_unset --argument-names key
    if test -z "$key"
        echo >&2 "Error: key cannot be empty"
        return 1
    end

    set -l new_list (__quickpath_filter_key $key)
    set -g __quickpath_maps $new_list
end

function __quickpath_filter_key --argument-names key
    for item in $__quickpath_maps
        set -l parts (string split --max 1 "/" $item)
        if test "$parts[1]" != "$key"
            echo $item
        end
    end
end

function __quickpath_list
    if test (count $__quickpath_maps) -eq 0
        echo >&2 "No quickpath mappings configured"
        return 0
    end
    printf "%s\n" $__quickpath_maps
end
