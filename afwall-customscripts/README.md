# AFWall+ Firewall custom scripts

Custom scripts example for [AFWall+](https://github.com/ukanth/afwall) with focus on a privacy friendly and (mostly) google-free configuration

**DO NOT COPY THESE RULES WITHOUT THE TOTAL UNDERSTANDING WHAT THEY DO! WE ARE NOT REPONSIBLE FOR ANY NETWORK CONNECTION ERRORS OR BRICKED DEVICES!**

**If you have issues please use your favorite search engine first and look if someone has the similar problem some else!**


## Installation

1. Copy these files via adb to your favorite rooted android phone which has AFWall+ installed to the directory `/storage/emulated/0/`:
    ```
    $ adb push {iptables-on,iptables-off,apply-custom-rules,delete-custom-rules}.sh /storage/emulated/0/
    ```

2. Now go into the android shell, get **root** permissions and copy the files to `/data/local/`:
    ```
    $ adb shell
    :/ $ su
    :/ # cp /storage/emulated/0/{iptables-on,iptables-off,apply-custom-rules,delete-custom-rules}.sh /data/local/
    ```

3. Make the copied files executable and remove the old files:
    ```
    :/ # chmod 755 /data/local/{iptables-on,iptables-off,apply-custom-rules,delete-custom-rules}.sh
    :/ # rm /storage/emulated/0/{iptables-on,iptables-off,apply-custom-rules,delete-custom-rules}.sh
    ```

4. Go to the `AFWall+ App` -> Press the `three dots` in the upper left corner -> then `Set custom script`.
    
    Enter the following in upper text box before any other custom script:
    ```
    . /data/local/iptables-on.sh
    ```
    And in the lower text box:
    ```
    . /data/local/iptables-off.sh
    ```

5. Enable the firewall in the AFWall+ App and restart your android device.

## Script Content

All scripts use [iptables](https://netfilter.org/) the manipulate the netfilter stack of the android linux kernel. All rules aim for the most possible privacy friendly of the android operating system without limiting the normal functionality not that much.

They also release some the very persistent connections to Google like the DNS server, the NTP server or the CaptivePortal checks.

You can edit the rules as you like, add remove or modify all lines.

A very good guide how to use iptables:
<https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html>

If you have modified some content please repeat all steps in the [Installation section](#installation).

## Issues and Contributing

If you have any issues or suggestions, feel free to open an [issue](https://github.com/fliegwerk/random-shell-scripts/issues) or write us: <https://www.fliegwerk.com/contact>

## Acknowledgments

Many thanks to [ukanth](https://github.com/ukanth) for creating this wonderful and open-source app!

Special thanks goes to Mike Kuketz with his article series:
> [»Take back control!«: Android ohne Google](https://www.kuketz-blog.de/android-ohne-google-take-back-control-teil1/)

A very good guide for building a google-free android phone
