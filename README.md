## Usage

Give this script execution permissions
`chmod +x /path/to/the/script`

Create a file named "mapping.json" alongside the script

this file should contain all the files you want to copy, the path to the repository and the path to the system:

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

This script will iterate over the items contained in it and copy from/to based in the flag passed to it

## Flags

### -to-system

usage: `./dotcopy -to-system`

this will make the script iterate over the items defined in mapping.json and copy all files from the repository path to the system path

### -to-repo

usage: `./dotcopy -to-repo`

this will make the script iterate over the items defined in mapping.json and copy all files from the system path to the repository path

## Todo

- [ ] verify if the file exists before trying to copy it
