function __quickpath_expand_slash
    set -l token (commandline -t)
    set -l matched 0

    for item in $__quickpath_maps
        set -l parts (string split --max 1 "/" $item)

        if test "$parts[1]" = "$token"
            commandline -t -- $parts[2]
            set matched 1
            break
        end
    end

    if test $matched -eq 0
        commandline -i /
    end
end
