# How to build and use VPP

## Prepare

Install required packages.

```
sudo ./scripts/prepare.sh
```

## Build

Build VPP and VPPSB plugins.

```
./scripts/vpp_build.sh
```

## Run 

Run in an interactive mode.

### Server 1
```
sudo ./scripts/run_vpp.sh 192.168.31.76 192.168.31.1 20.20.20.1
```

### Server 2
```
sudo ./scripts/run_vpp.sh 192.168.31.47 192.168.31.1 10.10.10.1
```

After exit Ethernet interfaces will be released.

## Configure

Run from a different console after VPP prompt is ready.

### Server 1
```
sudo ./scripts/conf_vpp.sh 192.168.31.76 192.168.31.1 20.20.20.1
```

### Server 2
```
sudo ./scripts/conf_vpp.sh 192.168.31.47 192.168.31.1 10.10.10.1
```

## Feature

### Server 1
```
cd scripts/<feature_name>/server1
sudo ./conf.sh
```

### Server 2
```
cd scripts/<feature_name>/server2
sudo ./conf.sh
```
