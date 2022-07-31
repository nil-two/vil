vil
===

![CI](https://github.com/nil2nekoni/vil/workflows/CI/badge.svg)

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

$ vil --help 2>&1 | vil -ne'%s/^ *//|g/^-/+1p'
suppress automatic printing of buffer
add the script to the commands to be executed
add the contents of script-file to the commands to be executed
display this help and exit
output version information and exit
```

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
                 display version information and exit
```

Requirements
-----------

- Vim

Installation
------------

vil is a simple shell script.

The following instructions assume that `~/bin` is on your `$PATH`.
If that is not the case, you can substitute your favorite location.

```sh
curl -L https://raw.githubusercontent.com/nil2nekoni2/vil/master/vil > ~/bin/vil
chmod 755 ~/bin/vil
```

Options
-------

### -n, --quiet, --silent

Suppress automatic printing of buffer.

```
$ seq 10 | vil -n 's/.*/.../'
(Print nothing)

$ seq 10 | vil -n 'g/../-1p'
9
```

### -e script, --expression=script

Add the script to the commands to be executed.

```
$ seq 5 | vil -e '%s/.*/**/'
**
**
**
**
**

$ seq 10 | vil -e 5d -e 2,5d
1
7
8
9
10
```

### -f script-file, --file=script-file

Add the contents of script-file to the commands to be executed.

```
$ cat script.vim
3d
5d

$ seq 10 | vil -f script.vim
1
2
4
5
7
8
9
10

$ seq 10 | vil -f script.vim -f script.vim
1
2
5
7
9
10
```

### --help

Display this help and exit.

```
$ vil --help
(Print usage)
```

### --version

Display version information and exit.

```
$ vil --version
(Print version)
```

License
-------

MIT License

Author
------

nil2 <nil2@nil2.org>
