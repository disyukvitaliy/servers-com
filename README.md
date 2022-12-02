### Intro

This project is backend engineer challenge for the https://www.servers.com/ company.

### Development

1. Set SSH key on Github using instructions here: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
2. Clone the project

```sh
git clone git@github.com:disyukvitaliy/servers-com.git
cd servers-com
```

3. Make sure you have docker and docker compose installed or install them https://docs.docker.com/compose/

```sh
docker compose -v
```

4. Build the project

```sh
./ape build
```

5. Apply migrations

```sh
./ape migrate
```

6. Start the project

```sh
./ape up
```

### Testing
An automatic testing is not supported yet but you can do that manually on the running project

To add an IP address to the list of tracked ones:

```sh
curl -X POST -d 'ip=127.0.0.0' -u 'admin:secret' -v localhost:9292/trackers
```

To remove an IP address from the list:

```sh
curl -X DELETE -d 'ip=127.0.0.0' -u 'admin:secret' -v localhost:9292/trackers
```

To see what is stored in the list:

```sh
curl -u 'admin:secret' -v localhost:9292/trackers
```

To see the collected statistics:

```sh
curl -d 'ip=127.0.0.0' -d 'start=29-11-2022' -d 'end=30-11-2022' -u 'admin:secret' -v localhost:9292/tracker_statistics
```

### TODO

* Chose a Time series database which will suit our use case.
* There are lots of improvements to do.

### ape file
Is a simple bash script which stores some useful project related commands. It hides complex commands which might be hard to remember behind a simple interface.
