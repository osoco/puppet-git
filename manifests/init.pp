class git ($version = "latest") {

    package { "git":
        ensure => $version
    }

}

define git::clone($username,$password,$url,$path) {
    include git
    exec { "git-http-clone-$name":
        command => "/usr/bin/git clone `echo $url | awk -vu=$user -vp=$password -vat=@ -vdd=: -F:// '{ print \$1 FS u dd p at \$2 }'` $path",
	creates => "$path"
    }
}

define git::pull($path) {
    include git
    exec { "git-pull-$name":
        command => "/usr/bin/git pull",
	onlyif => "test -d $path/.git",
        cwd => "$path"
    }

}
