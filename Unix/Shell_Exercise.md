####Exercise

#####1-Execute multiple commands redirecting to a file
- create a script first.sh

```shell
who
pwd
ls
df -h
```

- sh +x first.sh >>first.log

```shell
jackzones console  Mar 18 17:19
jackzones ttys000  Mar 22 20:09
/Users/jackzones/World/shell
first.log
first.sh
Filesystem      Size   Used  Avail Capacity iused    ifree %iused  Mounted on
/dev/disk1     233Gi   30Gi  202Gi    14% 8056699 52924547   13%   /
devfs          186Ki  186Ki    0Bi   100%     644        0  100%   /dev
map -hosts       0Bi    0Bi    0Bi   100%       0        0  100%   /net
map auto_home    0Bi    0Bi    0Bi   100%       0        0  100%   /home
/dev/disk2s2    57Mi   40Mi   17Mi    71%   10348     4332   70%   /Volumes/搜狗输入法
```

#####2-A command corresponding to a result in a file 
*if the result is empty,<empty> will take place of it.*

- create a script `result_fi.sh`

```shell
result_fi(){
    if $1;then
        echo "$1"
    else
        echo "<empty>"
        echo "$1"
    fi
}
result_fi 'egrep '[[:space:]]*Protocol[[:space:]]+2' /etc/ssh/ssh_config'
result_fi 'egrep '[[:space:]]*PermitRootLogin[[:space:]]+no' /etc/ssh/sshd_config'
result_fi 'egrep '[[:space:]]*RhostsRSAAuthentication[[:space:]]+no' /etc/ssh/sshd_config'
result_fi 'rpm -q sysstat'
```

- sh + result_fi.sh >>result_fi.log 
    *convert the result to the result_fi.log with the formating of result + command* 
- vi result_fi.log
- :g/^/m0
    reserve





