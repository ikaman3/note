# Java

## 개발환경

### VSCode

VSCode에서 사용하는 방법

1. homebrew로 `openjdk`, `maven` 설치

```bash
  brew install openjdk maven
```

2. homebrew로 설치하면 심볼릭 링크로 경로를 수정해주어야 한다: `sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk`
3. VSCode에 `Extension Pack for Java`, `Spring Boot Extension Pack`, `Code Generator For Java` 확장 설치

- Maven으로 빌드한다면 자바 확장팩에 이미 설치되어 있지만, Gradle은 `Gradle for Java` 확장을 설치해야 한다.
- 스크립트를 사용한 설치방법:

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

4. 명령행을 열고(`Command` + `Shift` + `p`) `Spring Initalizer`를 실행하면 스프링부트 프로젝트를 프로비저닝할 수 있다.
5. 명령행에서 `Maven Execute Commans`로 Maven 스크립트를 실행할 수 있다.

### Chrome

Chrome Extension 중 JSON formatter를 설치하면 json 포맷의 데이터를 파싱된 형태로 볼 수 있다.
