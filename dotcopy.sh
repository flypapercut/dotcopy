#!/usr/bin/bash

capture_flag() {
 case "$@" in
  -to-repo) echo "..."; main "-to-repo";;
	-to-system) echo "..."; main "-to-system";;
   *) echo "could not identify flag";; 
 esac
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
	flag=$1
	while IFS=$'\t' read -r repo_path system_path; do

		repo_path=$(echo $repo_path | envsubst)
		system_path=$(echo $system_path | envsubst)
		copy_file $repo_path $system_path $flag

	done < <(jq -r '.files
			| to_entries[]
			| "\(.value.repo_path)\t\(.value.system_path)"' mapping.json)
}


main() {
	iterate $1
}

capture_flag $@