# Spring 예제 보면서 배우기
[refs](https://spring.io/guides/gs/rest-service/) 

# Create a Resource Representation Class
이 서비스는 /greeting 에 대한 GET requests를 처리하며, 선택적으로 쿼리 문자열에 name 파라미터를 가질 수 있다.  
GET 요청은 본문에 greeting을 나타내는 JSON과 함께 200 OK 응답을 반환해야 한다.  
```
{
    "id": 1,
    "content": "Hello, World!"
}
```
