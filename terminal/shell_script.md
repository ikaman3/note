# Linux/MacOS 호환 Shell Script 정리

# SSH
> Secure Shell
> - -i : ssh 공개키 인증을 위한 파일 선택
```
ssh -i "~/coding/aws/.aws/NewKeyPair.pem" ikaman@ec2-3-34-107-69.ap-northeast-2.compute.amazonaws.com
```

# 파일 복사
> 가장 기본적인 파일 복사  
```
cp <source> <target>
```  
> ssh를 이용한 원격 파일 복사  
```
scp -i "keypair.pem" <source> <user>@<IP Address or Domain>:<target>
```
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
