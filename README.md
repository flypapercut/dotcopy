## Usage

Give this script execution permissions
`chmod +x /path/to/the/script`

This script uses a mapping file

Create a .json file with the following structure:

```json
{
	"files": {
		".zshrc": {
			"repo_path": "$HOME/.dotfiles/zsh/.zshrc",
			"system_path": "$HOME/.zshrc"
		}
	}
}
```

This file should contain all the files you want to copy, the path to the repository and the path to the system

The script will iterate over the items contained in it and copy from/to based in the flag passed to it

## Flags

Must use both mode_flag and file_flag to make this script work

### -to-system (mode_flag)

usage: `./dotcopy -to-system`

This will make the script iterate over the items defined in mapping file and copy all files from the repository path to the system path

### -to-repo (mode_flag)

usage: `./dotcopy -to-repo`

This will make the script iterate over the items defined in mapping file and copy all files from the system path to the repository path

### -f (file_flag)

usage: `./dotcopy -to-system -f ./mapping.json`

This will make the script read the ./mapping.json file, iterate over it and copy all files defined in it from the repository to the system

## Todo

- [ ] verify if the file exists before trying to copy it
- [ ] echo usage help when using -h flag
