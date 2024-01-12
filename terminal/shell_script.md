# Linux/MacOS Shell Script

# Environment Variable / 환경변수
> 셸에서 사용하는 환경변수를 선언할 수 있다.
> - 변수의이름과 '=' 그리고 값 사이에 공백이 존재하면 안 된다.
```
<variable_name>=<value>
```

# String / 문자열
> echo : 문자열 출력 명령어
> - -n : 마지막에 붙는 개행 문자(newline) 문자를 출력하지 않음
> - -e : 문자열에서 백슬래시(\)와 이스케이프 문자를 인용 부호(")로 묶어 인식
> - -E : 문자열에서 백슬래시와 이스케이프 문자를 비활성화(default)
> - '>' : 리다이렉션, 해당 경로에 파일이 존재하지 않으면 echo의 출력 내용으로 새 파일 생성  
> 존재한다면 출력 내용으로 파일을 '덮어쓰기'로 저장
> - '>>' : 리다이렉션, 해당 경로에 파일이 존재하지 않으면 echo의 출력 내용으로 새 파일 생성  
> 존재한다면 출력 내용으로 파일을 '이어쓰기'로 저장
> - :r : 환경변수의 이름만 추출하는 명령어
> - :e : 환경변수의 확장자만 추출하는 명령어
```
echo "<text>"
echo "<text>" > <file_name>
echo "<text>" >> <file_name>
echo $variable
echo ${variable:r}
echo ${variable:e}
```

# Conditional / 조건문
> 주어진 조건에 따라 분기를 다르게 하는 제어문

> 기본 구조
```
if [ 조건 ]; then
    # 조건이 참일 때 실행되는 명령들
elif [ 다른조건 ]; then
    # 다른조건이 참일 때 실행되는 명령들
else
    # 모든 조건이 거짓일 때 실행되는 명령들
fi
```
> 예시
```
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

# Loop / 반복문

## for Loop
> 지정된 범위 또는 리스트의 각 항목에 대해 반복

> 기본 구조
```
for <var> in <range>; do
    # 반복할 명령어들
done
```
> 숫자 1부터 5까지 반복
```
for i in {1..5}; do
    echo "숫자: $i"
done
```
> 파일 목록을 순회하여 출력
```
for file in *.txt; do
    echo "파일: $file"
done
```

> 여러 폴더안에 존재하는 같은 이름의 파일 이름을 변경하는 예제
```
for dir in ~/Downloads/temp/*; do
    if [ -d "$dir" ]; then
        max_num=$(ls "$dir"/*.png | grep -Eo '[0-9]+' | sort -nr | head -n1)
        new_num=$((max_num + 1))
        mv "$dir/cover_or_extra_3.png" "$dir/${new_num}.png"
    fi
done
```
> 폴더 안의 숫자로 된 파일 이름을 일괄적으로 변경
```
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
> - ${variable//pattern/replacement}
>   > - variable : 처리할 변수
>   > - // : 해당 패턴을 모두 변경, /은 한 번만 변경
>   > - pattern : 변경할 패턴
>   > - replacement : 대체할 패턴
```
for file in *.pdf; do mv "$file" "${file// /_}"; done
```

## While Loop
> 조건이 참인 동안 반복
> - [ ] : 조건을 명시하는 명령어. 명령어이기 때문에 반드시 각각 공백 문자로 띄어줘야 한다.

> 기본 구조
```
while [ 조건 ]; do
    # 반복할 명령들
done
```

> count가 5보다 작은 동안 반복
```
count=1

while [ $count -le 5 ]; do
    echo "숫자: $count"
    ((count++))
done
```
# 파일 찾기

## find
> 파일 시스템을 검색하여 특정 조건에 맞는 파일을 찾는 데 사용

> - ./ : 여러 폴더들이 들어 있는 상위 디렉토리 경로
> - -name : 찾고자 하는 파일의 이름을 지정
> - -execdir : find 명령어로 찾은 파일들에 대해 실행할 명령어를 지정
>   > - {} : find로 찾은 각 파일을 가리키며, 'mv {} \<filename\>'은 해당 파일의 이름을 \<filename\>로 변경
>   > - '\\;' : 명령어의 끝을 의미
```
find ./ -name <search_name> -execdir mv {} <filename> \;
```

# 파일 복사

## cp
> 가장 기본적인 파일 복사  
```
cp <source> <target>
```  
## scp
> ssh를 이용한 원격 파일 복사  
```
scp -i "keypair.pem" <source> <user>@<IP Address or Domain>:<target>
```
## rsync
> rsync를 이용한 원격 파일 동기화  
> - rsync는 SSH를 통한 파일 동기화 명령어다.  
> 실시간 동기화 기능을 제공하는 lsyncd보다는 강력하지 않으며, 한 대의 컴퓨터에서 여러 대의 대상을 백업하는 rsnapshot만큼 유연하지 않다.  
그러나 정의한 일정에 따라 두 대의 컴퓨터를 최신 상태로 유지할 수 있는 기능을 제공한다.
> - -a : [archive] rsync를 사용하는 가장 일반적인 옵션으로, 아래의 여러 옵션을 포함하고 있다.  
>   > - -r : 디렉터리 재귀
>   > - -l : 심볼릭 링크를 심볼릭 링크로 유지
>   > - -p : 권한 유지
>   > - -t : 수정 시간 유지
>   > - -g : 그룹 유지
>   > - -o : 소유자 유지
>   > - -D : 장치 파일 유지
> - -v : 전송 중인 모든 파일을 나열
> - -e : 사용할 원격 셸 지정
> - -z : 전송 중 압축을 활성화
> - -n : Dry-Run을 실행하여 전송할 파일을 확인
> - -m : 전송할 때 빈 디렉터리 제외
> - -vvv : 파일을 전송하는 동안 디버그 정보 제공
> - --delete : 대상 디렉터리에 소스에 없는 파일이 있으면 제거한다.  
> - --exclude : 파일의 상대 경로를 통해 특정 파일을 전송에서 제외한다.  
>   > - 여러 파일이나 디렉터리를 제외하려면 여러번 사용할 수 있다.
>   > - 단일 옵션으로 사용하려면 쉼표로 구분된 {}에 제외할 파일을 나열한다.
>   > - ```--exclude={'file1.txt','dir1/*','dir2'}```  
>   > - --exclude-from : 제외할 파일의 수가 많은 경우, txt 파일로 제외할 파일을 지정하고 exclude-from 옵션에 전달할 수 있다.
>   > - ```--exclude-from='exclude-file.txt'```
>   >   > ```
>   >   > # exclude-file.txt
>   >   > file1.txt
>   >   > dir1/*
>   >   > dir2
>   >   > ```
> - --files-from=- : 표준 입력의 파일(find 명령으로부터 전달받은 파일)만 포함한다.  
```
rsync -avz --delete -e 'ssh -p 22' <source> <User>@<IP Address or Domain>:<target>  

rsync -e "ssh -i .aws/keypair.pem" --exclude=".git*" --exclude=".DS_Store" --exclude="__pycache__" -av <source> <User>@<IP Address or Domain>:<target>

find <source_dir> -name "*.jpg" -printf %P\\0\\n | rsync -a --files-from=- <source> <target>
```  

# Link

## Soft/Symbolic link
> 다른 파일이나 폴더를 가리키는 링크
> - Windows OS의 '바로가기'와 유사
```
ln -s <source> <target>
```

# SSH
> Secure Shell
> 원격의 컴퓨터와 암호화된 통신을 주고받음
> - -i : ssh 공개키 인증을 위한 파일 선택
```
ssh -i "~/coding/aws/.aws/NewKeyPair.pem" ikaman@ec2-3-34-107-69.ap-northeast-2.compute.amazonaws.com
```