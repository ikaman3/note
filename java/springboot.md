# Spring Boot

인강 내용 정리

## Before Spring Boot

Spring 프로젝트의 많은 것을 설정해야 프로덕션 환경에 필요한 애플리케이션을 얻을 수 있었다.  
이러한 작업을 새 프로젝트마다 반복했고 시간이 많이 들어간다. 또한, 오랫동안 유지관리하기에 더 많은 노력이 필요하다.

1. Dependency Management

- 모든 의존성과 그 버전을 `pom.xml`에서 관리해야 한다.

2. Define Web App Configuration(`web.xml`)

- 웹 애플리케이션의 많은 것을 설정하는 데 필요하다.
- 예: Spring MVC를 활용하려면 `DispatcherServlet`을 설정하는 데 필요

3. Manage Spring Beasn(`context.xml`)

- Component Scan
- View Resolver
- Data Source 등

4. NFRs(Non-functional requirements)

- Logging
- Error Handling
- Monitoring

## Create Spring Boot Project

1. Maven, Java
2. Version: Snapshot, RC를 제외한 안정된 버전

- Snapshot: daily build 버전, 실험 중인 버전, 새로 개발 중인 기능이 있을 수 있다(인터페이스가 변경 될 수 있음)
- M(milestone): Snapshot 보다 정리가 잘 되어 있는 버전, 실험 중인 버전, 새로 개발 중인 기능이 있을 수 있다(인터페이스가 변경 될 수 있음)

3. Project Matadata

- Grout ID와 Artifact ID는 클래스 이름과 패키지 이름과 매우 유사하다.
- 클래스를 만들 때 이름을 부여하고 패키지에 넣듯이
- 프로젝트를 만들 때 Artifact ID를 부여하고 Group에 넣는다.

4. Dependencis

- REST API를 빌드하려면 Spring Web 의존성이 필요하다.
- Spring MVC로 웹 애플리케이션과 REST API를 빌드하는 데 사용한다.
- Apache Tomcat을 임베디드 컨테이너로 사용한다.

`pom.xml`에서 Java의 버전은 PC에 설치된 OpenJDK 버전과 동일해야 한다.

## 프로젝트 구조

- `src/main/java`: 자바 코드나 검색 코드
- `src/main/resources`: 애플리케이션 설정
- `src/test/java`: 단위 테스트 코드 작성
- `pom.xml`: 의존성 정의
  - spring-boot-starter-web
  - spring-boot-starter-test
- `Maven Dependencies`: `pom.xml`에 정의된 spring-boot-starter-web, spring-boot-starter-test의 Starter Projects로 인해 들어옴

## RESTful API 생성

Controller와 Class를 생성한다.

```java
@RestController
public class CourseController {
  @RequestMapping("/demo")
  public List<Course> retrieveAllCourses() {
    return Arrays.asList(
      new Course(1, "Learn AWS", "ikaman"),
      new Course(2, "Learn DevOps", "ikaman"),
      new Course(3, "Learn Java", "ikaman")
    );
  }
}
```

```java
public class Course {
  private long id;
  private String name;
  private String author;
  ...
  @Override
  public String toString() {
    return "{" +
      " id='" + getId() + "'" +
      ", name='" + getName() + "'" +
      ", author='" + getAuthor() + "'" +
      "}";
  }
}
```

- `@RestController`: REST API를 만들기 위한 annotation. `org.springframework.web.bind.annotation.RestController`에서 import된다.
- `@RequestMapping("/demo")`: URL을 특정 메서드에 매핑하는 annotation.

## Spring Boot의 목표

가장 중요한 목표는 **Production-Ready 애플리케이션을 빠르게 빌드**하도록 돕는 것이다.  
애플리케이션을 프로덕션 환경에 배치하려면 많은 기능이 필요하다.

Build Quickly

- Spring Initializer
- Spring Boot Starter Projects: 프로젝트의 의존성을 빠르게 정의
- Spring Boot Auto Configuration: 클래스 경로에 있는 의존성에 따라 자동으로 설정 제공
- Spring Boot DevTools: 수동으로 서버를 재시작하지 않아도 애플리케이션 변경

Be Production-Ready

- Logging
- Different Configuration for Different Environments: 여러 환경(dev, qa, stage, prod)에 맞는 다양한 설정 제공
  - Profiles, ConfigurationProperties
- Monitoring(Spring Boot Actuator): 메모리가 충분한지, 애플리케이션의 측정항목 모니터링 등

## Spring Boot Starter Projects

일반적으로 애플리케이션 빌드를 위해 프레임워크가 많이 필요하다.

- REST API 빌드를 위해 Spring, Spring MVC, Tomcat, JSON conversion 등
- 단위테스트를 위해 Spring Test, JUnit, Mockito 등

이러한 프레임워크를 그룹화해서 애플리케이션 빌드를 쉽게 만들어주는 것이 Starter Projects이다.  
다양한 기능을 위해 **dependency descriptors**를 제공한다.
즉, Spring Boot Starter Project는 편리한 의존성 디스크립터다.

`pom.xml`에서 확인할 수 있는 spring-boot-starter-web으로 REST API와 웹 애플리케이션을 빌드할 수 있고 spring-boot-starter-test로 단위 테스트를 작성할 수 있다.

이렇듯 Spring Boot Starter는 특정 애플리케이션을 빌드하는 데 필요한 의존성을 모두 정의한다.

- Spring Boot Starter Data JPA: Oracle, MySQL과 같은 DBMS를 사용하고 JPA를 통해 데이터베이스와 통신할 때 사용하는 Starter Project
- Spring Boot Starter JDBC: JDBC를 사용해 DB와 통신할 때 사용하는 Starter Project
- Spring Boot Starter Security: 웹 애플리케이션이나 REST API를 보호할 때 사용하는 Starter Project

### spring-boot-starter-web

Spring MVC를 사용해 애플리케이션, RESTful를 비롯한 웹을 빌드하는 스타터이다.  
해당 의존성의 정의를 보면 여러 의존성이 정의되어 있다.

- spring-boot-starter: Spring 컨텍스트 실행
- spring-boot-starter-json: Bean에서 JSON, JSON에서 Bean으로 변환
- spring-boot-starter-tomcat: Tomcat에서 애플리케이션 실행
- spring-web, spring-webmvc: Spring MVC를 사용하여 REST API 빌드

## Spring Boot Auto Configuration

일반적으로 Spring Boot를 사용하여 웹 애플리케이션을 빌드하려면 많은 설정이 필요하다.

- Component Scan, DispatcherServlet, Data Sources, JSON Conversion, ...

이런 작업을 간소화하는 것이 애플리케이션용 자동화 설정인 Auto Configuration(자동설정)이다.  
자동 설정은 두 가지에 의해 생성된다.

1. 클래스 경로에 있는 프레임워크: `pom.xml`에 여러 Starter Project를 추가할 수 있고 그러면 많은 프레임워크를 가져온다. 따라서 클래스 경로에 있는 프레임워크에 따라 많은 것을 자동 설정할 수 있다.
2. 기존 설정(existing configuration): Spring Boot는 디폴트 자동 설정을 제공한다. 하지만 자체 설정으로 이를 Override할 수 있다.

Auto Configuration 로직은 Maven Dependencies의 `spring-boot-autoconfigure.jar` 정의되어 있다. 모든 자동 설정은 여기에서 확인한 코드에 기반한다.  
하위에 자동 설정 클래스가 많이 있는데 그중에서 `org.springframework.boot.autoconfigure.web` 패키지가 웹 애플리케이션 개발 및 REST API와 관련된 모든 자동 설정이 이 패키지와 하위 패키지에서 설정된다.

자동 설정을 더 자세히 알아보려면 `src/main/resources/application.properties`를 보면된다.  
예를 들어, 로깅 수준을 설정하려면 `logging.level.org.springframework=debug`처럼 작성 후 서버를 재시작하면 반영된다.

- 특정 패키지인 `org.springframework`를 디버그 수준에서 로깅하라는 의미다.
- Default logging level은 `INFO`다.
- Debug의 로그를 보면 `CONDITIONS EVALUATION REPORT`가 있고 `Positive matches`와 `Negative matches`로 나뉜다.
  - `Negative matches`: 자동 설정되지 않은 항목
  - `Positive matches`: 자동 설정된 항목

### `DispatcherServletAutoConfiguration`

`spring-boot-autoconfigure.jar` 밑의 `org.springframework.boot.autoconfigure.web.servlet`에 정의된 `DispatcherServletAutoConfiguration` 클래스를 확인할 수 있다.  
이 파일에서 자동 설정이 적용되는 시점에 관한 설정을 확인할 수 있다.

- `@AutoConfigureOrder(Ordered.HIGHEST_PRECEDENCE)`: 자동 설정 클래스의 우선 순위를 설정한다. `Ordered.HIGHEST_PRECEDENCE`는 스프링 부트 자동 설정 중 가장 높은 우선 순위를 가리키며, 이는 다른 자동 설정보다 먼저 적용된다는 것을 의미한다. 이 어노테이션을 사용하면 해당 자동 설정 클래스가 다른 자동 설정 클래스보다 우선적으로 로드된다.
- `@AutoConfiguration(after = ServletWebServerFactoryAutoConfiguration.class)`: 특정 자동 설정 클래스가 로드된 후에 해당 자동 설정 클래스가 로드되도록 지정한다. 여기서 `ServletWebServerFactoryAutoConfiguration.class`는 Servlet 기반의 웹 애플리케이션을 위한 웹 서버 자동 설정 클래스를 나타낸다. 따라서 해당 어노테이션이 있는 클래스는 이 웹 서버 자동 설정 클래스가 로드된 후에 실행된다.
- `@ConditionalOnWebApplication(type = Type.SERVLET)`: 애플리케이션이 특정 유형의 웹 애플리케이션인지를 확인한다. 여기서 `Type.SERVLET`은 Servlet 기반의 웹 애플리케이션을 나타낸다. 따라서 이 어노테이션이 붙은 클래스는 Servlet 기반의 웹 애플리케이션에서만 활성화된다.  
  웹 애플리케이션이나 REST API를 위해 설정된다.
- `@ConditionalOnClass(DispatcherServlet.class)`: 특정 클래스가 클래스 경로에 존재하는 경우에만 자동 설정을 활성화한다. 여기서 `DispatcherServlet.class`는 Spring MVC의 주요 컴포넌트인 디스패처 서블릿을 나타낸다. 따라서 해당 어노테이션이 있는 클래스는 클래스 경로에 DispatcherServlet이 존재할 때만 활성화된다.  
  Spring Web Starter에 포함했기 때문에 DispatcherServlet이 이미 클래스 경로에 있다.

### `ErrorMvcAutoConfiguration`

`spring-boot-autoconfigure.jar` 밑의 `org.springframework.boot.autoconfigure.web.servlet.error`에 정의된 `ErrorMvcAutoConfiguration` 클래스를 확인할 수 있다.

Default Error Page를 설정하는 내용이다.  
기본 에러 페이지란 어떤 것도 매핑되지 않은 URL을 입력했을 때 Whitelabel Error Page가 표시된다.  
Not Found이며 상태는 `404`다.  
따라서 애플리케이션이 URL이 매핑되지 않았음을 파악하여 적절한 오류 메시지를 클라이언트에 표시하는 역할을 한다.

### Spring Boot Starter Web

Spring Boot는 클래스 경로에 있는 프레임워크를 따라 많은 것들을 자동 설정하는데 가장 대표적인 예시가 Spring Boot Starter Web이다.
이 프로젝트를 사용하면 아래의 모든 것들이 자동 설정된다.

- Dispatcher Servlet(`DispatcherServletAutoConfiguration`)
- Embedded Servlet Container(Tomcat을 함께 자동 설정)(`EmbeddedWebServerFactoryCustomizerAutoConfiguration`)
- Default Error Pages(`ErrorMvcAutoConfiguration`)
- JSON Conversion(`JacksonHttpMessageConvertersConfiguration`)
  - JSON 변환은 Jackson 프레임워크에서 실행된다.
  - Spring Boot Auto Configuration은 Spring Boot Starter Web이 클래스 경로에 있을 때 Bean에서 JSON으로의 MessageConverters를 자동으로 제공한다.  
    이것이 메서드에서 Bean 배열 리스트(`List<Course>`)를 반환할 때 자동으로 JSON으로 파싱되는 이유이다.

## Spring Boot DevTools

자동으로 서버를 재시작하고 코드 변경사항을 적용하여 개발자의 생산성을 높이는 프로젝트다.  
`pom.xml`에 spring-boot-devtools으로 의존성을 추가할 수 있다.  
java 파일이나 view 파일, property 파일을 변경하는 경우 자동으로 애플리케이션의 재시작을 트리거하여 서버를 재시작해준다.

> **주의사항**  
> `pom.xml`을 변경하면 애플리케이션을 수동으로 재시작해야 한다.  
> Spring Boot DevTools은 `pom.xml`의 변경사항을 처리할 수 없다.

## Spring Boot Production-Ready

프로덕션 환경에 사용할 수 있는 애플리케이션을 쉽게 만들 수 있도록 돕는 Spring Boot의 중요한 기능들

### Managing App. Configuration using Profiles

- 애플리케이션은 다양한 환경(Dev, QA, Stage, Prod, ...)이 있다.
- 동일한 애플리케이션의 다양한 환경에는 다양한 설정이 필요하다.
  - 다른 DB(개발 환경에서는 개발 DB, 프로덕션에서는 프로덕션 DB 등)와 통신, 다른 웹 서비스 호출
  - 환경마다 로깅 레벨이 다른 경우 등

이것이 프로필이 있는 이유다. 프로필을 통해 환경별 설정을 제공할 수 있다.  
프로필이 없으면 `application.properties`의 Default Property를 사용한다.

현재 `dev`와 `prod` 환경이 있다고 가정하고 각각 로그 레벨을 `trace`, `info`로 설정하려고 한다.

1. `src/main/resources` 밑에 `application-dev.properties`, `application-prod.properties` 파일을 추가하고 원하는 로그 레벨을 추가
2. `application.properties`에 프로필을 설정: `spring.profiles.active=prod`

- 특정 프로필을 설정하려면 디폴트 설정(`application.properties`)의 값과 특정 프로필(`application-prod.properties`)의 값을 함께 병합해야 한다.
- 어떤 것을 설정하든 특정 프로필의 우선순위가 더 높다.

3. `spring.profiles.active`의 값을 `dev`로 변경하면 `dev` 환경의 프로필이 적용된다.

일반적으로 로깅 프레임워크에서 지원하는 로깅 수준은 다음과 같다.  
순서대로 밑의 로깅 레벨을 모두 포함하여 출력한다.

1. `trace`: 로그에 있는 모든 정보(`trace`, `debug`, `info`, `warning`, `error`) 출력
2. `debug`: `info`보다 더 많은 정보(`debug`, `info`, `warning`, `error`) 출력
3. `info`: `info` 수준에서 로깅된 모든 정보(`info`, `warning`, `error`) 출력
4. `warning`: `error`보다 조금 더 많은 정보(`warning`, `error`) 출력
5. `error`: Error, Exception만(`error`) 출력
6. `off`: 로깅을 끈다.

## 알게된것

### Tuple

QueryDsl을 사용중 select문에서 Q클래스만 남기니까 get 메서드를 호출할 수 없는 에러가 발생함.

> Tuple은 여러 필드를 포함할 수 있는 데이터 구조입니다.  
> QueryDSL에서 select 구문에 포함된 필드들만 Tuple에 저장됩니다.  
> 즉, select(qClass)을 사용하면 qClass 객체 전체가 아닌, 그 객체의 필드들이 Tuple에 저장됩니다.  
> 만약 qClass이 Entity의 필드들을 포함하는 Q 클래스라면, select(qClass)은 해당 Entity의 모든 필드를 선택하는 것이 아니라 필요한 필드만 선택하게 됩니다.