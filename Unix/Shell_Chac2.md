<!-- MarkdownTOC -->

- [hell�﷨](#hell�﷨)
    - [��/](#��)
    - [un the shell scipt](#un-the-shell-scipt)
    - [ariables](#ariables)
        - [eadonly variables](#eadonly-variables)
        - [elete the variables](#elete-the-variables)
    - [tring](#tring)
        - [he lengce of the string](#he-lengce-of-the-string)
    - [rray](#rray)
        - [etch the value](#etch-the-value)
        - [he length of the array](#he-length-of-the-array)
        - [he length of the element](#he-length-of-the-element)
    - [���](#���)
        - [�������](#�������)
        - [ϵ�����](#ϵ�����)
        - [�������](#�������)
        - [�������](#�������)
        - [���������](#���������)
        - [�����������](#�����������)
    - [�̿���](#�̿���)
        - [f](#f)
        - [f else](#f-else)
        - [f else-if else](#f-else-if-else)
        - [or](#or)
        - [hile](#hile)
        - [ntil](#ntil)
        - [ase](#ase)
    - [hell function](#hell-function)
        - [unction argument](#unction-argument)
    - [/O,Redirect](#oredirect)
        - [edirect](#edirect)
        - [dev/null](#devnull)
    - [ntroduce another file](#ntroduce-another-file)

<!-- /MarkdownTOC -->

##Shell�﷨

###.��/
.����ǰ�ļ���
/����ϵͳ��Ŀ¼

###Run the shell scipt 
`test.sh`

```shell
#!/bin/bash
echo 'Hello World!'
```

- as executable program

```shell
chmod +x ./test.sh #the executable authority
./test.sh           #execute the script
```

`./`means looking for the scrpt in the current directory.

- as interpreter's argument

```shell
/bin/sh test.sh
/bin/php test.sh 
```

It's not neccessary for the `#!/bin/bash` in the first line.

- own 

`sh +x test.sh`

###Variables

- Define the variables

`your_name='nelson'`

**There is no spaces around the =**
- Use the variables

`echo ${your_name}`


####Readonly variables
Once define the readonly variables,the value can't be changed.

```shell
#!/bin/bash
your_name='nelson'
readonly your_name 
```

####Delete the variables

`unset variable_name` The readonly variables can not be deleted.

###String

�ַ��������õ����ţ�Ҳ������˫���ţ�Ҳ���Բ�������.

�������ַ��������ƣ�

- ����������κ��ַ�����ԭ��������������ַ����еı�������Ч�ģ�
- �������ִ��в��ܳ��ֵ����ţ��Ե�����ʹ��ת�����Ҳ���У�

˫���ŵ��ŵ㣺

- ˫����������б���
- ˫��������Գ���ת���ַ�

####the lengce of the string

```shell
string="abcd"
echo ${#string}
```

###Array

`array_name=(value0 value1 value2 value3 value4)`

####fetch the value

`${array_name[num]}`
`num=@`fetch all the array's value 

####the length of the array

`length=${#array_name[@]}`or`length=${#array_name[*]}`

####the length of the element 

`length=${#array_name[n]}`

###�����

ԭ��bash��֧�ּ򵥵���ѧ���㣬���ǿ���ͨ������������ʵ�֣����� awk �� expr��expr ��á�

expr ��һ����ʽ���㹤�ߣ�ʹ��������ɱ��ʽ����ֵ������

```shell
val=`expr 2 + 2`
echo "${val}"
```

����ע�⣺

- ���ʽ�������֮��Ҫ�пո����� 2+2 �ǲ��Եģ�����д�� 2 + 2������������Ϥ�Ĵ����������Բ�һ����
- �����ı��ʽҪ�� ` ` ������ע������ַ����ǳ��õĵ����ţ��� Esc ���±ߡ�

####���������
�ӣ������ˣ�����ȡ�࣬��ֵ��==��!= 

- expr 

ע�⣺�������ʽҪ���ڷ�����֮�䣬����Ҫ�пո�����: [$a==$b] �Ǵ���ģ�����д�� [ $a == $b ]

| operator |            specification            |         example         |
|----------|-------------------------------------|-------------------------|
| ==       | ���ڱȽ��������֣���ͬ�򷵻� true   | [ $a == $b ] ���� false |
| !=       | ���ڱȽ��������֣�����ͬ�򷵻� true | [ $a != $b ] ���� true  |

- $(())

    `r=$(( 4 + 5 ))` 

- $[]

    `r=$[ 4 + 5 ]`

####��ϵ����� 
��ϵ�����ֻ֧�����֣���֧���ַ����������ַ�����ֵ�����֡��ٶ����� a Ϊ 10������ b Ϊ 20��
`great than,less than,equel to `

| operator |          specification           |          example          |
|----------|----------------------------------|---------------------------|
| -eq      | ����������Ƿ���ȣ���ȷ���true | [ $a -eq $b ] ���أ�false |
| -ne      | ����ȷ���true                   | [ $a -ne $b ] ����true    |
| -gt      | ������ң�����true               | [ $a -gt $b ] false       |
| -lt      | ��С���ң�����ture               | [ $a -lt $b ] true        |
| -ge      | ���ڵ��ڣ�true                   | [ $a -ge $b ] fale        |
| -le      | С�ڵ��ڣ�true                   | [ $a -le $b ] true        |

####���������

�±��г��˳��õĲ�����������ٶ����� a Ϊ 10������ b Ϊ 20��

| operator | specification |                example                |
|----------|---------------|---------------------------------------|
| !        | ��            | [ !false ] true                       |
| -o       | ��            | [ $a -lt 20 -o $b -gt 100 ] ���� true |
| -a       | ��            | [ $a -lt 20 -a $b -gt 100 ] ���� false                                      |

####�߼������

���½��� Shell ���߼���������ٶ����� a Ϊ 10������ b Ϊ 20

| operator | specification |                  example                  |
|----------|---------------|-------------------------------------------|
| &&       | �߼�and       | [[ $a -lt 100 && $b -gt 100 ]] ���� false | 

||               �߼�or       [[ $a -lt 100 || $b -gt 100 ]] ���� true

####�ַ��������
�±��г��˳��õ��ַ�����������ٶ����� a Ϊ "abc"������ b Ϊ "efg"��

| operator |            specification             |      example      |
|----------|--------------------------------------|-------------------|
| =        | ��������Ƿ����                     | [ $a = $b ] false |
| !=       | ����ȷ���                           | [ $a != $b ] true |
| -z       | ����ַ����Ƿ�Ϊ0��Ϊ��true          | [ -z $a ] false   |
| -n       | ����ַ����Ƿ�Ϊ0����Ϊ��true        | [ -n $b ]true     |
| str      | ����ַ����Ƿ�Ϊ�գ���Ϊ�գ�����true | [ $b ] true                   |

####�ļ����������

�ļ�������������ڼ�� Unix �ļ��ĸ�������.[���Լ����������](http://www.runoob.com/linux/linux-shell-basic-operators.html)

###���̿���
shell�����̿��Ʋ���Ϊ��.
####if

```shell
if condition;then
    command1
    command2
    command3
fi
```

д��һ��,�������ն�:

`if condition; then command; fi` for example:
`if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true"; fi`

####if else

```shell
if confition; then
    command1
    command2
else
    command3
    command4
fi
```

####if else-if else

```shell
if condition1; then
    command1
else-if condition2
    command2
else 
    commandN
fi
```


####for 

```shell
for var in iterm1 iterm2 iterm3 ...itermN
do
    command1
    command2
done
```

`for var in iterm1 iterm2 itermN; do command1; do command2; done;`

####while

```shell
while condition
do 
    command
done
```


whileѭ�������ڶ�ȡ������Ϣ

```shell
echo "What's your favorite movies:"
while read movie
do 
    echo "My favorite movie is $movie !"
done
```
####until

ֱ��conditionΪ��,ѭ��ֹͣ:
```shell
until condition
do
    command
done
```

####case

```shell
echo '���� 1 �� 4 ֮�������:'
echo '�����������Ϊ:'
read aNum
case $aNum in
    1)  echo '��ѡ���� 1'
    ;;
    2)  echo '��ѡ���� 2'
    ;;
    3)  echo '��ѡ���� 3'
    ;;
    4)  echo '��ѡ���� 4'
    ;;
    *)  echo '��û������ 1 �� 4 ֮�������'
    ;;
esac
```

###shell function

```shell
func_name(){
    command
}
```
��������ֵ�ڵ��øú�����ͨ��`$?`����á�

ע�⣺���к�����ʹ��ǰ���붨�塣����ζ�ű��뽫�������ڽű���ʼ���֣�ֱ��shell�������״η�����ʱ���ſ���ʹ�á����ú�����ʹ���亯��������.

####function argument

`${n}`represents the n-th argument.

###I/O,Redirect

| commands | specification |
`n >& m`     `������ļ� m �� n �ϲ�`
`n <& m`     `�������ļ� m �� n �ϲ�`

####Redirect

```shell
��׼�����ļ�(stdin): stdin���ļ�������Ϊ0��Unix����Ĭ�ϴ�stdin��ȡ���ݡ�
��׼����ļ�(stdout): stdout���ļ�������Ϊ1��Unix����Ĭ����stdout������ݡ�
��׼�����ļ�(stderr): stderr���ļ�������Ϊ2��Unix�������stderr����д�������Ϣ��
```
Ĭ������£�`command > file`��`stdout`�ض���`file`��`command < file`��`stdin` �ض���`file`

- ���ϣ��`stderr`�ض���`file`����������д:
    `command 2 > file`
- ���ϣ����`stdout`��`stderr`�ϲ����ض���`file`����������д:
    `command > file 2>&1`
- `command`���`stdin`�ض���`file1`����`stdout`�ض���`file2`��
    `command < file1 > file2`

####/dev/null

���ϣ��ִ��ĳ��������ֲ�ϣ������Ļ����ʾ����������ô���Խ�����ض���/dev/null��
`command > /dev/null `

���ϣ������ stdout �� stderr����������д��
`command > /dev/null 2>&1`

###introduce another file

`. filename`or `source filename`

for exampel:

`. ./test.sh` or `source ./test.sh`







































