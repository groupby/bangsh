# Checks that all dependencies are available
function b.misc.has_all_dependencies? () {
  for req in $1; do
    hash "$req" 2>&-
    local res=$?
    if [ $res == 1 ]; then return $res; fi
  done;
}

function b.misc.has_dependencies? () {
  for req in $1; do
    hash "$req" 2>&-
    if [ $? == 1 ]; then echo "please install '$req'"; exit; fi
  done;
}
