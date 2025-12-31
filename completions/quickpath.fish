# Disable file completion until it is necessary
complete --command quickpath --no-files

# --list completion
complete --command quickpath --short-option l --long-option list --description "List all quickpaths"

# --set completion (no arguments yet)
complete --command quickpath --long-option set --description "Set key mapping to path" --condition "not __quickpath_has_flag_set"

# --set: autocomplete existing keys for the key argument
complete --command quickpath --condition "__quickpath_needs_set_key" --arguments "(__quickpath_get_keys_with_descriptions set)"

# --set: enable file completion for the path argument
complete --command quickpath --condition "__quickpath_needs_set_path" --force-files

# --unset completion (no arguments yet)
complete --command quickpath --long-option unset --description "Unset key mapping" --condition "not __quickpath_has_flag_unset"

# --unset: autocomplete existing keys
complete --command quickpath --condition "__quickpath_needs_unset_key" --arguments "(__quickpath_get_keys_with_descriptions unset)"

# Helper: check if --set flag exists
function __quickpath_has_flag_set
    string match -q -- "--set" (commandline -opc)
end

# Helper: check if --unset flag exists
function __quickpath_has_flag_unset
    string match -q -- "--unset" (commandline -opc)
end

# Helper: count arguments after a specific flag
function __quickpath_count_args_after_flag
    set -l flag $argv[1]
    set -l tokens (commandline -opc)

    # Look for the flag
    if not contains -- $flag $tokens
        return 1
    end

    # Count arguments after the flag
    set -l after_flag 0
    set -l found_flag 0
    for token in $tokens
        if test $found_flag -eq 1
            set after_flag (math $after_flag + 1)
        end
        if test "$token" = "$flag"
            set found_flag 1
        end
    end

    echo $after_flag
end

# Helper: check if we need key for --set
function __quickpath_needs_set_key
    set -l count (__quickpath_count_args_after_flag "--set")
    test $status -eq 0 -a "$count" -eq 0
end

# Helper: check if we need path for --set
function __quickpath_needs_set_path
    set -l count (__quickpath_count_args_after_flag "--set")
    test $status -eq 0 -a "$count" -eq 1
end

# Helper: check if we need key for --unset
function __quickpath_needs_unset_key
    set -l count (__quickpath_count_args_after_flag "--unset")
    test $status -eq 0 -a "$count" -eq 0
end

# Helper: get all existing keys with descriptions showing mapped paths
function __quickpath_get_keys_with_descriptions
    set -l mode $argv[1]  # 'set' or 'unset'

    for item in $__quickpath_maps
        set -l parts (string split --max 1 "/" $item)
        if test -n "$parts[1]"
            set -l key $parts[1]
            set -l path $parts[2]

            if test "$mode" = "set"
                printf "%s\tExisting key: %s\n" $key $path
            else if test "$mode" = "unset"
                printf "%s\tKey to remove: %s\n" $key $path
            end
        end
    end
end
