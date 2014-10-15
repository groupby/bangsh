b.module.require misc

function b.test.if_all_dependencies_exist () {

  b.misc.has_all_dependencies? 'sed grep cut'
  b.unittest.assert_success $?

  b.misc.has_all_dependencies? 'sort echo'
  b.unittest.assert_success $?

  b.misc.has_all_dependencies? 'clears'
  b.unittest.assert_error $?

  b.misc.has_all_dependencies? 'sort11'
  b.unittest.assert_error $?
}

function b.test.misc_dependencies () {
  b.unittest.assert_equal "$(b.misc.has_dependencies? 'sed grep')" ""
  b.unittest.assert_equal "$(b.misc.has_dependencies? 'clear')" ""
  b.unittest.assert_equal "$(b.misc.has_dependencies? 'boo')" "please install 'boo'"
}
