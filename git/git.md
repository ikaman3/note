# Git

# Git 명령어

## branch  
```
git checkout -t origin/<branch>
```
- 원격 브랜치에 현재 로컬 브랜치를 추적(Tracking)하게 함
- 로컬에 브랜치를 생성해주지 않음
```
git checkout -b <branch>
```
- 로컬에 브랜치 생성
```
git checkout -t -b <branch> origin/<branch>
```
- 로컬에 브랜치를 생성하면서 원격의 브랜치와 연결  
  
## commit
이미 Remote에 Push된 Commit의 Author, Committer, Email을 변경하는 명령어
```
OLD_NAME=$1
NEW_NAME=$2
NEW_EMAIL=$3

git filter-branch -f --commit-filter "
    if [ \"\$GIT_COMMITTER_NAME\" = \"$OLD_NAME\" ];
       then
	   	   GIT_COMMITTER_NAME=\"$NEW_NAME\";
	   	   GIT_AUTHOR_NAME=\"$NEW_NAME\";
           GIT_AUTHOR_EMAIL=\"$NEW_EMAIL\";
		   git commit-tree \"\$@\";							        
	   else							
	   	   git commit-tree \"\$@\";					
	fi" HEAD
```
```
조심해야할 것은 GIT_AUTHOR_EMAIL 은 명령어 실행시 사용되는 환경변수가 아닌 filter-branch 프로세스 안에서 커밋 하나 하나를 비교할때 사용되는 환경변수이므로 "$GIT_AUTHOR_EMAIL" 란 스트링이 현재 환경변수로 치환되지 않고 그대로 들어가야해서 \"\$GIT_AUTHOR_EMAIL\" 로 사용했고, NEW_EMAIL 등 은 바로 윗줄에서 셋팅해준 환경변수로 치환되어야 하는 값이기 때문에 \"$NEW_EMAIL\" 로 사용했으며, --commit-filter 다음에 single quote' 대신 double quote" 를 사용했다.
```

# Git Branch 전략
- Github Flow
	- main Branch
	- feature Branch
## feature Branch 규칙
✔️ feature/{팀명}-{이슈번호}-{영문이름이니셜}

```ex) feature/A-14-kjk```
✔️ 생성 조건

> main Branch에서 분기시켜 생성
> local repo와 remote repo 둘 다 생성
> 기능 개발건 ➡️ feature Branch 1개 생성

> feature Branch의 이슈번호 생성 및 관리
> 
> 1) Gitea에서 이슈를 생성하여 부여
> 2) 생성된 이슈를 개발 담당자와 연결
> 3) 해당 이슈번호를 이용하여 Branch 생성 ➡️ local & remote Branch
> 4) 생성된 Branch를 이슈와 연결

✔️ 삭제 조건

> Merge ➡️ 삭제
> Gitea에서 PR(Pull Request) ➡️ Merge ➡️ 삭제

## commit, push, fetch, pull 규칙
> commit 은 최대한 많이 한다.
> 
> 1) rebase, cherry-pick 시 유용
> 2) 되돌리기가 용이(reset, revert)

> push 는 꼭 fetch, pull 을 하고난 후에 한다.
> 
> 1) confilct 방지

```git cli 보단 우선 IDE를 이용해 git 기능을 사용```

# Commit Convention(협업을 위한 커밋 메세지 규칙)
1. Commit Message Structure
```
제목 (Commit Type: Subject)
(한줄 띄어 분리)
본문 (Body)
(한줄 띄어 분리)
꼬리말 (Footer)
```
2. Commit Type  
```
제목에 기입되는 커밋의 유형
```  
  
| Type Name  | Description |
| :--- | :--- |
| Feat  | 새로운 기능을 추가|
| Fix  | 버그 수정  |
| Design | CSS 등 사용자 UI 디자인 변경 |
| Style | 코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우 |
| Refactor | 코드 리팩토링 |
| Rename | 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 |
| Remove | 파일을 삭제하는 작업만 수행한 경우 |  
  
> commit Type list
>	> 1. 기능 : Feat, Fix, Design
>	> 2. 개선 : Style, Refactor
>	> 3. 그 외 : Rename, Remove
	
3. [제목] 작성 방법  
> 1. 제목의 처음은 동사 원형으로 시작합니다.
> 2. 총 글자 수는 50자 이내로 작성합니다.
> 3. 마지막에 특수문자는 삽입하지 않습니다. 예) 마침표(.), 느낌표(!), 물음표(?)
> 4.  제목은 개조식 구문으로 작성합니다.  
Example)  
```Feat: 로그인 화면 템플릿 구현```  
  
4. [본문] 작성 방법  
> 1. 본문은 한 줄 당 72자 내로 작성합니다.
> 2. 본문 내용은 양에 구애받지 않고 최대한 상세히 작성합니다.
> 3. 본문 내용은 어떻게 변경했는지 보다 무엇을 변경했는지 또는 왜 변경했는지를 설명합니다.  

5. [꼬리말] 작성 방법  
> 1. 꼬리말은 optional이고 이슈 트래커 ID를 작성합니다.
> 2. 꼬리말은 "유형: #이슈 번호" 형식으로 사용합니다.
> 3. 여러 개의 이슈 번호를 적을 때는 쉼표로 구분합니다.
> 4. 이슈 트래커 유형은 다음 중 하나를 사용합니다.
>	> - Fixes: 이슈 수정중 (아직 해결되지 않은 경우)
>	> - Resolves: 이슈를 해결했을 때 사용
>	> - Ref: 참고할 이슈가 있을 때 사용
>	> - Related to: 해당 커밋에 관련된 이슈번호 (아직 해결되지 않은 경우)  
  
6. 예시
```
Feat: 로그인 화면 템플릿 구현

로그인 작성을 위해 회원ID, 패스워드를 입력하는
input tag 작성

Resolves: #123  
Ref: #456
Related to: #48, #45
```  
