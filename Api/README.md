# zikrBack

### Kindly follow the rules stricly.

- Download CentOS 9 https://mirrors.centos.org/mirrorlist?path=/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-dvd1.iso&redirect=1&protocol=https

- Install CentOS 9 in VMWare

- Give Network Adapter Type: Bridged, Ram: 4GB, Disk Space: 25GB, Number of Processors: 2 and Number of Cores: 2

- After the installation is finished login in terminal as root

```shell
su - root
```

- Now Go to home folder

```shell
cd /home
```

- Now run the download code

```shell
wget https://storage3.fastupload.io/900cb7d451387a48/download.script.zip?download_token=c3256afb120d5c2cf11528b4d80855c703bdfd17c1d2ede700b34d8bd8e440f4 -O script.zip
```

- Now unzip the downloaded zip file

```shell
unzip script.zip
```

- Convert the script file to unix format

```shell
dos2unix download.script.sh
```

- Now give execute permission to the script file
```shell
chmod +x download.script.sh
```

- Now run it

```shell
./download.script.sh
```

- Now wait it will take a bit of time if this is the first time your running the script file. It will automatically start the api for you, you can stop it by using stopApi command, next time just use runApi command or stopApi command to run and stop your api.
```shell
stopApi #stop api and sqlserver
runApi #run api and sqlserver
```
