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

ע�⣺�������ʽҪ���ڷ�����֮�䣬����Ҫ�пո�����: [$a==$b] �Ǵ���ģ�����д�� [ $a == $b ]

| operator |            specification            |         example         |
|----------|-------------------------------------|-------------------------|
| ==       | ���ڱȽ��������֣���ͬ�򷵻� true   | [ $a == $b ] ���� false |
| !=       | ���ڱȽ��������֣�����ͬ�򷵻� true | [ $a != $b ] ���� true  |

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


- file
- function
- redirect to 



















































