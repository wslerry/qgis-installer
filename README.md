# QGIS installer for Debian

## Usage

### Run with curl and Specify Version:

Use the following command to run the script via curl, passing the version choice as an argument (1–5):

```shell
curl -sSL <URL_TO_YOUR_SCRIPT> | sudo bash -s <VERSION>
```

Replace `<VERSION>` with a selection of number from 1-5:

    1: Latest Release
    2: Upcoming Release
    3: Long Term Release
    4: Upcoming Long Term Release
    5: Development Version Example:

*Example:*

```shell
curl -sSL https://raw.githubusercontent.com/wslerry/qgis-installer/master/installer.sh | sudo bash -s 1
```

### Run Locally (Interactive Mode):

If you saved the script locally, make it executable:
```shell
chmod +x installer.sh
```

Run it with sudo to use the interactive prompt:
```shell
sudo ./installer.sh
```

Alternatively, pass a version argument for non-interactive use:
```shell
sudo ./installer.sh 1
```

### Verify Installation:

After installation, check QGIS:
```shell
qgis --version
```
