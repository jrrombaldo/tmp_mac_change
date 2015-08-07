# tmp_mac_change

## Description
This script aims to change temporary the MAC address of a specifc interface and revert it back.
It's accept two paramters, a NIC (Network Interface) and the desired MAC address. Being the second one not required, and when not specified the script will generate a random MAC starting with 00-60-2f.


NOTE: It's required root permissions to chnage a NIC config, so that is required run this script with root privileges


### Examples:
1. When there is a specific target MAC:

    ```sudo tmp_mac_change.sh en0 00-60-2f-CF-BE-70```
    
2. When there's no specific MAC and the script will generate a random one:

    ```sudo tmp_mac_change.sh en0```
    

In both scenarios, the script will ask for confirmation to change the MAC, as well will wait for confirmation to roll back the change.



### Output example:
```
CHANGE MAC ADDRESS FOR A WHILE 
  
        en0  00-60-2f-40-E3-38 -> 00-60-2f-CF-BE-70 

[Enter] to change ...

        Current MAC: 00:60:2f:cf:be:70 

[Enter] to revert ...

        Current MAC: 00-60-2f-40-E3-38
```        
  
