# C#-Run-Cmd
PowerShell script that uses the Rosyln compiler to run C# files from the command line, in one easy command.

Inspired by a [StackOverflow post](https://stackoverflow.com/a/40854220/22081657)

# Usage
This script can be used to automically compile and run any C# (`.cs`) file.
To use it, simply run the script and provide the path to your file as the first argument:

```sh
runcsfile <filepath>
```

For example, to run the file `C:\Users\zachy\Desktop\test.cs`:

```sh
runcsfile "C:\Users\zachy\Desktop\test.cs"
```

# Requirements

- Only works on windows (as it's a powershell script)
- The script must be run in powershell (not command prompt or any other terminal)
- Uses [Microsoft.Net.Compilers](https://www.nuget.org/packages/Microsoft.Net.Compilers) Nuget package - but it will automatically install the latest version

# Todo

[Microsoft.Net.Compilers](https://www.nuget.org/packages/Microsoft.Net.Compilers) is apparently deprecated - switch to [Microsoft.Net.Compilers.Toolset](https://www.nuget.org/packages/Microsoft.Net.Compilers.Toolset)
