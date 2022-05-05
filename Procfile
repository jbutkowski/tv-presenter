process :presenter do

  # set slide duration (eg: 20 seconds)
  $duration = 20

  # Action to be carried out when this process should start
  start do
    system("rm /tmp/tv-presenter.pid")
    system("ruby tv-presenter.rb #{$duration} & echo $! > /tmp/tv-presenter.pid")
  end

  # Action to be carried out when this process should stop
  stop do
    system("kill -TERM $(cat /tmp/tv-presenter.pid)")
    sleep 5
  end

  # Action to be carried out when this process should restart
  restart do
    stop and start
  end

end
