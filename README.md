### Iterm Rspec

Very simple - sends a command from vim to run your rspec in your existing
iTerm window. No more, no less. I looked around and found many variations on
this theme, but none that did exactly what I want.

This one does not use bundle exec because it assumes you have a smart shell
that understands bundler (zsh with bundler plugin). Also it is more universal
without assuming bundle exec so that you can run truly fast specs without bundler.

Stolen from lparry/vim-iterm-rspec and modified to support running
specs with spring for running quick Rails specs, or just naked rspec
for fast specs.

This plugin is included in the [YADR dotfile project](http://github.com/skwp/dotfiles)

### Included commands:

```
RunItermSpec
RunItermSpecLine
RunItermSpringSpec
RunItermSpringSpecLine
```

### Suggested Key Mappings

```vim
map <D-r> :RunItermSpec<cr>
map <D-l> :RunItermSpecLine<cr>
map <D-R> :RunItermSpringSpec<cr>
map <D-L> :RunItermSpringSpecLine<cr>
```
