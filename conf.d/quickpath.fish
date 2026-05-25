# Not applied in non-interactive sessions
status is-interactive
or return

# Defer the initial bind until after config.fish has run, so vi mode set there
# is visible. conf.d loads before config.fish, so reading $fish_key_bindings now
# would always see the default. The hook erases itself after firing.
function __quickpath_install --on-event fish_prompt
    functions --erase __quickpath_install
    __quickpath_bind
    # Re-apply the binding whenever the user switches binding modes at runtime.
    function __quickpath_rebind --on-variable fish_key_bindings
        __quickpath_bind
    end
end
