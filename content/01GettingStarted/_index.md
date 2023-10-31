---
title: "Ch 1 Secure vWAN Lab - Overview"
menuTitle: "Ch 1: Overview"
weight: 10
---

**Overview of your environment (15 min)**


In this lab we will go over Secure VWAN Hub deployment. Azure Virtual WAN is a networking service that brings many networking, security, and routing functionalities together to provide a single operational interface. Some of the main features include:

  - Branch connectivity (via connectivity automation from Virtual WAN
  - Partner devices such as SD-WAN or VPN CPE).
  - Site-to-site VPN connectivity.
  - Remote user VPN connectivity (point-to-site).
  - Private connectivity (ExpressRoute).
  - Intra-cloud connectivity (transitive connectivity for virtual networks).
  - VPN ExpressRoute inter-connectivity.
  - Routing, Azure Firewall, and encryption for private connectivity.

We will be going over Secure VWAN hub deployment which includes Fortigates deployed in the VWAN hub and also get hands on experience to do East-West Inspection between VNETS peered to a Hub. Further we will also work on setting up IPSEC tunnels to Branch Fortigates and ping across your cloud environment from your Branch Linux VM.

Here is the lab network diagram for reference:

![networkdiagram1](./images/networkdiagram.png)
