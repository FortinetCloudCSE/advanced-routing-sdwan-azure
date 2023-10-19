---
title: "Task 2 - NVA deployment"
menuTitle: "NVA deployment in VWAN hub"
weight: 5
---

1. Click on VWAN in the resources that are already deployed. 

![vwan1](./images/vwan1.png=250x250)

2. Navigate to click on Hubs on the left hand secrtion. A hub in East US is already deployed. The HUB deployment usually takes about 30-40 minutes and in the view of time allocated this has been done already.

![vwan2](./images/vwan2.png=250x250)

3. Click on the Hub and check information about Hub name, region, IP address allocated to hub. 


4. Check to make sure Hub routing status: provisioned and Hub status: Succeeded before you continue to other steps.  Note: please move on to the next step only if provisioned with green checks. 

![vwan3](./images/vwan3.png=250x250)

5. Click on the NVA option under third party providers > Create Network appliance.

![vwan5](./images/vwan5.png=250x250)

6. Select FortiGate SDWAN and NGFW offering , Create. proceed to leave site to redirect to Marketplace. 

![vwan6](./images/vwan6.png=250x250)

7. On the marketplace you should see a page like below. click create. 

![vwan7](./images/vwan7.png=250x250)

8. In the NVA creation step1: Set the Resource group to **vwanXX-training** (Reminder: XX is the lab allocated to you), Make sure the region is set to **East US** , Application name: vwan**XX**SDWANNGFW (**XX is the lab number**), Click next

![vwan8](./images/vwan8.png=250x250)

9. In the NVA creation step2: Slect the VWAN hub in your Resource group - vwan**XX**-training-virtualhub, Fortigate admin username to **xperts** password to **Fortinet123$**, Fortigate prefix to vwan**XX**, Version to **7.4.0** and Fortimanger IP **IP address** Serial number **SN**

![vwan9](./images/vwan9.png=250x250)

10. In the final step, make sure to scroll down to agree to the terms and conditions. Click Create. 

![vwan10](./images/vwan10.png=250x250)

11. this will take 15 minutes to get deployed. So we can now use this time to grab a Coffee ;) and relax! 