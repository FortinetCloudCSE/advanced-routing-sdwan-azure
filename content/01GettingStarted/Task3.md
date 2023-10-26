---
title: "Task 3 - Licensing and FGSP"
menuTitle: "Licensing and FGSP"
weight: 10
---

## License NVA's and enable FGSP

1. Once the NVA's are deployed the next step is to license the NVA. Instructors will be licensing the NVA's from Fortimanager. The following command is reference only do not complete this as part of your lab. 

```exec vm-license <token>```

The NVA's will reboot. 

2. We need to enable FGSP on both FortiGate's since NVA's are depoyed in Active-Active setup and we need session sync. 

On FGT-A CLI, configure the peer IP in which this device will peer with:

```
config system standalone-cluster
    config cluster-peer
        edit 1
            set peerip x.x.x.x (this will be the port2 Private IP address of peer FGT-B)
        next
    end
    set standalone-group-id 1
    set group-member-id 1
end
```

On FGT-B CLI, configure the peer IP in which this device will peer with:

```
config system standalone-cluster
    config cluster-peer
        edit 1
            set peerip x.x.x.x (this will be the port2 Private IP address of peer FGT-A)
        next
    end
    set standalone-group-id 1
    set group-member-id 2
end
```

