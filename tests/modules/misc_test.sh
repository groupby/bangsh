b.module.require misc

function b.test.if_all_dependencies_exist () {

  b.misc.has_dependencies? 'sed grep cut'
  b.unittest.assert_success $?

  b.misc.has_dependencies? 'sort echo'
  b.unittest.assert_success $?

  function run_dep_mod1 () { b.misc.has_dependencies? 'clears'; }
  b.unittest.assert_raise run_dep_mod1 RequiredAppNotInstalled

  function run_dep_mod2 () { b.misc.has_dependencies? 'sort11'; }
  b.unittest.assert_raise run_dep_mod2 RequiredAppNotInstalled
}
