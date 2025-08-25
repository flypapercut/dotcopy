#!/usr/bin/bash



capture_flag() {

file_flag=;
   
while [[ $# -gt 0 ]]; do
	case "$1" in
		-to-repo) echo ""; shift; mode_flag="-to-repo";;
		-to-system) echo ""; shift; mode_flag="-to-system";;
    -f)
      if [[ -n "${2:-}" ]]; then
        file_flag="$2"
				#echo $file_flag
				main $mode_flag
      	shift 2
      else
        echo "Error: -f require an argument." >&2
          exit 1
      fi
      ;;
    *) shift;;
  esac
done

if [[ $# -eq 0 && -z $file_flag ]] then
	echo "could not identify file flag"
elif [[ $# -eq 0 && -z $mode_flag ]] then
	echo "could not identify mode flags"
fi
}


copy_file() {
	if [[ $3 == "-to-repo" ]]; then
		echo "copying from system to repository"
		$(cp -r $2 $1 )
	elif [[ $3 == "-to-system" ]]; then
		echo "copying from repository to system"
		$(cp -r $1 $2 )
	fi
}


iterate() {
	mode_flag=$1
	while IFS=$'\t' read -r repo_path system_path; do

		repo_path=$(echo $repo_path | envsubst)
		system_path=$(echo $system_path | envsubst)
		copy_file $repo_path $system_path $mode_flag

	done < <(jq -r '.files
			| to_entries[]
			| "\(.value.repo_path)\t\(.value.system_path)"' $file_flag)
}


main() {
	iterate $1
}

capture_flag $@