#!/bin/bash

# 사용법
## git bash / bash / zsh 등 리눅스 CLI 터미널에서 본인 Github repository까지 이동 후 
## 아래의 명령어를 입력
## sh change_committer.sh <회사gitID> <본인gitID> <본인gitEmail> 

# 셸 변수 선언
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
