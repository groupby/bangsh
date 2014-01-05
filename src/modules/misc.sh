# Checks that all dependencies are available
function b.misc.has_dependencies? () {
  for req in $1; do
    hash "$req" 2>&-
    if [ $? == 1 ]; then
        b.raise RequiredAppNotInstalled "please install '$req'"
        return 1;
    fi
  done;
}
