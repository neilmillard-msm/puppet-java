Java Puppet Module.

This is meant to be used as a dependency and in conjunction with Hiera.
The rpms are assumed available at a preferred location.


Supported OS: Redhat.


## Using from Github / source

### With librarian

If you use [librarian-puppet](https://github.com/rodjek/librarian-puppet), add
the following to your `Puppetfile`:

```ruby
mod "java",
  :git => "git@github.com:MSMFG/puppet-java.git",
  :ref => "0.0.1"
```

Hiera property required:

```
java::source_url: "http://download.oracle.com/otn-pub/java/jdk/7u51-b13"
java::jce_repo_url: "http://yourcachelocation/jce"
```

##JCE
original download from http://download.oracle.com/otn-pub/java/jce
link is no good without authentication token,
goto http://download.oracle.com and search for jce