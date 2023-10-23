---
title: "Task 3 - No VNET accesss"
menuTitle: "Confirm no access between VNETS"
weight: 10
---

## Task 2 Check to make sure there is no traffic between VNETS

1. hub1spoke1-vnet with address space 192.168.1.0/24 and hub1spoke2-vnet with address space 172.16.1.0/24 have already been deployed.

![vnets1](../images/vnets1.png)

2. In the resources, note LinuxVM-Hub1Spoke1 IP(192.168.1.4) and LinuxVM-Hub1Spoke2 IP (172.16.1.4)

LinuxVM1               | LinuxVM2
:-------------------------:|:-------------------------:
![linuxvm1](../images/linuxvm1.png) |  ![linuxvm2](../images/linuxvm2.png)

 

3. On the LinuxVM-Hub1Spoke1 view, scroll down to click on Serial console. 

![linuxvm1serial](../images/linuxvm1serial.png)

4. Click on Serial Console to login to the Linux VM with username and password provided. 

5. Once logged ```ping 172.16.1.4``` shows no response. 

![ping1](../images/ping1.png)

6. Also confirm access to the internet ```ping 8.8.8.8``` and to get your Public ip address ```curl ipaddr.pub```.    Note: your IP address might be different from below. 

![publicip](../images/publicip.png)