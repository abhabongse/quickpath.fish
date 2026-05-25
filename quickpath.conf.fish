# Example user-owned quickpath configuration.
#
# Copy this file to $FISH_CONFIG_DIR/conf.d/quickpath.conf.fish so the
# mappings are applied automatically in every interactive shell.
# Any filename ending in .fish inside conf.d/ will be autoloaded by fish.
#
# The stored value is inserted verbatim into the command line at substitution
# time, so it must already be in the form you want fish to see in the buffer.
# Use single quotes around the value to pass it literally; fish performs no
# processing inside single quotes.
#
# Key conventions:
#
#   ~ at the start    Write ~ (or \~ outside single quotes) so the tilde is
#                     stored as-is and fish tilde-expands it at execution time.
#
#   Spaces            Escape each space as \ inside single quotes so the path
#                     is a single token in the buffer.
#
#   $VAR              Single-quote to store literally; fish variable-expands at
#                     execution time. To store a literal dollar sign, write \$
#                     inside single quotes.
#
#   Backslashes       Double them inside single quotes: \\ stores one \.
#
#   Single quote (')  Cannot appear inside '...'. Combine quoting styles:
#                     'before'\\''after' produces before\'after in storage.
#
# Tips: Include a trailing slash on directory targets so the slash is part of
# the substituted text.
quickpath --set c '~/.config/'
quickpath --set ls '~/.local/share/'

# Path containing spaces:
quickpath --set d '~/My\ Documents/'

# Path where $VAR should expand at execution time:
quickpath --set proj '$PROJECT/src/'

# Path where the dollar sign should be literal:
quickpath --set prices '~/\$5_items/'
