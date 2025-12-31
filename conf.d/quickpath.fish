# Not applied in non-interactive sessions
if not status --is-interactive
    return
end

# Binds / character to the command expansion function
if test "$fish_key_bindings" = fish_vi_key_bindings
    bind -Minsert / __quickpath_expand_slash
else
    bind / __quickpath_expand_slash
end

# =============================================================================
# Configuration: Set quickpath abbreviation mapping for your interative shell
#
# Note: You may need to escape some characters (such as tilde character: ~)
# and also add trailing slash to keep it after substitution.
#
# Example: Config on the first line will automatically substitute 'c/' into
# '~/.config/' right exactly when / character is hit on the keyboard
# =============================================================================
#quickpath --set c \~/.config/
#quickpath --set ls \~/.local/share/
#quickpath --set d ~/Documents/
