# IDE or Editter

IDE 관련 정보를 기록할 마크다운 문서

## Visual Studio Code

### CLI Scripts

#### Install Extension

CLI를 이용해 Extension을 설치할 수 있다.

```bash
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-test
code --install-extension redhat.java
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-spring-initializr
code --install-extension vscjava.vscode-spring-boot-dashboard
code --install-extension pivotal.vscode-boot-dev-pack
code --install-extension pivotal.vscode-spring-boot
```

#### Upgrade VSCode

```bash
winget upgrade --id Microsoft.VisualStudioCode
```

### Shortcuts

Keybinding이 없는 단축키는 ⌘ ⇧ P 입력 후 Command를 입력해서 선택하거나  
Keybinding을 등록해서 사용할 수 있음

| Command                                                   | Keybinding  | When               | source |
| :-------------------------------------------------------- | :---------- | :----------------- | :----- |
| Go Back 돌아가기                                          | ⌃ -         | canNavigateBack    | System |
| Go Forward 앞으로 가기                                    | ⌃ ⇧ -       | canNavigateForward | System |
| Transform to Lowercase/Uppercase/Title Case 대소문자 변환 |             |                    | System |
| 같은 변수를 사용하는 모든 위치의 이름 변경                | F12         |                    | System |
| 같은 변수를 사용하는 모든 위치를 확인                     | Shift + F12 |                    | System |
| Workspace 내의 파일 검색                                  | Ctrl + P    |                    | System |
| Clear Recently Opened 최근 열었던 파일 검색 기록 삭제     |             |                    | System |

- Transform to Lowercase/Uppercase/Title Case

  - Lowercase : 모두 소문자로 변환
  - Uppercase : 모두 대문자로 변환
  - Titlecase : 단어의 첫 글자는 대문자, 나머지는 소문자로 변환

### 이미지 삽입

[젤다](https://dohokin.com/?p=1993)

설정에서 `Markdwon > Copy Files: Destination`에 Item을 추가한다  

| Item | Value |
| :--- | :--- |
| **/* | images/${fileName} |

이러면 `images` 폴더 안에 파일이름으로 이미지가 저장되며 해당 경로를 자동으로 삽입해준다.  

> 예시  
>  
> ![alt text](images/122337536_p0_master1200.jpg)

### Extensions

#### Linter

> ESLint  
> 소스코드에 문제가 있는지 검사하여 flag를 달아주는 도구

#### Formatter

> Prettier  
> 소스코드를 일관된 스타일로 작성할 수 있게 변환하는 도구

#### Red Hat Dependency Analytics

이녀석이 package.json에 "폴더 이름": "file:" 자동으로 추가해버림

## Eclipse

### 설정

### Shortcuts

| Command                                                   | Keybinding  |
| :-------------------------------------------------------- | :---------- |
| 소스코드 창만 보기                                          | Ctrl + m |
| 파일 찾기                                   | Ctrl + h     |
| Resource 찾기 |    Ctrl + Shift + r         |
| 자동 import(Organize Imports)                | Ctrl + Shift + o   |
