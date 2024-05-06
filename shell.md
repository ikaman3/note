# Linux/MacOS Shell

Linux, MacOS 환경에서 사용할 수 있는 셸과 셸 스크립트를 정리하는 마크다운 문서

## zsh

로그인 가능한 셸의 종류

### 커서 조작

| command | action              |
| :-----: | ------------------- |
|  ⌃ + A  | 라인 맨 앞으로 이동 |
|  ⌃ + E  | 라인 맨 뒤로 이동   |
| ESC + B | 앞 단어로 이동      |
| ESC + F | 뒷 단어로 이동      |
|  ⌃ + B  | 앞 글자로 이동      |
|  ⌃ + F  | 뒷 글자로 이동      |
|  ⌃ + U  | 한 줄 삭제          |
|  ⌃ + W  | 앞 단어 삭제        |
| ESC + D | 뒷 단어 삭제        |

### Shell Initialization Files

셸 초기화 파일은 사용자 로그인 후 셸 생성 시 셸의 환경을 설정하는 파일을 말한다.
적용 범위에 따라서 System Initialization Files(시스템 초기화 파일)와 User Initialization Files(사용자 초기화 파일)로 나뉜다.

|     적용 범위      | <center>내용</center>                                               | <center>예시</center>                                        |
| :----------------: | :------------------------------------------------------------------ | :----------------------------------------------------------- |
|    System-wide     | 시스템 관리자가 관리하는 파일로써 셸 사용자 전체에게 영향을 준다.   | `/etc/profile`, `/etc/bashrc`                                |
| User Configuration | 시스템 사용자가 관리하는 파일로써 각 사용자에 한정되어 영향을 준다. | `$HOME/.bash_profile`, `$HOME/.bashrc`, `$HOME/.bash_logout` |

셸 초기화 파일들이 실행되는 순서는 아래와 같다.

1. `/etc/zshenv`
2. `$ZDOTDIR/.zshenv`
3. `/etc/zprofile`
4. `$ZDOTDIR/.zprofile`
5. `/etc/zshrc`
6. `$ZDOTDIR/.zshrc`
7. `/etc/zlogin`
8. `$ZDOTDIR/.zlogin`
9. `/etc/zlogout`
10. `$ZDOTDIR/.zlogout`

`/etc` 하위에 있는 숨겨지지 않은 파일은 모든 사용자에게 공통적으로 적용되는 환경 설정 파일이다.  
`$ZDOTDIR` 환경 변수를 사용한 숨김 파일은 특정 사용자를 지정하여 적용하는 환경 설정 파일이다.

#### zshenv

zsh 세션에서 실행됨

#### zprofile

로그인 셸에만 실행되는 프로파일 설정을 위한 파일

#### zshrc

대부분의 경우 모든 셸에 적용되는 설정 파일

#### zlogin

로그인 셸에만 적용되는 추가 설정 파일

#### zlogout

로그아웃 시 정리를 위한 설정 파일

## Shebang(셔뱅)

스크립트 파일이 어떤 셸로 실행되어야 하는지를 지정하는 shebang(셔뱅)라고 불리는 특별한 주석  
shebang은 스크립트가 어떤 인터프리터로 실행되어야 하는지를 지정하는데 사용되며, 스크립트의 첫 줄에 위치

```bash
#!/bin/bash
#!/bin/zsh
```

## exit status

Unix, Linux의 모든 명령어는 종료할 때 결과를 종료 상태라는 값으로 남긴다.  
`$?`으로 이전 명령어의 결과에 접근할 수 있다.

```bash
echo $?
```

- `0`: 성공
- `1`: 실패
- `127`: 존재하지 않는 명령어 사용

> **주의사항**  
> `echo` 명령어도 명령어이므로 실행하는 순간 `$?`의 값은 `0`이 된다.  
> 그러므로 종료 상태를 사용할 때는 변수에 담아서 사용하는 습관을 들이자.

## 명령어 연속 실행

### `;`

앞의 명령어의 성공, 실패와 상관없이 다음 명령어 실행

```bash
mkdir test; cd test
```

### `&&`

이전 명령어의 실행결과가 `true`일 때 다음 명령 실행

```bash
mkdir test && cd test && touch abc
```

### `&`

앞의 명령어를 백그라운드로 실행하고 **동시에** 다음 명령어 실행

```bash
mkdir test & cd test

# [1] 19989
# cd: no such file or directory: test
# [1]  + 19989 done       mkdir test
```

## 명령어 그룹핑

[API Reference](https://www.gnu.org/software/bash/manual/html_node/Command-Grouping.html)

Bash에서는 명령어 목록을 단위로 실행할 수 있는 두 가지 방법을 제공한다.  
명령어를 그룹화할 때 리다이렉션은 전체 명령어 목록에 적용될 수 있다.  
예를 들어, 목록 내의 모든 명령어의 출력을 단일 스트림으로 리다이렉트할 수 있다.

이 두 구조에는 역사적인 이유로 미묘한 차이가 있다.  
중괄호는 예약된 단어이므로 목록과 공백이나 다른 셸 메타 문자로 구분되어야 한다.  
괄호는 연산자이며, 공백으로 목록과 분리되지 않더라도 셸에 의해 별도의 토큰으로 인식된다.

이 두 구조의 종료 상태는 목록의 종료 상태(exit status)와 동일하다.

### `{}`

명령어 목록을 중괄호 사이에 놓으면 해당 목록이 현재 셸 컨텍스트에서 실행되게 한다.  
하위 셸이 생성되지 않는다. 목록 뒤에 세미콜론(또는 새 줄)이 필요하다.

```bash
mkdir test && { cd test; touch abc; echo 'success!!' } || echo 'There is no dir';
```

- `mkdir test`가 성공했을 때 `cd test; touch abc`를 실행하고 `success!!`를 출력
- 실패했을 때 `echo 'There is no dir'`를 실행
- 이때 실행되는 명령들은 현재 셸의 컨텍스트에서 실행
- 만약 서브 컨텍스트에서 실행하고 싶다면 `()`를 사용한다.

### `()`

명령어 목록을 괄호 사이에 놓으면 셸에 하위 셸(subshell)을 생성하게 만들며,  
목록 내의 각 명령어가 해당 하위 셸 환경에서 실행된다. 하위 셸에서 목록이 실행되기 때문에 변수 할당은 하위 셸이 완료된 후에도 유효하지 않다.

## Variable

셸에서 사용하는 변수를 선언

- 변수의 이름과 `=` 그리고 값 사이에 공백이 존재하면 안 된다.
- `export` : 변수 앞에 붙이면 외부 변수로 만들 수 있다. 해당 변수는 다른 스크립트, 프로그램에서도 사용 가능

```bash
VAR="foo"

export NEW_VAR="bar"
```

## Array

인덱스는 1부터 시작한다.

### 초기화와 출력

```bash
# 값 초기화
array=(111 "foo" 222 "bar" 333 "foobar")

# 인덱스를 명시하지 않으면 첫 번째 값 출력
echo $array # 111
echo $array[1] # 1
# 배열 원소 전체 출력 : array[@]
echo ${array[@]}

# 변수의 값이나 명령 실행 결과로 초기화할 수 있다.
array=($var)
array=($array[@])
array=(`date`) # 2024년 4월 10일 수요일 00시 33분 00초 KST
echo $array[4] # 금요일
grep_result_list=($(grep -oh 'nuri' ./testFile.txt))
```

### 원소 추가

```bash
array+=("end")
array+=("end" 123 444)
array+=($var)
array+=($array[@])
```

### 배열의 크기

```bash
echo ${#array[@]}

if [ ${#array[@]} -eq 0 ]; then
	echo "array 비었다"
fi
```

### 반복분과 응용

```bash
lastIndex=$(expr ${#array[@]} - 1)
for i in {0..$lastIndex}; do
	echo "i : $i"
done
```

### 문자열과의 차이점

`var="git gh"`과 `arr=("git" "gh")`은 차이가 있다.
변수 `var`은 하나의 문자열로 변수를 전달한다. 따라서 변수 안의 공백은 모두 문자열의 일부로 취급된다.

- `echo $var` : "git gh"
- `echo $arr[@]` : "git" "gh"

## Map

기본 사용법

```bash
# 선언
declare -A map
# key-value mapping
map[key1]=value1
map[key2]=value2
echo $map # value1 value2
```

### Map 크기

```bash
mapSize=${#map[@]}
```

### 특정 key 존재하는지 체크

```bash
if [ -z ${map[key3]} ]; then
    echo "key3 not exist"
else
    echo "key3 exist"
fi
```

### 반복문과 응용

```bash
for key in ${!map[@]}; do
    value=${key}
    echo "key:$key, value:$value"
done
```

## Parameter

추가예정

## 문자열 입출력

### echo

문자열 출력 명령어

- `-n` : 마지막에 붙는 개행 문자(newline) 문자를 출력하지 않음
- `-e` : 문자열에서 백슬래시(`\`)와 이스케이프 문자를 인용 부호(`"`)로 묶어 인식
- `-E` : 문자열에서 백슬래시와 이스케이프 문자를 비활성화(default)
- `>` : 리다이렉션, 해당 경로에 파일이 존재하지 않으면 echo의 출력 내용으로 새 파일 생성
  존재한다면 출력 내용으로 파일을 '덮어쓰기'로 저장
- `>>` : 리다이렉션, 해당 경로에 파일이 존재하지 않으면 echo의 출력 내용으로 새 파일 생성
  존재한다면 출력 내용으로 파일을 '이어쓰기'로 저장
- `:r` : 환경변수의 이름만 추출하는 명령어
- `:e` : 환경변수의 확장자만 추출하는 명령어

```bash
echo "<text>"
echo "<text>" > <file_name>
echo "<text>" >> <file_name>
echo $variable
echo ${variable:r}
echo ${variable:e}
```

### printf

`printf [-v var] format [arguments]`

`printf`는 builtin 명령으로 C 언어의 `printf` 함수와 같은 기능을 제공한다.  
`echo` 명령의 경우 `sh` 과 `bash` 가 escape 문자를 처리하는 방식이 다른데 `printf`는 그런 차이가 없다.  
`printf`에서는 기본적으로 `" "`, `' '` 모두에서 escape 문자가 처리된다(`gawk` 에서와 같이 escape 문자 테이블에 따라서 처리된다)  
quotes의 고유 기능은 그대로 유지 되므로 `" "` 에서는 변수확장, 명령치환이 된다.

```bash
printf '%s\n%s\n' foo bar      # (single quotes)
foo                              # printf 에 \n로 전달되고 escape 처리되어 newline 출력
bar

printf "%s\n%s\n" foo bar      # (double quotes)
foo                              # printf 에 \n로 전달되고 escape 처리되어 newline 출력
bar

printf '%s\\n%s\\n' foo bar    # printf 에 \\n로 전달되고 \\는 \로
foo\nbar\n                       # escape 처리되므로 \n로 출력

printf "%s\\n%s\\n" foo bar    # double quotes 에서는 \\ 가 \로 escape 되므로
foo                              # printf 에 \n로 전달되고 escape 처리되어 newline 출력
bar
##############################

printf %s 'foo\nbar\n'         # %s는 인수값의 escape 문자가 처리되지 않고
foo\nbar\n

printf %b 'foo\nbar\n'         # %b는 escape 문자가 처리된다.
foo
bar
##############################

AA=bar

printf 'foo $AA\n'             # single quotes 에서는 변수 확장이 안되고
foo $AA

printf "foo $AA\n"             # double quotes 에서는 된다.
foo bar
```

문자를 출력할 때는 `printf '%c' ...` 형식 외에 16진수, 8진수 escape sequence를 사용할 수 있다.

```bash
printf "%c %c %c\n" ABC DEF GHI
A D G

printf '\x41 \x42 \x43\n'      # 16진수
A B C

printf '\101 \102 \103\n'      # 8진수
A B C
```

#### -v <var> (bash only)

출력값을 변수에 저장

```bash
printf -v IFS " \t\n"          # escape sequence 가 처리되어 저장된다.

echo -n "$IFS" | od -tax1
0000000  sp  ht  nl
         20  09  0a

foo=bar                        # indirection 도 가능
printf -v "$foo" "%s: %d" "Content-Length" 123

echo "$bar"
Content-Length: 123
```

#### Arguments

`printf`는 format tags와 그에 상응하는 인수를 이용하여 여러가지 형태로 출력할 수 있다.  
이때 인수에 사용되는 숫자는 다음과 같은 형식을 사용할 수 있다.

- `N` : 10진수 (decimal) 숫자
- `0N` : 8진수 (octal) 숫자
- `0xN` : 16진수 (hexadecimal) 소문자 숫자
- `0XN` : 16진수 (hexadecimal) 대문자 숫자
- `'X` or `"X` : X는 character

```bash
# %d는 인수 값을 10 진수로 표시

printf "%d\n" 10        # decimal
10
printf "%d\n" 010       # octal
8
printf "%d\n" 0x10      # hexadecimal
16
printf "%d %d\n" "'A" '"A'   # character
65 65
```

format tags 개수보다 인수의 개수가 많을 경우는 명령이 반복된다.

```bash
printf "< %d >" 11
< 11 >

printf "< %d >" 11 22 33    # %d는 하나인데 인수는 3개 이므로 3번 반복
< 11 >< 22 >< 33 >

printf "< %d >\n" 11
< 11 >

printf "< %d >\n" 11 22 33
< 11 >
< 22 >
< 33 >

printf '%s\n' /bin/*
/bin/bash
/bin/brltty
/bin/btrfs
...

arr=( /usr/bin/z* )
printf '%s\0' "${arr[@]}" | sort -z | tr '\0' '\n'
/usr/bin/zcat
/usr/bin/zcmp
/usr/bin/zdiff
...
```

#### Format tags

format 스트링에서 다음과 같이 format tag를 구성하여 인수 값의 출력 형태를 변경할 수 있다.

```bash
%[flags][width][.precision]specifier
```

##### Specifier

- `%d`, `%i` : signed decimal number로 표시한다.
- `%u` : unsigned decimal number로 표시한다.
- `%o` : unsigned octal number로 표시한다.
- `%x` : unsigned hexadecimal number (소문자)로 표시한다.
- `%X` : `%x`와 같으나 대문자로 표시한다.
- `%f` : floating point number로 표시한다.
- `%e` : scientific notation 으로 표시한다.
- `%E` : `%e`와 같으나 대문자 E를 사용한다.
- `%g` : 값에 따라 floating point number 또는 scientific notation을 사용한다.
- `%G` : `%g`와 같으나 scientific notation 에서 대문자 E를 사용한다.
- `%a` : C99 형식의 hexadecimal floating point number로 표시한다. (bash only)
- `%A` : `%a`와 같으나 대문자로 표시한다. (bash only)
- `%s` : 인수 값을 escape 문자 처리 없이 그대로 출력한다.
- `%b` : 인수 값을 escape 문자 처리하여 출력한다.
- `%q` : shell 의 input 으로 사용할수 있게 escape 하여 출력한다.
- `%%` : % 문자를 일반 문자로 프린트할 때 사용한다.
- `%c` : 인수의 첫번째 문자를 프린트한다.
- `%(FORMAT)T` : FORMAT 에따라 date-time을 프린트한다.
- `%n` : 앞에서 출력된 문자수를 인수로 주어진 변수에 대입한다. (bash only)

```bash
printf "%d, %d\n" 10 -10    # signed decimal
10, -10

printf "%u, %u\n" 10 -10    # unsigned decimal
10, 18446744073709551606

printf "%o, %o\n" 10 -10    # unsigned octal
12, 1777777777777777777766

printf "%x, %x\n" 10 -10    # unsigned hexadecimal
a, fffffffffffffff6

printf '%e\n' 123            # scientific notation
1.230000e+02

printf '%f\n' 123            # floating point number
123.000000

printf '%g\n' 123
123

printf '%f\n' 123.4567
123.456700

printf '%g\n' 123.4567       # floating point number
123.457

printf '%f\n' 12345678.123
12345678.123000

printf '%g\n' 12345678.123   # scientific notation
1.23457e+07

printf '%f\n' 0.0000123
0.000012

printf '%g\n' 0.0000123      # scientific notation
1.23e-05

printf '%a\n' 123.4567       # hexadecimal floating point number
0xf.6e9d495182a9931p+3

printf '%s\n' 'hello\tworld'
hello\tworld                      # escape 문자 처리 없이 그대로 출력

printf '%b\n' 'hello\tworld'
hello    world                     # escape 문자를 처리하여 출력

# 'bash -c CMD' 에서 실행하고자 하는 명령이 제대로 전달되지 않는다.
echo 'echo -e "first\nsecond"' | xargs -I CMD bash -c CMD
firstnsecond   # \n 처리가 되지 않는다.

printf '%q\n' 'echo -e "first\nsecond"'
# 실행결과: echo\ -e\ \"first\\nsecond\"

printf '%q\n' 'echo -e "first\nsecond"' | xargs -I CMD bash -c CMD
first
second
-----------------------------------------------------------------

cat commands.txt
echo -e "first\nsecond"
echo -e "third\nfourth"
echo -e "fifth\nsixth"

cat commands.txt |
while read -r line; do printf "%q\n" "$line"; done |
xargs --max-procs=4 -I CMD bash -c CMD
----------------------------------------------------------------

# ssh을 통해 공백이 있는 파일이름을 touch 명령의 인수로 올바르게 전달하기 위해
printf '%q ' touch "a test file" "another file"
touch a\ test\ file another\ file

sshc() {
        remote=$1; shift
        ssh "$remote" "$(printf '%q ' "$@")"
}

sshc user@server touch "a test file" "another file"

printf 'foo %%%s%%\n' bar
foo %bar%

printf '%c %c\n' abc def
a d

printf 'today is %(%Y-%m-%d)T\n'
today is 2015-08-31

printf '12345%n6789%n\n' num1 num2
123456789

echo $num1 $num2
5 9
```

#### Width

- `N` : field width를 설정한다.
- `*` : field width 값을 인수로 받을 수 있다.

```bash
printf '%d %d %d\n' 100 200 300
100 200 300
printf '%10d %10d %10d\n' 100 200 300         # field width를 10 으로 설정
       100        200        300
printf '%*d %*d %*d\n' 10 100 15 200 20 300   # 10, 15, 20은 각각 * 에 대응하는 값
       100             200                  300

printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM % 256)) $((RANDOM % 256))
DE:AD:BE:EF:DA:FA

# 구분선 만들기
printf -v sep '%*s' 50 ; echo "${sep// /-}"
--------------------------------------------------
```

#### Flags

- `-` : field width 내에서 값을 left 정렬한다. (default는 right 정렬)
- `0` : field width 에 맞게 zero padding 한다.
- `+` : 숫자에 + , - sign 기호를 붙여서 표시한다.
- `space` : +를 사용하지 않을경우 sign 자리에 space를 두어 정렬한다.
- `'` : 1000 의 자리마다 콤마를 넣어 표시한다. (bash only)
- `#` : alternative format을 사용할 수 있다.

```bash
printf '%10d %10d %10d\n' 100 200 300
       100        200        300
printf '%-10d %-10d %-10d\n' 100 200 300
100        200        300

printf '%06d\n' 12 345 6789
000012
000345
006789

printf '%+10d %+10d %+10d\n' 100 -200 +300
      +100       -200       +300

printf '%d\n' 100 -200 +300
100
-200
300
printf '% d\n' 100 -200 +300
 100
-200
 300

LC_ALL=en_US.UTF-8 printf "%'d\n"  123456789
123,456,789
............................

bc <<< 2^64
18446744073709551616

LC_ALL=en_US.UTF-8 printf "%'.d\n" $( bc <<< 2^64 )      # %'.d
bash: printf: warning: 18446744073709551616: Numerical result out of range
9,223,372,036,854,775,807

LC_ALL=ko_KR.UTF-8 printf "%'.f\n" $( bc <<< 2^64 )      # %'.f
18,446,744,073,709,551,616
```

`%#o`은 값을 octal number로 표시할때 앞에 0을 붙인다.

```bash
printf '%#o\n' 10
012
```

`%#x`, `%#X`은 값을 hexadecimal number로 표시할때 앞에 0x , 0X를 붙인다.

```bash
printf '%#x %#X\n' 10 30
0xa 0X1E
```

`%#g`, `%#G`은 precision 내에서 trailing zero를 붙인다.

```bash
printf '%g\n' 12.34
12.34
printf '%#g\n' 12.34
12.3400
```

#### Precision

`.`을 이용하면 왼쪽에는 field width를 오른쪽에는 precision을 설정할 수 있다.
field width 크기는 precision을 포함한다.

- `.N` : precision 값을 설정한다.
- `.*` : precision 값을 인수로 받을 수 있다.

```bash
printf '%f\n' 123.987654321
123.987654
printf '%.3f\n' 123.987654321    # precision을 3 으로 설정
123.988                            # 소수 넷째 자리에서 반올림이 된다
printf '%.*f\n' 3 123.987654321  # '*'을 이용하여 precision 값을 인수로 받음
123.988
```

`%f`와 `%g`는 precision 값을 처리하는 방식이 다르다.  
`%f`는 소수점 이후의 개수를 나타내고 `%g`는 전체 유효숫자 개수를 나타낸다.

```bash
printf '%.5f\n' 123.12345678  # 소수점 이후 5개
123.12346

printf '%.5g\n' 123.12345678  # 전체 유효숫자 5개
123.12

printf '%.5f\n' 0.0012345678
0.00123

printf '%.5g\n' 0.0012345678
0.0012346
```

`%s`에서의 사용은 출력 문자수를 제한한다.

```bash
printf '%s\n' foobarzoo
foobarzoo

printf '%.5s\n' foobarzoo
fooba

printf '%.*s\n' 5 foobarzoo
fooba

# %.s 또는 %.0s는 해당 인수를 출력에서 제외하는 효과가 있습니다.
printf '%d%d%.s%.0s%d\n' 11 22 33 44 55
112255
```

#### Examples

0 ~ 127 까지 숫자를 decimal, octal, hexadecimal로 출력하기

```bash
for ((x=0; x <= 127; x++)); do
>  printf '%3d | %04o | 0x%02x\n' $x $x $x
> done
  0 | 0000 | 0x00
  1 | 0001 | 0x01
  2 | 0002 | 0x02
...
...
125 | 0175 | 0x7d
126 | 0176 | 0x7e
127 | 0177 | 0x7f
```

1 ~ 2 자리로 되어있는 hexadecimal number를 2 자리로 맞추기

```bash
mac_addr="0:13:ce:7:7a:ad"

printf '%02x:%02x:%02x:%02x:%02x:%02x\n' 0x${mac_addr//:/ 0x}
00:13:ce:07:7a:ad
```

현재 라인 우측 끝에 메시지 출력하기
`tput cols`은 현재 터미널 columns 수를 출력. `echo $COLUMNS`과 동일

```bash
# bash
printf '%*s\n' $COLUMNS "hello world"

# sh
printf '%*s\n' $(tput cols) "hello world"
```

### print

zsh에서만 사용할 수 있는 내장 명령어

#### Format

`command [-option] ( formal or non formal — remembering name )`

#### print -a (align)

> -a
>
> 컬럼 증가를 먼저 표시하는 인자를 출력한다. `-c` 및 `-C` 옵션과 함께 사용하는 것이 유용

```bash
print -a -c "Alice" "Bob" "Carol" "\nDavid" "Eric" "Fred"
Alice  Bob    Carol
David  Eric   Fred
```

#### print -C (Cols)

> -C cols
>
> 인자를 cols 열에 맞춰 출력한다. -a 옵션이 주어지지 않는 한, 행을 먼저 증가시켜 인자를 출력

```bash
print -C 2 Alice Bob Carol David Eric
Alice  David
Bob    Eric
Carol
```

#### print -D (Directory replacing)

> -D
>
> 인자를 경로로 처리하며, 디렉터리 접두어를 해당하는 디렉터리 이름에 대응되는 ~ 표현식으로 대체

```bash
print -D /Users/yuma/tmp ~/tmp
~/tmp ~/tmp
```

#### print -i (independently)

> -i
>
> -o 또는 -O와 함께 주어지면 대소문자를 구분하지 않고 정렬

Sorting

ASC

```bash
print -i -o Bob Carol Alice
Alice Bob Carol
```

DESC

```bash
print -i -O Bob Carol Alice
Carol Bob Alice
```

#### print -l

```bash
print -l "Alice" "Bob" "Carol"
Alice
Bob
Carol
```

#### print -m

```bash
print -m "Bob" "Alice" "Bob" "Carol"
Bob
```

#### print -n (no newline)

> 이 경우에 %는 줄 끝을 나타냄(no newline)

```bash
print -n "Alice"
Alice%
```

#### print -N (NULL)

> 인자를 널(null)로 구분하고 종료하여 출력

```bash
print -N "Alice" "Bob" "Carol"
AliceBobCarol%
```

#### print -p

> -p
>
> 인자를 coprocess의 입력으로 출력

#### print -P

> -P
>
> 프롬프트 확장을 수행(Prompt Expansion 참조)  
> '-f'와 함께 사용되면 프롬프트 이스케이프 시퀀스는 형식 문자열 내에서가 아니라 보간된 인자 내에서만 구문 분석됨

#### print -r

> -r
>
> echo의 이스케이프 규칙을 무시

#### print -R

> -R
>
> BSD echo 명령을 흉내 내며, -e 플래그가 주어지지 않으면 이스케이프 시퀀스를 처리하지 않음  
> -n 플래그는 뒤따르는 줄바꿈을 방지함  
> -R 이후에는 -e 및 -n 플래그만 인식되며, 다른 모든 인자와 옵션은 출력됨

#### print -s

> -s
>
> 결과를 표준 출력이 아닌 히스토리 목록에 넣음  
> print 명령에 대한 각 인자는 그 내용에 관계없이 히스토리에서 단일 단어로 처리됨

#### print -S

> -S
>
> 결과를 표준 출력이 아닌 히스토리 목록에 넣음  
> 이 경우에는 하나의 인자만 허용되며, 이는 마치 완전한 셸 명령 줄처럼 단어로 분할됨  
> 이 효과는 `HIST_LEX_WORDS` 옵션이 활성화된 상태에서 히스토리 파일에서 라인을 읽는 것과 유사함

```bash
print -S "Alice"
history | tail -n 1
28580  Alice
```

#### print -u

> -u n
>
> 인자를 파일 디스크립터 n으로 출력

#### print -v

> -v name
>
> 출력된 인자를 매개변수 이름의 값으로 저장

#### print -x

> -x tab-stop
>
> 출력된 문자열의 각 행에서 선행하는 탭을 확장하고, 탭 간격은 `tab-stop` 문자 수로 가정함  
> 이는 탭으로 들여쓰기된 코드를 서식 지정하는 데 적합함  
> 주의할 점은 `print`에 전달되는 모든 인자의 선행 탭이 확장되며, `print`가 인자를 분리할 때 스페이스를 사용하더라도 (열 카운트는 인자 간에 유지되지만 이전에 확장되지 않은 탭으로 인해 출력에서 오류가 발생할 수 있음) 첫 번째 인자뿐만 아니라 모든 인자의 선행 탭이 확장됨

> 각 print 명령의 출력 시작은 탭 스톱과 맞춰진 것으로 가정함  
> 멀티바이트 문자의 너비는 `MULTIBYTE` 옵션이 활성화된 경우 처리됨  
> 이 옵션은 다른 서식 옵션이 적용된 경우 무시되며, 구체적으로 열 맞춤 또는 `printf` 스타일이나 셸 히스토리 또는 명령 행 편집기와 같은 특수 위치로 출력되는 경우에도 무시됨

#### print -X

> -X tab-stop
>
> 이는 `-x`와 유사하지만 출력된 문자열의 모든 탭이 확장됨  
> 이는 인자의 탭이 테이블 형식을 생성하는 데 사용되는 경우에 적합함

#### print -z

> `echo Alice`는 명령 결과의 표준 출력(stdout)이 아닌 콘솔 입력 버퍼로 입력됨

```bash
print -z echo ABC
echo Alice
```

### 문자열 덧붙이기

변수에 `+=`를 사용하여 문자열을 덧붙일 수 있다.

```bash
string="Hell, "
string+="World!"
```

`printf`를 사용하는 방법

```bash
string="Hell, "
string=$(printf "%sWorld!" "$string")
```

## grep

입력으로 전달된 내용에서 특정 문자열을 찾는 명령어

### grep -v

입력에서 일치하는 패턴을 제외하고 출력하는 명령어 "반전(invert)" 또는 "부정(negate)"을 의미한다.

```bash
# 입력에서 "hell"을 제외하고 출력
grep -v "hell"
# 입력에서 "hell"로 시작하는 내용을 제외하고 출력
grep -v "^hell"
```

## tr

`tr` 명령어는 UNIX 및 Linux 시스템에서 사용되는 텍스트 변환 유틸리티이다.  
"translate"의 줄임말로, 텍스트 스트림에서 하나의 문자 집합을 다른 문자 집합으로 변환하는 데 사용된다.  
주로 텍스트의 형식을 변경하거나 문자열을 변환하는 데 사용된다.

```bash
# 기본 구문
tr [options] SET1 [SET2]
```

- SET1 : 변환할 문자 집합
- SET2 : 변환 후 문자 집합, 명령어에 따라 선택적으로 사용
- `-d` : SET1에 있는 문자 제거
- `-c` : SET1의 보충(complement)을 사용하여 매치되지 않는 문자를 변환
- `-s` : 연속된 중복 문자를 하나로 압축

### Examples

줄바꿈 문자를 공백 문자로 변경

```bash
echo "$string" | tr '\n' ' '
```

입력에서 모든 대문자를 소문자로 변환

```bash
echo "HELLO WORLD" | tr '[:upper:]' '[:lower:]'
```

입력에서 모든 공백을 제거

```bash
echo "Hello    World" | tr -d ' '
```

## ls

list의 약자로 현재 위치한 디렉터리에 있는 내용(디렉터리, 파일) 리스트를 출력하는 명령어
디렉터리 이름을 생략하면 현재 위치한 디렉터리의 파일 목록을 출력
숨겨진 파일은 기본적으로 출력되지 않음

- `-l` : 상세 출력(권한, 파일 수, 소유자, 그룹, 파일크기, 수정일자, 파일이름)
  - `-h` : 파일 크기를 알아보기 편하게 K, M, G 단위 출력(`-l` 옵션이 있어야 적용됨)
  - `-u` : mtime (수정 시간)을 atime(접근 시간)을 출력 (default는 수정 시간)(`-l` 옵션이 있어야 적용됨)
    - `-lt`와 같이 사용시 생성 시간 기준으로 출력하고 `-l`과 사용시 생성시간 출력이름순으로 출력
  - `-c` : mtime (수정 시간)을 ctime(변경 시간)을 출력 (default는 수정 시간)(`-l` 옵션이 있어야 적용됨)
- `-a` : 숨김 파일을 포함한 모든 파일 출력(`.`,`..` 폴더 포함)
- `-A` : 숨김 파일을 포함한 모든 파일 출력(`.`,`..` 폴더 제외)
- `-R` : 위치한 디렉터리의 하부 디렉터리 파일까지 모두 출력
- `-r` : 출력 결과를 내림차순으로 정렬
- `-t` : 출력 결과를 파일이 수정된 시간을 기준으로 정렬
- `-d` : 지정 경로에 있는 최상위 디렉터리의 목록만 출력
- `-b` : 알파벳 순으로 목록을 출력
- `-r` : 반대로 출력 (default는 알파벳 순서)
- `-p` : 디렉터리에 /를 추가
- `-B` : `~`로 끝나는 백업파일을 제외하고 목록을 출력
- `-c` : 마지막으로 변경된 시간을 목록을 출력
- `-C` : 파일이나 디렉터리를 열로 목록을 출력
- `-f` : 정렬하지 않고 출력 컬러를 해제
- `-F` : 실행파일은 `\*`, 경로 `/`, 소켓 `=`, 링크 `@` 등의 지시자로 출력
- `-g` : 사용자 권한을 출력하지 않는다.
- `-G` : `-l` 과 같이 사용시 그룹권한을 출력하지 않는다.(bash only)
  - zsh에서 사용할 경우 : 단독 사용이 가능하며, 파일과 폴더 이름에 색을 더해서 구분하기 편하게 출력
- `-H` : 심볼릭 링크의 실제 참조하는 목록을 출력
- `-i` : 파일의 inode number를 출력
- `-m` : `,`로 구분하여 출력, `-l` 옵션과 같이 사용하면 해당 옵션을 무시함
- `-n` : 사용자와 그룹권한을 숫자로 표시
- `-R` : 하위 디렉터리까지 출력
- `-s` : 블록에 할당된 크기를 출력
- `-S` : 파일 크기 순으로 정렬하여 출력
- `-t` : 파일이 수정된 시간 기준으로 정렬하여 출력
- `-T` : 8대신 COLS을 지정하여 출력
- `-w` : width 길이를 설정하여 출력(zsh에서 어떤 기능인지 확인 필요)
- `-x` : 상세출력되는 리스트를 파일 이름으로 하나의 라인에 출력(zsh에서 어떤 기능인지 확인 필요)
- `-k` : 용량을 킬로바이트로 출력(zsh에서 어떤 기능인지 확인 필요)
- `-U` : 컬러을 유지하면서 정렬하지 않고 출력(zsh에서 어떤 기능인지 확인 필요)
- `-I` : 특정 파일이나 디렉터리를 제외하고 출력(zsh에서 어떤 기능인지 확인 필요)
- `-L` : 심볼릭 링크의 정보를 출력할때 원본 파일의 정보를 출력(zsh에서 어떤 기능인지 확인 필요)
- `-q` : 그래픽이 아닌 문자 대신에 ?를 출력(zsh에서 어떤 기능인지 확인 필요)
- `-Q` : 파일, 디렉터리를 쌍따옴표 안에 출력(bash only)
- `-D` : emacs를 위한 출력행태를 생성(bash only)
- `-X` : 확장자의 알파벳순으로 정렬하여 출력(bash only)
- `-Z` : SELinux 보안 모듈을 출력(bash only)
- `--color=when` : 출력할 문자열에 색상 값의 유무를 결정
  - `never` : 색상 없음

## Conditional(조건문)

주어진 조건에 따라 분기를 다르게 하는 제어문

### Format

```bash
if [ 조건 ]; then
    # 조건이 참일 때 실행되는 명령들
elif [ 다른조건 ]; then
    # 다른조건이 참일 때 실행되는 명령들
else
    # 모든 조건이 거짓일 때 실행되는 명령들
fi
```

### -n

`-n` : 조건 테스트(test)를 수행, 주어진 문자열이 비어 있지 않은 경우에 참(true)을 반환.

- `[` 뒤에 써야 한다.

### Examples

```bash
if [ $score -ge 90 ]; then
    echo "A"
elif [ $score -ge 80 ]; then
    echo "B"
elif [ $score -ge 70 ]; then
    echo "C"
else
    echo "F"
fi
```

## Loop(반복문)

### for Loop

> 지정된 범위 또는 리스트의 각 항목에 대해 반복

#### Format

```bash
for <var> in <range>; do
    # 반복할 명령어들
done
```

#### Examples

> 숫자 1부터 5까지 반복

```bash
for i in {1..5}; do
    echo "숫자: $i"
done
```

> 파일 목록을 순회하여 출력

```bash
for file in *.txt; do
    echo "파일: $file"
done
```

> 여러 폴더안에 존재하는 같은 이름의 파일 이름을 변경하는 예제

```bash
for dir in ~/Downloads/temp/*; do
    if [ -d "$dir" ]; then
        max_num=$(ls "$dir"/*.png | grep -Eo '[0-9]+' | sort -nr | head -n1)
        new_num=$((max_num + 1))
        mv "$dir/cover_or_extra_3.png" "$dir/${new_num}.png"
    fi
done
```

> 폴더 안의 숫자로 된 파일 이름을 일괄적으로 변경

```bash
dir="/Users/main/Downloads/temp/葬送のフリーレン10"

for i in {3..210}; do
    old_file="$i.png"
    new_number=$((i - 2))
    new_file="${new_number}.png"

    if [ -f "${dir}/$old_file" ]; then
        mv "${dir}/$old_file" "${dir}/$new_file"
    fi
done
```

> 파일 이름에 포함된 글자를 다른 글자로 대체하는 반복문
>
> - `${variable//pattern/replacement}`
>   > - variable : 처리할 변수
>   > - // : 해당 패턴을 모두 변경, /은 한 번만 변경
>   > - pattern : 변경할 패턴
>   > - replacement : 대체할 패턴

```bash
for file in *.pdf; do mv "$file" "${file// /_}"; done
```

> fdisk를 반복 실행하는 구문

```bash
enter=echo -e "\n"

for alpha in b c d e f g h i j;
do
	fdisk /dev/sd${alpha} <<EOF
	n
	p
	1
	${enter}
	${enter}
	t
	fd
	p
	w
EOF
done
```

### While Loop

> 조건이 참인 동안 반복
>
> - `[ ]` : 조건을 명시하는 명령어. 명령어이기 때문에 반드시 각각 공백 문자로 띄어줘야 한다.

#### Format

```bash
while [ 조건 ]; do
    # 반복할 명령들
done
```

#### Examples

> count가 5보다 작은 동안 반복

```bash
count=1

while [ $count -le 5 ]; do
    echo "숫자: $count"
    ((count++))
done
```

## Redirection

| <center>리다이렉션 기호</center> | <center>방향</center> | <center>의미</center>                                  |
| -------------------------------- | --------------------- | ------------------------------------------------------ |
| `>`                              | 표준 출력             | 명령 > 파일 : 명령의 결과를 파일로 저장                |
| `>>`                             | 표준 출력(추가)       | 명령 >> 파일 : 명령의 결과를 기존 파일에 추가하여 저장 |
| `<`                              | 표준 입력             | 명령 < 파일 : 파일의 내용을 명령에 입력                |

## 파일 출력

### cat

concatenate의 약자로써 본래의 기능은 여러 파일의 내용을 하나로 합치는 역할  
파일의 내용을 단순히 출력하거나 `>`, `>>`와 같은 리다이렉션 기호와 함께 사용하여 파일 생성 및 저장도 가능

- `-n` : 줄번호를 화면 왼쪽에 나타낸다. 비어있는 행도 포함
- `-b` : 줄번호를 화면 왼쪽에 나타낸다. 비어있는 행은 제외
- `-e` : 제어 문자를 ^ 형태로 출력하면서 각 행의 끝에 $를 추가
- `-s` : 연속되는 2개 이상의 빈 행을 한 행으로 출력
- `-v` : tab과 줄바꿈 문자를 제외한 제어 문자를 ^ 형태로 출력
- `-E` : 행마다 끝에 $ 문자를 출력(bash only)
- `-T` : tab 문자를 출력(bash only)
- `-A` : `-vET` 옵션을 사용한 것과 동일(bash only)

```bash
# 기본 구문
cat [옵션][파일명]

# 한개의 파일을 화면에 출력
cat file.txt
# 여러개의 파일을 화면에 출력
cat file1.txt file2.txt file3.txt

# file의 내용을 new_file라는 이름으로 생성
cat file > new_file
# file1 + file2 + file3 내용을 new_file라는 이름으로 생성
cat file1 file2 file3 > new_flie
# file2의 내용을 file1에 추가함
cat file2 >> file1

# file.txt에 new content라는 내용 입력 후 저장(CTRL + C로 종료)
cat > file.txt
new content
# file.txt에 new content라는 내용 추가 후 저장(CTRL + C로 종료)
cat >> file.txt
new content

# 파일의 내용을 모니터 화면 크기에 맞추기 cat + more
cat fileName | more
# 파일 내용을 vim editor로 확인 cat + less
cat fileName | less
```

### head

### tail

입력의 마지막 행을 기준으로 지정한 행까지의 입력 내용 일부를 출력하는 명령어
기본값으로 마지막 10줄을 출력한다.

- `-f` : `tail`을 종료하지 않고 업데이트 내용을 계속 출력한다.
- `-n (line number)` : 마지막 줄부터 지정한 line number까지 출력
- `-c (byte number)` : 마지막 줄부터 지정한 바이트만큼의 내용 출력
- `-q` : 입력의 헤더와 상단의 파일 이름을 출력하지 않고 내용만 출력
- `-v` : 출력하기 전에 헤더와 파일 이름 먼저 출력하고 내용을 출력

```bash
# 기본 구문
tail [option][filename]

# 기본
tail filename.txt
# 실시간 출력
tail -f filename
# 실시간 로그 보기
tail -f mylog.log | grep 192.168.15.86
# 여러 파일 동시 출력
tail mylog1.log mylog2.log
```

## 파일 찾기

### find

> 파일 시스템을 검색하여 특정 조건에 맞는 파일을 찾는 데 사용

> - `./` : 여러 폴더들이 들어 있는 상위 디렉터리 경로
> - `-name` : 찾고자 하는 파일의 이름을 지정
> - `-execdir` : find 명령어로 찾은 파일들에 대해 실행할 명령어를 지정
>   > - `{}` : find로 찾은 각 파일을 가리키며, `mv {} <filename>`은 해당 파일의 이름을 `<filename>`로 변경
>   > - `\;` : 명령어의 끝을 의미

```bash
find ./ -name <search_name> -execdir mv {} <filename> \;
```

## 파일 복사

### cp

> 가장 기본적인 파일 복사

```bash
cp <source> <target>
```

### scp

> ssh를 이용한 원격 파일 복사

```bash
scp -i "keypair.pem" <source> <user>@<IP Address or Domain>:<target>
```

### rsync

rsync를 이용한 원격 파일 동기화  
rsync는 SSH를 통한 파일 동기화 명령어다.  
실시간 동기화 기능을 제공하는 lsyncd보다는 강력하지 않으며, 한 대의 컴퓨터에서 여러 대의 대상을 백업하는 rsnapshot만큼 유연하지 않다.  
그러나 정의한 일정에 따라 두 대의 컴퓨터를 최신 상태로 유지할 수 있는 기능을 제공한다.

> - `-a` : [archive] rsync를 사용하는 가장 일반적인 옵션으로, 아래의 여러 옵션을 포함하고 있다.
>   > - `-r` : 디렉터리 재귀
>   > - `-l` : 심볼릭 링크를 심볼릭 링크로 유지
>   > - `-p` : 권한 유지
>   > - `-t` : 수정 시간 유지
>   > - `-g` : 그룹 유지
>   > - `-o` : 소유자 유지
>   > - `-D` : 장치 파일 유지
> - `-v` : 전송 중인 모든 파일을 나열
> - `-e` : 사용할 원격 셸 지정
> - `-z` : 전송 중 압축을 활성화
> - `-n` : Dry-Run을 실행하여 전송할 파일을 확인
> - `-m` : 전송할 때 빈 디렉터리 제외
> - `-vvv` : 파일을 전송하는 동안 디버그 정보 제공
> - `--delete` : 대상 디렉터리에 소스에 없는 파일이 있으면 제거한다.
> - `--exclude` : 파일의 상대 경로를 통해 특정 파일을 전송에서 제외한다.
>   > - 여러 파일이나 디렉터리를 제외하려면 여러번 사용할 수 있다.
>   > - 단일 옵션으로 사용하려면 쉼표로 구분된 {}에 제외할 파일을 나열한다.
>   > - `--exclude={'file1.txt','dir1/*','dir2'}`
>   > - `--exclude-from` : 제외할 파일의 수가 많은 경우, txt 파일로 제외할 파일을 지정하고 exclude-from 옵션에 전달할 수 있다.
>   > - `--exclude-from='exclude-file.txt'`
>   >   > ```
>   >   > # exclude-file.txt
>   >   > file1.txt
>   >   > dir1/*
>   >   > dir2
>   >   > ```
> - `--files-from=-` : 표준 입력의 파일(find 명령으로부터 전달받은 파일)만 포함한다.

```bash
rsync -avz --delete -e 'ssh -p 22' <source> <User>@<IP Address or Domain>:<target>

rsync -e "ssh -i .aws/keypair.pem" --exclude=".git*" --exclude=".DS_Store" --exclude="__pycache__" -av <source> <User>@<IP Address or Domain>:<target>

find <source_dir> -name "*.jpg" -printf %P\\0\\n | rsync -a --files-from=- <source> <target>
```

## Link

### Soft/Symbolic link

> 다른 파일이나 폴더를 가리키는 링크
>
> - Windows OS의 '바로가기'와 유사

```bash
ln -s <source> <target>
```

## Public IP 확인

`curl ifconfig.me`

## SSH

Secure Shell
원격의 컴퓨터와 암호화된 통신을 주고받음

- `-i` : ssh 공개키 인증을 위한 파일 선택

```bash
ssh -i "~/coding/aws/.aws/NewKeyPair.pem" ikaman@ec2-3-34-107-69.ap-northeast-2.compute.amazonaws.com
```

## Compression

압축 형식을 압축률 좋은 순으로 나열:
`xz > bzip2 > gzip > compress`

### tar

Tape Archive를 위해 고안된 파일 형식과 이런 형식의 파일을 다루는데 사용하는 프로그램  
여러 개의 파일을 하나로 묶는 개념이며 기본적으로 압축을 하지 않는다.  
리눅스 환경에서 일반적으로 사용하며 다른 압축 패키지(gzip, bzip2, xz 등)와 함께 사용한다.  
옵션에 `-`을 붙이지 않아도 된다.

묶기:

```bash
tar -cf FILENAME.tar FILENAME
```

묶음풀기:

```bash
tar -xf FILENAME.tar
```

원하는 위치에 묶음풀기:

```bash
tar xvf FILENAME.tar -C /home/ikaman/testdir/
```

- `c`: 지정된 파일이나 디렉터리를 묶어 하나의 `.tar` 파일 생성
- `x`: `.tar` 파일 풀기
- `v`: 작업 중 대상 파일을 화면에 출력
- `f`: 작업 대상의 이름 지정
- `r`: 기존의 파일 안에 다른 파일 추가
- `t`: 묶인 파일의 목록 출력
- `p`: 권한(permisson)을 원본과 동일하게 유지
- `Z`: compress 패키지를 사용한 압축 옵션
- `z`: gzip 패키지를 사용한 압축 옵션
- `j`: bzip2 패키지를 사용한 압축 옵션
- `J`: xz 패키지를 사용한 압축 옵션

### gzip

GNU zip으로 GNU에서 만든 압축 프로그램이다. compress를 대체하기 위해 만들어졌으며  
압축률 조정 등 다양한 기능을 제공한다.  
리눅스 환경에서 일반적으로 사용하며 주로 `tar` 명령어와 함께 사용한다.

압축:

```bash
gzip FILENAME
tar zcvf FILENAME.tar.gz FILENAME
```

압축된 파일 내용 확인:

```bash
zcat FILENAME
```

압축해제:

```bash
gzip -d FILENAME
gunzip FILENAME
tar zxvf FILENAME.tar.gz
# 원하는 위치에 압축해제
tar zxvf FILENAME.tar.gz -C /home/ikaman/testdir/
```

- `d`: 압축해제
- `1~9`: 압축 레벨. 숫자가 작을 수록 압축률이 줄고 소요시간이 줄어든다.
- `l`: 압축 파일의 정보 출력
- `r`: 압축 대상이 디렉터리라면 하위 디렉터리까지 모두 압축
- `v`: 진행과정을 %와 함께 자세히 출력

### bzip2

줄리안 시워드가 만든 압축 패키지로 버로우즈-휠러 변환 블록정렬 알고리즘과 허브만 부호화를 사용한 압축 프로그램이다.  
기본적인 사용법은 `-l` 옵션을 제외하고 gzip과 동일하며 gzip보다 압축률이 높지만 압축 시간도 길다.  
리눅스 환경에서 일반적으로 사용하며 주로 `tar` 명령어와 함께 사용한다.

압축:

```bash
bzip2 FILENAME
tar jcvf FILENAME.tar.gz FILENAME
```

압축된 파일 내용 확인:

```bash
zcat FILENAME
```

압축해제:

```bash
bzip2 -d FILENAME
bunzip2 FILENAME
tar jcvf FILENAME.tar.gz
# 원하는 위치에 압축해제
tar jxvf FILENAME.tar.gz -C /home/ikaman/testdir/
```

- `d`: 압축해제
- `1~9`: 압축 레벨. 숫자가 작을 수록 압축률이 줄고 소요시간이 줄어
- `r`: 압축 대상이 디렉터리라면 하위 디렉터리까지 모두 압축
- `v`: 진행과정을 %와 함께 자세히 출력
- `f`: 존재하는 파일 덮어쓰기
- `c`: 결과를 표준 출력으로 보낼 때 사용한다. `tar`와 함께 쓸 때 사용
- `t`: 압축 파일을 검사

### xz

LZMA2 알고리즘을 이용하여 만든 데이터 무손실 압축 프로그램이다.  
gzip, bzip2보다 높은 압축률을 보여주어 공개용 소프트웨어 사이트에서 이 압축 포맷을 사용하여 파일을 배포한다.  
기본적인 사용법은 gzip, bzip2와 같다.

압축:

```bash
xz FILENAME
tar Jcvf FILENAME
```

압축된 파일 내용 확인:

```bash
zcat FILENAME
```

압축해제:

```bash
xz -d FILENAME
unxz FILENAME
tar Jcvf FILENAME.tar.gz
# 원하는 위치에 압축해제
tar Jxvf FILENAME.tar.gz -C /home/ikaman/testdir/
```

- `z`: 압축할 때 사용하는 옵션. 기본적으로 설정되어 있으므로 사용하지 않아도 됨
- `d`: 압축해제

### zip

Windows 환경에서 일반적으로 사용하는 압축 확장자

- 장점: 거의 대부분의 OS에서 호환된다.
- 단점: 용량 압축이 비교적 낮다.

압축:

```bash
zip -r FILENAME.zip FILENAME
```

압축해제:

```bash
unzip FILENAME.zip
```

## Troubleshooting

### 한글이 ???로 보이는 경우

```bash
# .zshenv

export LANG=ko_KR.UTF-8
```

## Make use of script

### sshd_update

> 팀프로젝트 GATI의 서버 운영 중, 팀원들이 내 AWS 서버에 ssh로 접속할 수 있도록 설정하기위해 작성한 스크립트

```bash
#!/bin/bash

# DDNS 주소 설정
DDNS_ADDRESS="<Domain>"

# DDNS 주소로부터 IP 주소 가져오기
IP=$(nslookup $DDNS_ADDRESS | awk '/^Address: / { print $2 }')

# sshd_config 파일 백업
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# AllowUsers 라인 업데이트
sed -i "s/^AllowUsers .*$/AllowUsers <user1>@<IP Address> <user2>@<IP Address> ec2-user@$IP ikaman@$IP/" /etc/ssh/sshd_config

# SSH 서비스 재시작
/usr/sbin/service sshd restart
```

### 파일 분할

> 졸업작품이자 첫 팀프로젝트인 GATI를 진행하던중, 네이버 뉴스를 스크래핑한 csv파일의 용량이 너무 커서 분할하기 위해 작성한 스크립트

```bash
# 파일 이름 정의
file_name="article.csv"

# 분할할 그룹 수
n=5

# 파일 총 행 수 구하기
total_rows=$(wc -l < $file_name)
chunk_size=$((total_rows / n))

# 파일을 n 그룹으로 분할하고 .csv 확장자를 붙여서 저장
split -l $chunk_size $file_name chunk_
for file in chunk_*
do
    mv "$file" "$file.csv"
done

# 헤더를 가진 파일 생성
header_file="header.csv"
head -n 1 $file_name | tr -d '\r' > $header_file

# 각 분할 파일에 헤더 추가
for file in chunk_*.csv; do
	if [[ "$file" != "chunk_aa.csv" ]]; then
        # 임시 파일 생성
        tmp_file=$(mktemp)

        # 헤더 추가
        cat "$header_file" "$file" > "$tmp_file" && mv "$tmp_file" "$file"
    fi
done

# 임시 헤더 파일 삭제
rm $header_file
```

### namechanger

> 각 만화의 이미지 파일들의 이름을 일관성있게 유지하기 위해 작성한 파일 이름 변경 스크립트

```bash
cd ~/Desktop/temp

for folder in 僕の心のヤバイやつ*; do
	# 현재 폴더 안에 cover_1.jpg 파일이 존재하는지 확인하는 조건문
	# -f는 파일이 존재하는지 여부를 확인하는 파일 테스트 연산자
   if [ -f "$folder/cover_1.jpg" ]; then
      mv "$folder/cover_1.jpg" "$folder/0_0.jpg"
      echo "Renamed $folder/cover_1.jpg to $folder/0_0.jpg"
   else
      echo "No cover_1.jpg file found in $folder"
   fi

   if [ -f "$folder/cover_or_extra_1.png" ]; then
      mv "$folder/cover_or_extra_1.png" "$folder/0_1.jpg"
      echo "Renamed $folder/cover_or_extra_1.png to $folder/0_1.jpg"
   else
      echo "No cover_or_extra_1.png file found in $folder"
   fi


done
```

## Packages

### code-server

homebrew로 설치했을 때 로그 경로

`/opt/homebrew/var/log/code-server.log`

설정 파일

```bash
# $HOME/.config/code-server/config.yaml
bind-addr: 127.0.0.1:<port>
auth: password
password: <password>
cert: /path/to/pem/fullchain.pem
cert-key: /path/to/pem/privkey.pem
user-data-dir: /Users/main/coding
```

- `bind-addr` : 서비스할 주소. 기본값은 `127.0.0.1`
  - 외부 허용: `0.0.0.0`
- `auth` : 패스워드 사용 여부. 기본값은 `password`
  - `none` : 패스워드 없이 접속
- `password` : 사용할 패스워드
- `cert` : https를 사용할지 여부. 기본값은 `false`
  - `true` : https를 사용한다.
  - TSL 인증서의 경로를 입력하면 해당 인증서를 사용한다.
- `cert-key` : TSL 인증서의 private key 경로
- `user-data-dir` : 접속했을 때 workspace를 설정하는 옵션?(확인 필요, 작동 안 하는 듯)

homebrew를 이용한 서버 실행 및 중지

```bash
# 실행 중인 서비스 목록 출력
brew services

# 서버 실행
brew services start code-server
# 서버 중지
brew services stop code-server
```

### certbot

인증서 발급

- 80 포트의 포트포워딩이 필요함

```bash
sudo certbot --standalone -d <domain>
```

인증서 갱신 스크립트

```bash
# 인증서 갱신
certbot renew

# certbot-auto-renew.sh
/opt/homebrew/bin/certbot renew
# 인증서 복사 후 소유자 변경
cp /etc/letsencrypt/live/<domain>/fullchain.pem /path/to/pem
cp /etc/letsencrypt/live/<domain>/privkey.pem /path/to/pem
chown <user> /path/to/pem/fullchain.pem
chown <user> /path/to/pem/privkey.pem
```

- 소유자를 바꾸는 이유: 인증서가 root 계정의 소유로 발급되어, 다른 사용자에서 `privkey.pem` 파일에 접근할 수 없었다.
- 읽기 권한을 모든 사용자에게 주면 의도에 맞지 않을(보안 문제) 것으로 생각하여 소유자를 변경했다.

crontab

```bash
# root 계정에 cron 스케쥴 등록
sudo crontab -e
0 0 5 7,10,1,4 * /Users/<user>/certbot-auto-renew.sh >/dev/null 2>&1
```

로그 경로

```bash
/var/log/letsencrypt/letsencrypt.log
```

인증서 경로

- Certificate is saved at: `/etc/letsencrypt/live/<domain>/fullchain.pem`
- Key is saved at: `/etc/letsencrypt/live/<domain>/privkey.pem`

### duckdns

```bash
# homebrew core repository 이외의 repo 추가
brew tap jzelinskie/duckdns
brew install duckdns
```

### Nginx

Docroot is: `/opt/homebrew/var/www`  
기본 포트는 `/opt/homebrew/etc/nginx/nginx.conf`에 `8080`으로 설정되어 있으므로 `sudo` 없이 nginx를 실행할 수 있다.

nginx는 `/opt/homebrew/etc/nginx/servers/.`의 모든 파일을 로드한다.

nginx 시작, 종료, 재시작

- homebrew services는 started 상태인 경우 로그아웃 후 로그인해도 자동 재시작되어 있음

```bash
brew services start nginx
brew services stop nginx
brew services restart nginx
```

또는 백그라운드 서비스가 필요하지 않은 경우 다음과 같이 실행:

```bash
/opt/homebrew/opt/nginx/bin/nginx -g daemon\ off\;
```

설정 파일

```bash
# /opt/homebrew/etc/nginx/nginx.conf

worker_processes auto;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    # 정적 파일 제공 최적화
    sendfile on;
    # 클라이언트로 패킷 전송전에 버퍼가 다 찼는지 확인하고, 다 찼을 때 패킷을 전송하도록하여 네트워크 오버헤드 줄임
    tcp_nopush on;
    # 소켓이 패킷 크기에 상관없이 버퍼에 데이터를 보냄
    tcp_nodelay on;
    # 클라이언트가 커넥션을 유지하는 시간
    keepalive_timeout 65;
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript;

    # $http_host 변수를 사용하여 클라이언트가 요청한 호스트 이름을 가져옴
    map $http_host $ssl_cert {
        default /path/to/ssl.pem;
    }

    server {
        listen 80;
        listen [::]:80;
        server_name <domain> www.<domain>;

        if ($http_x_forwarded_proto != 'https') {
            # 301은 리다이렉트를 의미: 사용자가 http(80번 포트)로 들어오면 https(443)로 리다이렉트
            return 301 https://$host$request_uri;
        }
    }

    server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name <domain> www.<domain>;

        ssl_certificate      $ssl_cert;;
        ssl_certificate_key  /path/to/ssl.key;

        location /nextjs-app/ {
            proxy_pass http://localhost:3000/;
            proxy_redirect off;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection upgrade;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Host $server_name;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Accept-Encoding gzip;
        }

        location /code-server/ {
            proxy_pass http://localhost:22223/;
            proxy_redirect off;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection upgrade;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Host $server_name;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Accept-Encoding gzip;
        }
    }
}
```

일반적으로 웹 서버는 HTTP 요청을 기본 포트인 80번 포트로 받는다.  
그리고 보안을 위해 HTTPS를 사용하는 경우, 클라이언트가 80번 포트로 HTTP 요청을 보내면  
서버는 이를 자동으로 HTTPS로 리디렉션하여 보안 연결을 설정한다.  
이를 **HTTP to HTTPS 리디렉션**이라고 한다.

이렇게 하면 사용자들이 브라우저에 `https://example.com`과 같이 URL을 입력하지 않고,  
`http://example.com`과 같이 HTTP로 입력하더라도 서버가 자동으로 HTTPS로 리디렉션하여 보안 연결을 설정한다.  
이는 사용자 경험과 보안 측면에서 중요한 요소다.
따라서 대부분의 경우, HTTPS를 사용하는 웹 사이트는 80번 포트로 들어오는 모든 요청을 443번 포트로 리디렉션하도록 구성한다.

### Openssl

key의 format 확인

```bash
# RSA 알고리즘
openssl rsa -in privkey.pem -text -noout
```

`.pem` 파일을 `.key` 파일로 출력

```bash
# RSA 알고리즘
openssl rsa -in privkey.pem -out private.key
# ECDSA 형식
openssl ec -in privkey.pem -out private.key
```
