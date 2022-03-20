# TV presenter
A super simple way to loop images as a full-screen slideshow. Ideal for office TV's.

## Setup

1. Install gems with bundler
```bash
$ bundle install
```
2. Save image slides in '/slides/[Mon,Tue,Wed,Thu,Fri,Sat,Sun]/' directory


## Run presentation

Run presentation with default 10 second slide duration
```bash
$ ruby tv-presenter.rb
```

Run presentation with custom slide duration (eg: 20 seconds)
```bash
$ ruby tv-presenter.rb 20
```