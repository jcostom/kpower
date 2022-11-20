# kpower

## Pull power stats out of a Kasa smart plug and push data into InfluxDB 2.x

### Step 1: Setup InfluxDB

Crack open influx-setup.sh in a text editor. Change the 4 variables at the top for your db instance. The username & password are what you'll use for the InfluxDB web ui.

Ready? Run that script, capture the output at the bottom, which will include a big long string ending in ==. That's your token value. Make a note of it.

### Step 2: Setup your docker-compose.yaml file

First, set the variables in the influxdb instance appropriately. You should have all the bits to plug in from Step 1.

Next, setup your kpower monitoring instances. 1 per plug. Yes, it was quick & dirty, and yes, I could make it such that a single instance could monitor multiple plugs, but I had most of the code and was pressed for time.

### Step 3: Fire it up.

```bash
docker-compose up -d
```

Do that, and your containers will spring to life and start monitoring your plugs.

### Step 4: Visualize.

Login to the InfluxDB UI (http://yourhost:8086). You can create a dashboard easily enough to graph the data.

You could also run an instance of grafana if you want to make it super snazzy.
