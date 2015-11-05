vil
===

Edit text with Vim script.

```
$ cat nums
5
2
4

$ cat nums | vil %sort
2
4
5

$ vil --help | vil -n '%s/^ *//|g/^-/+1p'
suppress automatic printing of buffer
add the script to the commands to be executed
add the contents of script-file to the commands to be executed
display this help and exit
output version information and exit

```

Installation
------------

vil is a simple shell script.

The following instructions assume that `~/bin` is on your `$PATH`.
If that is not the case, you can substitute your favorite location.

```sh
curl -L https://raw.githubusercontent.com/kusabashira/vil/master/vil > ~/bin/vil
chmod 755 ~/bin/vil
```

Requirements
-----------

- Vim

Usage
-----

```
$ vil [OPTION]... {script-only-if-no-other-script} [input-file]...

Options:
  -n, --quiet, --silent
                 suppress automatic printing of buffer
  -e script, --expression=script
                 add the script to the commands to be executed
  -f script-file, --file=script-file
                 add the contents of script-file to the commands to be executed
  --help
                 display this help and exit
  --version
                 output version information and exit
```

License
-------

MIT License

Author
------

kusabashira <kusabashira227@gmail.com>
