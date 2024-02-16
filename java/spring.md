# Spring

## Maven, Java로 Spring 프로젝트 생성

## Spring Bean 및 설정

## 블로그 글 옮기던거

Spring의 폼 태그는 커맨드 객체(데이터 모델)를 사용하여 HTML 폼 입력 필드와 데이터를 바인딩한다.  
폼 입력 필드의 값을 커맨드 객체의 속성에 자동으로 매핑하여 컨트롤러에 전달한다.  
예를 들어, <form:form> 태그를 사용하여 폼을 정의하고, <form:input> 또는 <form:select> 등의 태그를 사용하여 폼 필드를 생성한다. 그런 다음 이러한 필드들은 Spring 컨트롤러에 전송되고, 컨트롤러는 해당 필드들의 값을 커맨드 객체에 바인딩하여 사용할 수 있다.

```java
// 컨트롤러에서의 커맨드 객체
public class User {
    private String username;
    private String password;
    // Getters and setters
}

// JSP에서의 폼
<form:form modelAttribute="user" method="post" action="/login">
    <form:input path="username" />
    <form:password path="password" />
    <input type="submit" value="Login" />
</form:form>
```

위의 코드에서 modelAttribute는 컨트롤러에서 사용되는 데이터 모델(커맨드 객체)의 이름을 나타낸다. path 속성은 커맨드 객체의 속성과 매핑되는 폼 필드를 정의한다.

## XML, Java 파일 등은 서버 재부팅 필요

# MyBatis XML Query

## if 조건문과 choose, when, otherwise

```html
<if test="searchKeyword != '' and searchKeyword != null">
    <choose>
        <when test="searchCondition == 0">
            AND user_nm LIKE CONCAT('%', #{searchKeyword}, '%')
        </when>
        <when test="searchCondition == 1">
            AND emailaddr LIKE CONCAT('%', #{searchKeyword}, '%')
        </when>
    </choose>
</if>
```

# Spring MVC Pattern

1. servlet에서 모든 로직(비즈니스, 출력)을 만들다보니 유지보수가 힘듦
2. 템플릿 엔진으로 비즈니스, 출력 로직 모두 작성하게 되었으나 가독성 떨어짐
3. controller, view로 나눠서 MVC 모델 1 사용
4. Controller에서 비즈니스 로직 + 호출까지 담당하니 가독성 떨어짐
5. Controller, Service, DTO, DAO, View 작업을 나눈 MVC 모델 2 사용
6. 현재 MVC 패턴은 모델 2 기반

# Controller에서의 Request

이 객체는 임시 저장소 기능, 세션 관리 기능을 한다.

-   저장소 : request.setAttibute(name, value), request.getAttibute(name)
-   세션 : request.getSessing(create: true)
-   이런 식으로 request 객체를 통해서 요청 또는 응답할 데이터를 각 메서드를 통해 요청하거나 응답할 수 있다.

## HTTP 요청 데이터

### GET - 쿼리 파라미터

메시지 바디없이 url에 쿼리 파라미터를 포함하여 전달

-   URL 뒤에 ?로 쿼리 파라미터를 명시
-   &로 파라미터를 구분해서 전송  
    content-type이 없다.  
    주로 검색, 필터, 페이징 등에 사용한다.

```html
url?username=hello&age=20
```

### POST T-HTML Form

HTTP 요청시 `content-type: application/x-www-form-urlencoded`으로 전달한다.  
메시지 body에 쿼리 파라미터로 전달한다. `username=hello&age=20`

-   웹 브라우저가 결과를 캐시하고 있어서 캐시 초기화 및 서버 재시작이 필요함
-   클라이언트에서 get과 post를 전달하는 방식에 차이가 있지만 서버는 똑같이 쿼리 파라미터로 받기 때문에 둘다 `request.getParameter()`로 받는다.  
    주로 회원 가입, 상품 주문, HTML Form 사용

### HTTP Message Body

HTTP API에서 주로 사용, JSON, XML, TEXT  
데이터 형식은 주로 JSON  
POST, PUT, PATCH를 사용  
body에 데이터를 InputStream을 사용해서 직접 읽을 수 있다.

-   JSON 결과를 파싱해서 사용할 수 있는 자바 객체로 변환하려면 Jackson, Gson 같은 JSON 변환 라이브러리를 추가해서 사용한다.(스프링 부트에서는 기본으로 Jackson 라이브러리-ObjectMapper-를 함께 제공한다)

```java
// inputstream으로 byte 코드를 반환
 ServletInputStream inputStream = request.getInputStream();

// 반환 받은 byte 코드를 utf_8 charset으로 지정해서 문자로 담기
 String messageBody = StreamUtils.copyToString(inputStream,StandardCharsets.UTF_8);

// body 출력
 System.out.println("messageBody = " + messageBody);

// 응답
 response.getWriter().write("ok");
```
