# Git 명령어 및 설정 모음

git 명령어와 활용법을 정리하는 문서

## Global config

```bash
# 새로운 브랜치를 처음 push할 때 자동으로 upstream이 설정
git config --global push.autoSetupRemote true
```

## diff

add 되지않은 (staging 되지않은) 파일의 수정 전, 후 차이를 보여주는 명령어

```bash
git diff
```

## branch

원격 브랜치에 현재 로컬 브랜치를 추적(Tracking)하게 함  

- 로컬에 브랜치를 생성해주지 않음

```bash
git checkout -t origin/<branch>
```

로컬에 브랜치 생성  

```bash
git checkout -b <branch>
```

로컬에 브랜치를 생성하면서 원격의 브랜치와 연결  

```bash
git checkout -t -b <branch> origin/<branch>
git checkout -b <branch> origin/<branch>
```

이미 원격 브랜치가 존재하는 경우 추적 관계 설정

```bash
git branch -u origin/<branch> <branch>
```

원격 브랜치를 가져오면서 동시에 추적 관계를 설정  

- Git 2.22 버전 이상에서 사용 가능

```bash
git switch -c <branch> origin/<branch>
```

브랜치 삭제

```bash
# 다른 브랜치로 이동
git switch main

#  로컬 브랜치 삭제
git branch -d <branch_name>

#  원격 브랜치 삭제
git push -d origin <branch_name>
git push --delete origin <branch_name>

# bash 연산자 사용하여 한 줄로 실
git switch main && git branch -d <branch_name> && git push origin -d <branch_name>
```

## remote

로컬 저장소에서 원격 저장소(origin)에 더 이상 존재하지 않는 원격 추적 브랜치들을 제거  

- 원격 저장소와 로컬 저장소의 동기화
- 불필요한 원격 추적 브랜치 제거
- 저장소 정리 및 관리
- 로컬의 원격 추적 브랜치만 제거하며, 로컬 브랜치는 영향을 받지 않는다.
- 제거된 원격 추적 브랜치와 연결된 로컬 브랜치는 그대로 남아있다.

```bash
git remote prune origin
# 실제로 제거하지 않고 제거될 브랜치들을 미리 확인
git remote prune origin --dry-run
# fetch 작업과 함께 prune을 동시에 수행
git fetch --prune
```

## fetch

`git pull`과 동일한 작업

- 변경사항을 확인한 후 병합하지 않기로 결정했다면, 단순히 `merge` 단계를 건너뛴다.

```bash
# 원격 저장소의 변경사항 가져오기
git fetch origin
# 원격 저장소의 특정 브랜치만 변경사항 가져오기
git fetch origin <branch>

# 현재 브랜치 확인 (예: main 브랜치)
git branch
# * main

# (선택사항) 원격 브랜치의 변경사항 확인
git log HEAD..origin/main

# 변경사항 병합
git merge origin/main
```

## stash

현재 작업 중인 변경사항을 임시로 저장하고 나중에 다시 적용할 수 있게 해주는 명령어

-  `n`은 stash 인덱스 번호

```bash
# 변경사항 임시 저장하기
git stash
# 메시지와 함께 저장
git stash save "작업 내용 설명"

# 저장된 stash 목록 확인
git stash list

# 가장 최근의 stash 적용 및 제거
git stash pop

# 특정 stash 적용 (제거하지 않음)
git stash apply stash@{n}

# 모든 stash 삭제
git stash clear

# 추적되지 않은 파일도 포함하여 stash
git stash -u
# 또는
git stash --include-untracked

# 새 브랜치를 만들어 stash 적용(새 브랜치를 생성하고 stash를 적용한 후 삭제)
# 큰따옴표는("")브랜치 이름에 공백이나 특수 문자가 포함된 경우에 필요
git stash branch "<new-branch>"

# stash의 변경 내용 확인
git stash show -p stash@{n}

# 부분적으로 stash 저장(변경사항을 하나씩 확인하며 선택적으로 stash)
git stash -p
```

## filter-branch

이미 Remote에 Push된 Commit의 Author, Committer, Email을 변경하는 명령어

```bash
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

> 조심해야할 것은 `GIT_AUTHOR_EMAIL` 은 명령어 실행시 사용되는 환경변수가 아닌  
> `filter-branch` 프로세스 안에서 커밋 하나 하나를 비교할때 사용되는 환경변수이므로 `"$GIT_AUTHOR_EMAIL"` 란 스트링이 현재 환경변수로 치환되지 않고 그대로 들어가야해서 `\"\$GIT_AUTHOR_EMAIL\"` 로 사용했고,  
> NEW_EMAIL 등 은 바로 윗줄에서 셋팅해준 환경변수로 치환되어야 하는 값이기 때문에 `\"$NEW_EMAIL\"` 로 사용했으며, `--commit-filter` 다음에 single quote(') 대신 double quote(") 를 사용함

## Error

### 파일 이름이 한글인 경우 유니코드로 표시되는 문제

Git은 일반적이지 않은 문자를 Escape 문자로 처리하는 기능을 수행한다.  
그래서 한글 앞에 탈출 문자를 붙인 탓에 정상적으로 표기되지 않았다.  
터미널에 다음 명령어를 입력하여 git global 설정을 변경하여 해결한다.

```bash
git config --global core.quotepath off
```
