**various configuration files to deploy Docker Rails stack to cloud66**

__NOTE__: you can use `cloud66 starter` but I found lots of bug running 
`cloud66 starter` command. Hope it is fixed by now. You can still use these
configurationss.

Configurations:

- You need to push your `database.yml` file so don't ignore it
- `env` file is just a text file with `key=value` pairs for your environment variables, which we can import directly in `cloud66`
- `Dockerfile` is a docker configuration file, you can user your own.
- `docker-compose` not required really, but if you want to test docker configurations locally.
- `nginx.conf` because I am using nginx to serve rails application. You can skip it if you are using something like `puma` or `unicorn`. Also *NOTE* that I am using phusion/passenger image in Dockerfile.
- `rails-env.conf` so that our `env` variables are recognized in nginx
- `service.yml` is the cloud66 configuration file. this is just example file how it sould looks like. You can setup these exact configurations in cloud66 dashboards if you want. Or use this file if you are running cloud66 toolbelt. `cx ....`
