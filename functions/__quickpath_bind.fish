function __quickpath_bind --description "Bind / to quickpath expansion in the active key-binding mode"
    if test "$fish_key_bindings" = fish_vi_key_bindings
        bind -M insert / __quickpath_expand_slash
    else
        bind / __quickpath_expand_slash
    end
end
