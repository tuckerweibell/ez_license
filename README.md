# EZ LICENSE :closed_lock_with_key:
#### License Management & Compliance            
<br>

### NOTE 
This application is a plain old bash and ruby script combination. It will not handle every scenerio you are likely to encounter. However, the principles found in the scripts that utilize ```gem``` , ```npm```, ```yarn```, and ```pip``` in order to grab license information can be applied in various ways. Feel free to clone the repo and make improvements as you wish or customize the code to serve applicable functions for your use case.

## Summary
Used for generating a CSV file of licenses discovered in Ruby, Javascript, and Python packages if available. This code currently only runs on Alpine and Debian based operating systems but can easily be modified to accomidate more. 

### Requirements
This script will install additional tools that are required, however, some basic requirements must be met prior to running the script. 

- Debian or Alpine based OS. You can check by running the following command: <br>
  ```cat /etc/os-release | grep -w ID | cut -d "=" -f2```
  
- Bash must be installed. Most distros or images come with bash preinstalled. <br>
Alpine: ```apk add bash``` <br>
Debian: ```apt install bash```

- You must run the script as the root user or with sudo permissions.


### How To Run

From the command line access your application's root directory.
```cd YOUR_PROGRAM_DIR```

Clone the repository
```git clone https://github.com/tuckerweibell/ez_license.git```

Copy run.sh to app directory
```cp ez_license/run.sh .```

Add executable permissions to run.sh
```chmod +x run.sh```

Execute the bash script
```./run.sh```

### Flag Options

- ```-n```: The name of your app. This will be used to generate the output CSV file. i.e If you specify ```-n MY-APP``` then the generated output file will be MY-APP_licenses.csv
- ```-o```: The OS type. Best to leave this flag off and let auto detection do its work. As of now this only supports either ```-o alpine``` or ```-o debian```. This is optional as in the event the OS Engine cannot auto detect your OS you will also be prompted to choose either debian or alpine.
- ```-d```: The ouput directory. This is the output directory where the CSV file will be generated. If no output directory is specified the CSV file will be generated in your working directory.
- ```-y```: This enables yarn scanning in addition to npm scanning if available. 99.9% of the time there is no reason to enable this as npm scanning will detect the licenses and packages that yarn scanning would. However, if you wish to have assurance you can use the -y flag. **NOTE:** You will have to remove all duplicates from the CSV file if you choose to enable this option.

### Docker Tips
- Root is usually the default user for docker images. If it is not, you will either need to change your Dockerfile or simply run the build with user root ```-u="root"```.
- Cloning the results to your local machine is as simple as setting up a docker volume to the output directory you specify. <br> ```-v $PWD:/usr/src/app/results```

### Example Command

```./run.sh -d results -n my-rails-app```


