# EZ LICENSE

### Summary
Used for generating a CSV file of licenses discovered in NPM, YARN, and BUNDLER packages if available. This code currently only runs on Alpine and Debian 
based operating systems but can easily be modified to accomidate more. 

### Requirements

- An application using 1 or more of the following package managers:
  - Npm
  - Bundler
  - Yarn

- Ability to run commands as sudo or root user


- Bash must be installed (```apk add bash``` OR ```apt-get install bash```)


### How To Run

From the command line access your application's main directory (this is where .lock files are typically stored)
```cd YOUR_PROGRAM_DIR```

Clone the repository
```git clone https://github.com/tuckerweibell/ez_license.git```

Copy files to app directory
```cp ez_license/* .```

Add executable permissions to ezlicense.sh
```chmod +x ezlicense.sh```

Ensure bash is installed
```apk add bash``` OR ```apt-get install bash```

Verify you are root or have sudo permissions
```sudo -l``` OR ```whoami```

Execute the bash script
```./ezlicense.sh```

Enter your OS type
1) alpine
2) debian

Enter: (1 or 2)

Enter app name (anything you want): myapp

### Docker Tips
- Run with user root ```-u="root"``` when you run the docker image
- Create a results directory on the host machine and map it with a volume to the container ```-v $PWD:/usr/src/app/results```


## NOTE 
This application is a plain old bash and ruby script combination. It will not handle every scenerio you are likely to encounter. However, the principles found in the 
scripts that utilize ```gem``` , ```npm```, and ```yarn``` in order to grab license information can be applied in various ways. Feel free to clone the repo and make improvements
as you wish or customize the code to serve applicable functions for your use case.


