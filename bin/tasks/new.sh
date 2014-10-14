# # Creating a new project
#
# This task is still very simple, although it helps a lot. It creates new
# bang-based projects and generates an executable file with the project's name.
#
# The task takes only one argument which can be the project name or a path. In
# the case only the name is given, the path used is the current directory.
#
# # Examples:
#
#     $ bang new my_project
#     # Creates:
#     #   - ./my_project
#     #   |-- modules/.gitkeep
#     #   |-- tasks/.gitkeep
#     #   |-- my_project
#
#     $ bang new projects/task_new
#     # Creates:
#     #   - ./projects/
#     #   |-- task_new/
#     #     |-- modules/.gitkeep
#     #     |-- tasks/.gitkeep
#     #     |-- task_new

b.module.require opt

function btask.new.run () {
	b.try.do _run "$@"
	b.catch ArgumentError b.opt.show_usage
	b.try.end
}

function _run () {
  _load_options
  b.opt.init "${@:2}" # skip first argument as that denotes the task being processed
  local project="$1"
  if [ -n "$project" ]; then
    (
      cd "$(b.get bang.working_dir)"
      mkdir -p "$project"

      _create_module_path
      _create_tasks_path
      if b.opt.has_flag? --self; then
		_create_self_main_file
      else
      	_create_main_file
      fi
      _copy_bangsh_to_project
    )
  fi
}	

function _load_options () {
  # Help (--help and -h added as flags)
  b.opt.add_flag --self "Self containing and not linked"
}

function _create_module_path () {
  mkdir -p "$project/modules"
  touch "$project/modules/.gitkeep"
}

function _create_tasks_path () {
  mkdir -p "$project/tasks"
  touch "$project/tasks/.gitkeep"
}

function _copy_bangsh_to_project () {
  cp -r "$_BANG_PATH" "$project/bangsh"
}

function _create_self_main_file () {
  local project_name="$(basename "$project")"
  exec >> "$project/$project_name"

  echo '#!/usr/bin/env bash'
  echo "source 'bangsh/bang.sh'"
  chmod +x "$project/$project_name"
}

function _create_main_file () {
  local project_name="$(basename "$project")"
  exec >> "$project/$project_name"

  echo '#!/usr/bin/env bash'
  echo "source '$_BANG_PATH/bang.sh'"
  chmod +x "$project/$project_name"
}
