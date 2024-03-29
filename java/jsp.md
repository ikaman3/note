# JSP

JSP 관련 개념과 문법 등을 기록하는 문서

## JSTL (JSP Standard Tag Library)

JSP를 사용하는 여러 프로그램이 공통으로 사용할 수 있도록 JSP 태그를 라이브러리 형태로 만들어놓은 것  
보통의 라이브러리와는 다르게 JSP 페이지 안에서 사용 할 수 있는 커스텀과 함수를 제공한다.  
일반적으로 EL (Expression Language)과 함께 쓰이며, 이를 통해 HTML 코드 내에서 자바 코드를 사용할 수 있게 해주는 스크립틀릿을 가독성 좋게 사용할 수 있다.  
최근에는 뷰와 비즈니스 로직의 분리와 가독성 이슈로 스크립툴릿 대신 JSTL을 많이 사용한다.

## JSTL로 할 수 있는 일

1. 간단한 프로그램 로직 구사 (자바 변수 선언, if문, for문 등)
2. 다른 JSP 페이지 호출 (`<c:redirect>`, `<c:import>`)
3. Formatting(숫자, 날짜, 시간)
4. 데이터베이스 CRUD
5. XML 문서 처리
6. 문자열 처리 함수 호출 등

## import Java Class

`<%@ page import = "mes.cmm.util.MberHelber" %>`

- `src/main/java/mes/cmm/util/MberHelber` Class를 임포트 하는 구문
- 이때 Class는 public이어야 함

## Directive(지시자) 또는 태그 라이브러리에 의한 공백 제거

`<%@ page trimDirectiveWhitespaces="true" %>`

- JSP 페이지에서 지시자와 태그 라이브러리를 사용하면 최종 출력 HTML에 지시자 또는 태그가 사용된 곳에 빈 줄이 삽입되어 페이지 소스를 보기 어렵게 하고,  
  페이지 용량도 늘어난다.
- JSP 2.1 이상에서 제공한다.

`<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>`

- `page` 지시자의 다른 속성과 함께 사용할 수 있다.
- 이 방식은 include된 페이지에는 적용되지 않으므로 각각 적용해주어야 한다.

## 다국어 지원 및 반복적인 문자열 사용

1. `src/main/resources` 밑에 사용할 문자열을 작성한 `properties` 등록

- 확장자: `*.properties`

2. `context-*.xml`에 `bean` 등록(둘 중 하나 선택)

```html
<bean
  id="messageSource"
  class="org.springframework.context.support.ReloadableResourceBundleMessageSource"
>
  <property name="basenames">
    <list>
      <value>메세지파일경로</value>
    </list>
  </property>
  <!--인코딩 설정-->
  <property name="defaultEncoding" value="UTF-8" />

  <!-- properties 체크-->
  <property name="cacheSeconds" value="값" />
</bean>
```

- `id`, `class` 등은 변경하지 않음

2. 자바 파일로 bean 등록(둘 중 하나 선택)

```
@Bean
public MessageSource messageSource() { // Bean 이름은 messageSource여아 한다.
    ResourceBundleMessageSource ms = new ResourceBundleMessageSource();
    ms.getBasenames("파일명"); // resources/ 이후 경로
    ms.setDefaultEncoding("UTF-8"); // 인코딩 설정
    return ms;
}
```

3. jsp 상단에 `taglib` 추가

`<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>`

4. `spring:message` 태그 이용해서 문자열 출력

```html
<spring:messsage
  code="fail.common"
  text="code 값이 없을 시 출력 할 메시지 설정"
/>

msg.text={0}님, 반갑습니다 msg.fruits={0}, {1} 그리고 {2}
<spring:message code="msg.text" arguments="스미스" />
<!-- 출력: 스미스님, 반갑습니다. -->

<spring:message code="msg.fruits" arguments="사과, 포도, 오렌지" />
<!-- 출력: 사과, 포도 그리고 오렌지 -->

<spring message code="msg.text" var="greeting">
  ${greeting}
  <!-- 출력: 안녕하세요 --></spring
>
```

- `code`: 불러올 텍스트의 key 값
- `text`: code 값이 없을 시 출력할 메시지
- `arguments`: 지정된 부가 인자({0},{1}, ...) 값을 출력
  - 부가인자의 갯수만큼 `arguments`가 등록되지 않으면 `사과, 포도 그리고 {2}`처럼 출력
- `var`: 값을 변수로 할당

## 대표적 라이브러리와 기능

### 라이브러리

#### Core

> 접두어: c  
> 기능: 일반 프로그램 언어에서 제공하는 변수선언, 조건/제어/반복문 등의 기능 제공

#### Formatting

> 접두어: fmt  
> 기능: 숫자, 날짜, 시간을 포맷팅하는 기능 그리고 국제화, 다국어 지원기능 제공

#### Function

> 접두어: fn  
> 기능: 문자열을 처리하는 함수 제공

#### Database

> 접두어: sql  
> 기능: 데이터베이스의 데이터 CRUD 기능 제공

#### XML 처리

> 접두어: x  
> 기능: XML 문서를 처리할 때 필요한 기능 제공

### 라이브러리 선언 (JSP 문서 선언부에 작성)

```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %> <%@ taglib prefix="sql"
uri="https://java.sun.com/jsp/jstl/sql" %> <%@ taglib prefix="x"
uri="https://java.sun.com/jsp/jstl/xml" %>
```

## 사용 예시

### 변수 선언

> JSP page에서 사용할 변수 설정  
> JSP의 setAttribute와 비슷한 역할
>
> - var="변수명"
> - value="변수에 넣을 값"
> - property="자바빈 객체 or Map 객체 값을 설정할 프로퍼티 값"
> - scope="변수 공유 범위"

```html
<!-- 변수의 선언 -->
<c:set var="변수명" value="값" />
<c:set var="num1" value="1" />
<c:set var="num2" value="${num1 + 1}" />
<c:set var="url" value="<%=request.getContextPath() %>" />

<!-- scope 속성은 선택적이며 page로 기본 설정되어 있다. -->
<c:set
  var="변수명"
  value="할당된 값"
  scope="변수의 유효 범위 page|request|session|application"
/>

<c:set var="country" value="Korea" scope="request" />
<c:set var="intArray" value="<%=new int[] {1,2,3,4,5} %>" />

<!-- 변수의 사용 -->
<h1>${num1}</h1>
<h1>${num2}</h1>
<a href="${url}/member/loginForm">로그인</a>
```

### 변수 제거

> JSP의 removeAttribute()와 비슷한 역할
>
> - var="변수명"
> - scope="변수 공유 범위"

```html
<c:remove var="country" scope="request" />
```

### 출력

> JSP의 <%=...> 표현식을 대체
>
> - var="변수명"
> - default="기본값"
> - escapeXML="true|false"

```html
<!-- Syntax -->
<c:out var="변수명" default="기본값" escapeXML="true|false" />

<!-- 간단 사용 예 -->
<p><c:out value="${country}" default="Korea" escapeXml="true" /></p>
<p>${country}</p>
<p>${intArray[0]}</p>
```

### 예외 처리

> Body에서 실행되는 코드의 예외 처리
>
> - var="에러메시지가 포함될 변수명"

```html
<c:catch var="ex"> <%= 1/0 %> </c:catch> <br />

Error Msg: ${ex} <br />
```

### 반복문 (forEach)

> - var="현재 아이템의 변수명"
> - items="반복 데이터가 있는 아이템 Collection 명"
> - begin="시작 값, 기본값은 0"
> - end="종료 값"
> - step="증가 값"
> - varStatus="반복 상태 값을 지닌 변수"

> `varStatus`는 forEach의 상태를 알 수 있는 값이 들어 있다.
>
> - $(변수.current} : 현재의 인덱스
> - $(변수.index} : 0부터의 인덱스
> - $(변수.count} : 1부터의 인덱스
> - $(변수.first} : 현재 루프가 처음인지 확인
> - $(변수.last} : 현재 루프가 마지막인지 확인
> - $(변수.begin} : forEach문의 시작 값
> - $(변수.end} : forEach문의 끝 값
> - $(변수.step} : forEach문의 증가 값

```html
<c:forEach var="vo" items="${list}">
  <li><input type="checkbox" name="noList" value="${vo.no}" class="chk" /></li>
  <li>${vo.no}</li>
  <li><a href="/myapp/board/boardView?no=${vo.no}">${vo.subject}</a></li>
  <li>${vo.userid}</li>
  <li>${vo.hit}</li>
  <li>${vo.writedate}</li>
</c:forEach>

<!-- 정수 범위내의 반복 Syntax -->
<c:forEach
  var="name"
  varStatus="name"
  begin="expression"
  end="expression"
  step="expression"
>
  body content
</c:forEach>

<!-- 컬렉션 범위내의 반복 Syntax -->
<c:forEach
  var="name"
  items="expression"
  varStatus="name"
  begin="expression"
  end="expression "
  step="expression"
>
  body content
</c:forEach>

<!-- forEach 정수 범위내의 반복 -->
<c:forEach var="i" begin="0" end="10" step="2" varStatus="x">
  <p>i = ${i}, i*i = ${i * i} <c:if test="${x.last}">, last = ${i}</c:if></p>
</c:forEach>

<!-- forEach 컬렉션 범위내의 반복 -->
<% java.util.List list = new java.util.ArrayList(); java.util.Map map = new
java.util.HashMap(); map.put("color","red"); list.add(map); map = new
java.util.HashMap(); map.put("color","blue"); list.add(map); map = new
java.util.HashMap(); map.put("color","green"); list.add(map);
request.setAttribute("list", list); %>

<c:forEach var="map" items="${list}" varStatus="x">
  <p>map(${x.index}) = ${map.color}</p>
</c:forEach>
```

### 반복문 (forTokens)

> 문자열을 구분자(delimiter)로 분할
>
> - var="현재 아이템의 변수 명"
> - items="반복 데이터가 있는 아이템 Collection 명"
> - delims="구분자, 여러개 지정 가능"
> - begin="시작 값, 기본 값은 0"
> - end="종료 값"
> - step="증가 값"
> - varStatus="반복 상태 값을 지닌 변수"

```html
<!-- Syntax -->
<c:forTokens
  var="name"
  items="expression"
  delims="expression"
  varStatus="name"
  begin="expression"
  end="expression"
  step="expression"
>
  body content
</c:forTokens>

<!-- 간단 사용 예 -->
<b>
  <c:forTokens
    var="color"
    items="빨|주|노|초|파|남|보"
    delims="|"
    varStatus="i"
  >
    <c:if test="${i.first}">color : </c:if>
    ${color} <a href="<c:url value='/TEST.jsp' />"> View Test </a>
    <c:if test="${!i.last}">,</c:if>
  </c:forTokens>
</b>
```

### 조건문 (if) - else 구문이 없음

> - test="조건식"
> - var="조건식 결과를 저장할 변수 선언"
> - scope="조건식 결과를 저장할 변수의 저장 scope 지정"
> - <c:if>조건식이 참일 경우 반복할 내용</c:if>

```html
<c:if test="${logStatus !='Y'}">
  <a href="${url}/member/loginForm">로그인</a>
  <a href="${url}/member/memberForm">회원가입</a>
</c:if>
<c:if test="${logStatus =='Y'}">
  <a href="${url}/member/logout">로그아웃</a>
  <a href="${url}/member/memberEdit">회원정보 수정</a>
</c:if>

<c:set var="login" value="true" />
<c:if test="${!login}">
  <p><a href="/login.ok">로그인</a></p></c:if
>
<c:if test="${login}">
  <p><a href="/logout.ok">로그아웃</a></p></c:if
>
<!-- 아래 예제와 같이 null 비교를 하지 않고 empty 비교를 하면 null과 ""를 동시에 체크할 수 있다. -->
<c:if test="${!empty country}"
  ><p><b>${country}</b></p></c:if
>
```

### 조건문 (choose, when, otherwise)

> - test="조건식"

```html
<c:choose>
  <c:when test="조건식1"> 조건식1이 참일 경우 실행할 내용 </c:when>
  <c:when test="조건식2"> 조건식2이 참일 경우 실행할 내용 </c:when>
  <c:otherwise> 조건식1과 조건식2 모두 참이 아닐 경우 실행할 내용 </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${logStatus != 'Y'}">
    <li><a href="${url}/member/loginForm">로그인</a></li>
    <li><a href="${url}/member/memberForm">회원가입</a></li>
  </c:when>
  <c:when test="${logStatus == 'Y'}">
    <li>
      <span style="font-size:0.8em;color:#ddd;">${logId} </span
      ><a href="${url}/member/logout">로그아웃</a>
    </li>
    <li><a href="${url}/member/memberEdit">회원정보 수정</a></li>
  </c:when>
</c:choose>
```

### URL

> URL 생성
>
> - var="생성한 URL이 저장될 변수 명"
> - value="생성할 URL"
> - scope="변수 공유 범위"

```html
<a href="<c:url value='/TEST.jsp' />"> View Test </a>
```

### Parameter

> 파라미터 추가
>
> - name="파라미터 명"
> - value="값"

```html
<c:url value="TEST.jsp" var="paramTest">
   <c:param name="data1" value="1000" />
   <c:param name="data2" value="2000" />
</c:url>

<a href="${paramTest}"
   View TEST with data1(1000), data2(2000)
</a>
```

### import

> 페이지 첨부  
> import 태그 내에서 param 태그도 사용할 수 있다.
>
> - url="첨부할 URL"

```html
<c:import url="/TEST1.jsp" />
<c:import url="/TEST2.jsp">
  <c:param name="data1" value="1000" />
  <c:param name="data2" value="2000" />
</c:import>
```

### redirect

> sendRedirect()와 비슷
>
> - url="이동할 URL"

```html
<c:redirect url="http://localhost:8080" />
```

## TLD(Tag Library Descriptor)

JSP에서 사용되는 커스텀 태그나 JSTL의 태그들에 대한 설정 파일  
개발한 태그 핸들러에 대해 속성이나 속성의 타입, 태그명, uri 등을 정의해두는 설정

확장자 : `*.tld`

`web.xml`과 마찬가지로 웹 어플리케이션(src/main/webapp) 경로의 `WEB-INF` 디렉토리 하위에 작성해야 인식됨  
JSP 1.2 버전의 경우 `web.xml` 파일에 tld 파일에 대한 추가 설정이 필요하며,  
JSP 2.0 이상인 경우 `WEB-INF` 하위에만 작성하면 자동으로 인식된다.  
tld 파일은 XML 기반이며 `dtd`나 `schema`를 tld 파일 상단에 명시해야 한다.
