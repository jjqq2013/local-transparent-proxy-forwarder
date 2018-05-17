# local-transparent-proxy-forwarder
Without configure various proxy settings, just let any process be able to access external web site which actually actually via a real proxy server

In a private environment with HTTP/HTTPS proxy server, you might have been sick of that a lot of program does not respect respect global proxy settings(such as http_proxy/https_proxy environment variable).

I managed to integrate iptables and some http tunnel tool to make any program be able to access external web site as if they are already directly connected to internet.

*Currently only works in Linux*

## Diagram

![resources](https://docs.google.com/drawings/d/e/2PACX-1vQHrfzaFyw57WfcKi1NgX6P7uq3fetp0M1x_dKT9izP0dGVwZf23AvgUEacoUTqG4zC8BabMzO1NoNK/pub?w=843&h=524)

## Note

Please please replace these words in each file and command line with yours:

|words | meaning
---- | ---
|eth0 |the real network interface for outgoing.
|100.99.88.0/24 |the IP ranges where you do not want be affected by this tool
|100.88.77.66 | real proxy server
|9999 | real proxy server port

## Usage

1. prepare your proxy env and download http forwarder and https tunnel tool.
```
./tp-install.sh
```
2. start http forwarder and https tunnel tool to listen :10080 and :10081 port.
```
./tp-init.sh
```
3. set iptables to redirect outward packages back to :10080 and :10081
```
./tp-enable.sh
```

*to remove iptable changes, you can run 
```
./tp-disable.sh
```


EDITING...
