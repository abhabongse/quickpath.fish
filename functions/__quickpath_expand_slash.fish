function __quickpath_expand_slash
    set -l token (commandline -t)
    set -l matched 0

    for item in $__quickpath_maps
        set -l parts (string split --max 1 "/" $item)

        if test "$parts[1]" = "$token"
            set -l path $parts[2]

            if string match -q "* *" -- $path
                # Special case: enclose the string with quotation marks
                # if the substituted string contains a space character
                commandline -t "\"$path\""
                commandline -f backward-char
            else
                commandline -t "$path"
            end

            set matched 1
            break
        end
    end

    if test $matched -eq 0
        commandline -i /
    end
end
