This is a very simple set of scripts that handle activating a j5 environment when running from source.

Since we support having multiple copies of the j5 source code checked out (usually to support different branches),
the scripts that find the environment for the current source code need to be in a separate repository - which is this one.
This enables them to be put on the system PATH without having conflicts between different versions.

These scripts should therefore be kept up to date to support all feasible j5 versions.
On installation, they will add a function or PATH that enables the user to run `j5activate`,
which will then delegate to the `j5activate` script in the actual source version.

