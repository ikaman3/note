# Spring
Spring의 폼 태그는 커맨드 객체(데이터 모델)를 사용하여 HTML 폼 입력 필드와 데이터를 바인딩한다.  
폼 입력 필드의 값을 커맨드 객체의 속성에 자동으로 매핑하여 컨트롤러에 전달한다.  
예를 들어, <form:form> 태그를 사용하여 폼을 정의하고, <form:input> 또는 <form:select> 등의 태그를 사용하여 폼 필드를 생성한다. 그런 다음 이러한 필드들은 Spring 컨트롤러에 전송되고, 컨트롤러는 해당 필드들의 값을 커맨드 객체에 바인딩하여 사용할 수 있다.  
```
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
```
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

