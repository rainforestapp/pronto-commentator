# Pronto Commentator [![Circle CI](https://circleci.com/gh/rainforestapp/pronto-commentator.svg?style=svg)](https://circleci.com/gh/rainforestapp/pronto-commentator)

Pronto Commentator a very simple runner for
[Pronto](https://github.com/mmozuras/pronto) that outputs arbitrary comments
based on filename matching. It's good for tagging specific people to review
specific kinds of changes (for instance, tagging your security team if
auth-related files change), and probably other things as well.

## Configuration

The main configuration file should be located at `.commentator/config.yml` in
your repo root. Pronto Commentator won't do anything unless the config file is
present. The configuration is pretty simple: it needs a root `files` key,
followed by associations of filename patterns to message file names. Here's an
example:

```yaml
files:
  app/lib/auth*.rb:
    ping_bob.md
  "doc/chapters/[1-3].txt":
    ping_real_writers.md
```

The message file names should point to files in the `.commentator`
directory. For example, `.commentator/ping_bob.md` could look something like
this:

```
@bob looks like someone's trying to change the auth logic again, better take a look!
```

(Files don't have to be Markdown, but if you're using Github it's kinda nice).

File name matching uses
[Glob syntax](http://ruby-doc.org/core-2.3.0/Dir.html#method-c-glob).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/rainforestapp/pronto-commentator.
