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

b.module.require path



function btask.remove.run () {
  local project="$1"
  if [ -n "$project" ]; then
    (
      cd "$(b.get bang.working_dir)"
        local path="$(b.get bang.working_dir)/$project"
      _project_folder_exists?
      if _is_bangsh_project?; then
        echo "removing project $project"
        rm -rf "$path"
      fi
    )
  fi
}

function _project_folder_exists? () {
    if b.path.dir? $path; then
        return 0;
    else
        return -1;
    fi
}

function _is_bangsh_project? () {
    declare -a array=("modules" "tasks")
    for f in "${array[@]}"
    do
        if b.path.dir? "$path/$f"; then
            echo "valid"
        else
            return -1;
        fi
    done

    if b.path.file? "$path/$project"; then
        echo "valid"
    else
        return -1
    fi
}
