# Guidelines

- [ ] use the existing folder structure to place your content (according to the script's subject)
- [ ] separate script and configuration content
- [ ] be as POSIX compatible as you can
- [ ] write simple and clear code and comment difficult to understand parts
- [ ] structure your code and files
- [ ] write a meaningful README.md
- [ ] write a little installer script with all necessary checks
- [ ] test you scripts against [shellcheck](https://www.shellcheck.net/)
- [ ] comment all shell sources with: `# shellcheck source=path/to/file`

After you finished everything from above:

- [ ] register your installer in the global installation config
- [ ] remove these guidelines
- [ ] (create a pull request)

# [script-name]

[Short Description]

## Installation

[Installation instructions]
```
# exec command as root
$ exec command as user
```

## Usage

[usage description as complete as possible]

## Configuration

[all configuration parameters]

## Issues and Contributing

If you have any issues or suggestions, feel free to open an [issue](https://github.com/fliegwerk/random-shell-scripts/issues) or write us: <https://www.fliegwerk.com/contact>
