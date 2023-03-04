# Reference

We use username `solana` with sudoers to run `solana-validator`.

```bash
useradd -m solana
usermod -aG sudo solana
# Use Bash shell
usermod -s /bin/bash solana
```

Nginx as the front-end proxy on port 80.

## Hardware Spec

Arch: x86_64
Cpu: 32 core
Memory: 256GB
Disk: 2TB SSD

```bash
# uname -a
Linux solana-validator-node-1 5.15.0-1027-gcp #34~20.04.1-Ubuntu SMP x86_64 x86_64 x86_64 GNU/Linux
# lsb_release  -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 20.04.5 LTS
Release: 20.04
Codename: focal
```

GCP REST Template, credentials and sensitive information are masked.

```json
{
  "creationTimestamp": "**************",
  "description": "",
  "id": "**************",
  "kind": "compute#instanceTemplate",
  "name": "solana-validator-node",
  "properties": {
    "confidentialInstanceConfig": {
      "enableConfidentialCompute": false
    },
    "description": "",
    "scheduling": {
      "onHostMaintenance": "MIGRATE",
      "provisioningModel": "STANDARD",
      "automaticRestart": true,
      "preemptible": false
    },
    "tags": {
      "items": [
        "http-server",
        "https-server"
      ]
    },
    "disks": [
      {
        "type": "PERSISTENT",
        "deviceName": "solana-validator-node",
        "autoDelete": true,
        "index": 0,
        "boot": true,
        "kind": "compute#attachedDisk",
        "mode": "READ_WRITE",
        "initializeParams": {
          "sourceImage": "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230125",
          "diskType": "pd-ssd",
          "diskSizeGb": "2048"
        }
      }
    ],
    "networkInterfaces": [
      {
        "stackType": "IPV4_ONLY",
        "name": "nic0",
        "network": "projects/<PROJECT_ID>/global/networks/default",
        "accessConfigs": [
          {
            "name": "External NAT",
            "type": "ONE_TO_ONE_NAT",
            "kind": "compute#accessConfig",
            "networkTier": "PREMIUM"
          }
        ],
        "kind": "compute#networkInterface"
      }
    ],
    "reservationAffinity": {
      "consumeReservationType": "ANY_RESERVATION"
    },
    "canIpForward": false,
    "keyRevocationActionType": "NONE",
    "machineType": "n2-highmem-32",
    "metadata": {
      "fingerprint": "**********",
      "kind": "compute#metadata"
    },
    "shieldedVmConfig": {
      "enableSecureBoot": false,
      "enableVtpm": true,
      "enableIntegrityMonitoring": true
    },
    "shieldedInstanceConfig": {
      "enableSecureBoot": false,
      "enableVtpm": true,
      "enableIntegrityMonitoring": true
    },
    "labels": {
      "blockchain": "solana",
      "role": "validator"
    },
    "serviceAccounts": [
      {
        "email": "YOUR_ACCOUNT@developer.gserviceaccount.com",
        "scopes": [
          "https://www.googleapis.com/auth/cloud-platform"
        ]
      }
    ],
    "displayDevice": {
      "enableDisplay": false
    }
  },
  "selfLink": "projects/<PROJECT_ID>/global/instanceTemplates/solana-validator-node"
}
```

## Solana Validator/RPC Setup

<<https://book.solmeet.dev/notes/validator-starter-kit>
<https://docs.solana.com/running-validator/validator-start>
<https://www.solana-validator-guidebook.com/validator-setup/initial-validator-setup>

## Nginx Setup

<https://chainstack.com/how-to-run-a-solana-node/>

## Start Validator

```bash
# Create 21-solana-validator.conf
sudo sysctl -p /etc/sysctl.d/21-solana-validator.conf
# Update DefaultLimitNOFILE=1000000 in /etc/systemd/system.conf
sudo systemctl daemon-reload
systemctl restart logrotate.service
systemctl enable --now sol
# Should see our public IP in the gossip protocol
solana gossip | grep <YOUR_PUBLIC_IP>
```
