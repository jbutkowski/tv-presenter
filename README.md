# TV presenter
A super simple way to loop images as a full-screen slideshow. Ideal for office TV's.

## Setup

1. Install gems with bundler
```bash
$ bundle install
```
2. Save image slides in '/slides/[Mon,Tue,Wed,Thu,Fri,Sat,Sun]/' directory


## Run presentation

(Optional) Customise slide duration in the Procfile (default: 20 seconds)
```ruby
# set slide duration (eg: 20 seconds)
duration = 20
```

Run presentation with default 10 second slide duration
```bash
$ procman start
```


## Stop presentation
```bash
$ procman stop
```


## Test auto stop/start

Edit tv-presenter.rb and change 'test' local variable to true.
```ruby
test = false # change to true
```

Then start the app as noted above.  This will loop 3 times before restarting.
Note: the duration will affect how long each loop of the test lasts - keep default.