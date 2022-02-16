# ---------------------------------------
# zip
# ---------------------------------------

function bh_zip_files() {
  : ${2?"Usage: ${FUNCNAME[0]} <zip-name> <files... >"}
  zipname=$1
  shift
  zip "$zipname" -r "$@"
}

function bh_zip_dir() {
  : ${1?"Usage: ${FUNCNAME[0]} <dir-name>"}
  zip "$(basename $1).zip" -r $1
}