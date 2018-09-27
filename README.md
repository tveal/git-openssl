# git-openssl
Script(s) to compile Git with OpenSSL, because GnuTLS is no fun.

Why? If you get an error like the following, you probably need OpenSSL instead of GnuTLS with Git:
```
error: RPC failed; curl 56 GnuTLS recv error (-110): The TLS connection was non-properly terminated.
```

- [Ubuntu Install](#ubuntu-install)
- [Verify Install](#verify-install)

## Ubuntu Install

The `git-openssl-ubuntu.sh` script can be used to install or update existing Git-with-OpenSSL on Ubuntu-based Linux distros. A fork of [`git-openssl-experimental.sh`](https://github.com/paul-nelson-baker/git-openssl-shellscript/blob/master/git-openssl-experimental.sh).

Run the script as your regular user, not as root.
```
user@kubuntu:~/repos/git-openssl$ ./git-openssl-ubuntu.sh
```
If all runs happy, towards the end of the git compilation, you'll be promoted for some settings:

Package Docs - sure, why not?
```
The package documentation directory ./doc-pak does not exist. 
Should I create a default set of package docs?  [y]: y
```

Description - suggested: "Custom build of Git with OpenSSL instead of GnuTLS"
```
Please write a description for the package.
End your description with an empty line or EOF.
>> Custom build of Git with OpenSSL instead of GnuTLS
>> 
```

Debian Package Config - change as desired then move on
```
*****************************************
**** Debian package creation selected ***
*****************************************

This package will be built according to these values: 

0 -  Maintainer: [ root@VirtualBox ]
1 -  Summary: [ Custom build of Git with OpenSSL instead of GnuTLS ]
2 -  Name:    [ git ]
3 -  Version: [ 9:9.9.9-9dev0.9 ]
4 -  Release: [ 1 ]
5 -  License: [ GPL ]
6 -  Group:   [ checkinstall ]
7 -  Architecture: [ amd64 ]
8 -  Source location: [ git-master ]
9 -  Alternate source location: [  ]
10 - Requires: [  ]
11 - Provides: [ git ]
12 - Conflicts: [  ]
13 - Replaces: [  ]

Enter a number to change any of them or press ENTER to continue:
```

## Verify Install

To check if git was properly installed on your system, simply run the following command and observe the version output:
```
user@kubuntu:~$ git --version
git version 2018-09-27.openssl
```
If you run the setup script again, it will recompile with the latest source and install again, versioning to the year-month-day. If you had `GnuTLS` errors cloning before, try cloning a public git repo over HTTPS (hosted outside your company/internal network).