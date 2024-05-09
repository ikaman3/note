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

## Annotation

자바 어노테이션(Java Annotation)은 자바 소스 코드에 추가하여 사용할 수 있는 메타데이터의 일종이다.  
보통 `@` 기호를 앞에 붙여서 사용한다. JDK 1.5 버전 이상에서 사용 가능하다.  
자바 어노테이션은 클래스 파일에 임베디드되어 컴파일러에 의해 생성된 후 자바 가상머신에 포함되어 작동한다.

과거에는 소스코드(`.java`)와 설정 파일(`.xml`)을 별도로 관리하였고 문제가 발생했다.  

- 소스코드와 설정을 각각 수정해야 함
- 코드와 설정이 분리되어 개발의 어려움

그래서 어노테이션을 사용해서 하나의 파일에 코드와 설정을 같이 관리하게 되었다.  

### Standard Annotation

자바에 Build in된 어노테이션

#### `@Override`

> 오버라이딩을 올바르게 했는지 컴파일러가 검사한다.

```java
class Parent{
	void parentMethod(){}
}

class Child extends Parent{
	@Override
    void pparentmethod(){} // 컴파일 에러! 잘못된 오버라이드 스펠링 틀림
```

#### `@Deprecated`

> 앞으로 사용하지 않을 것을 권장하는 필드나 메서드 표시

```java
@Deprecated
public int getDate(){
	return normalize().getDayOfMonth();
}
```

- 하위 호환성을 위해서 없애지는 않고 사용하지 않기를 권장만 한다.

#### `@FunctionalInterface`

> 함수형 인터페이스를 올바르게 작성했는지 컴파일러가 체크

함수형 인터페이스의 *"하나의 추상메서드만 가져야 한다는 제약"*을 확인해준다.  
또한 함수형 인터페이스라는 것을 알려주는 역할도 한다.  

#### `@SuppressWarnings`

> 컴파일러의 경고메시지 억제

```java
@SuppressWarnings("unchecked")
ArrayList list = new ArrayList(); // 제네릭 타입을 지정하지 않음!
list.add(obj); // 경고 발생 !!! 경고 내용 = unchecked
```

`Array`를 선언할 때 제네릭을 통해서 타입에 대한 정보를 기입하지 않았다.  
그래서 타입을 선언하지 않았다는 `"unchecked"`라는 경고가 뜬다.  
하지만 `"@SuppressWarnings("unchecked)"`를 입력해주었기 때문에 `"unchecked"`에 대한 경고는 억제된다.  
보통 경고가 많을 때, 확인된 경고는 해당 어노테이션을 붙여서 새로운 경고를 알아보지 못하는 것을 방지하기 위해 사용한다.  

### Meta Annotation

어노테이션을 위한 어노테이션

#### `@Target`

> 어노테이션을 정의할 때 적용할 어노테이션 지정

```java
@Target({TYPE, FIELD, TYPE_USE})
@Retention(RetentionPolicy.SOURCE)
public @interface MyAnnotation{}

@MyAnnotation // 적용 대상이 Type(클래스, 인터페이스)
class MyClass{
	@MyAnnotation //적용 대상이 FIELD인 경우
    int i;
    
    @MyAnnotation //적용 대상이 TYPE_USE인 경우
    MyClass mc;
}
```

#### `@Retention`

> 어노테이션의 유지기간(생명주기) 지정

```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override{}
```

- `SOURCE`: 소스 파일에만 존재
- `METHOD`: 클래스 파일에 존재. 실행 시에 사용가능

#### `@Documented`

> javadoc으로 작성한 문서에 포함시키는 어노테이션

#### `@Inherited`

> 어노테이션도 상속이 가능하다. 어노테이션을 자손 클래스에 상속하고자 할 때 붙인다.

```java
@Inherited
@interface SuperAnno{}

@SuperAnno
class Parent{}

// <- 여기에 @SuperAnno 가 붙은 것으로 인식
class Child extends Parent{}
```

#### `@Repeatable`

> 반복해서 붙일 수 있는 어노테이션을 정의

```java
@Repeatable(ToDos.class)
@interface ToDo{
	String value();
}

@ToDo("delete test codes.")
@ToDo("override inherited methods")
class MyClass{
	~~
}

@interface ToDos{
	ToDo[] value();
}
```

`MyClass`에 `@ToDo` 어노테이션이 여러개가 정의된 것을 볼 수 있다.  
`@Repeatable` 어노테이션은 위의 `ToDos`처럼 **컨테이너 어노테이션**도 정의해야 한다.

### Custom Annotion

사용자 정의 어노테이션

```java
@interface 이름{
	타입 요소 이름(); // 어노테이션의 요소를 선언
	    ...
}
```

(추후 작성)[https://velog.io/@jkijki12/annotation]