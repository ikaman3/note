# Python Syntax

# 목차

[Python Official Documents](https://docs.python.org/ko/3.13/library/functions.html)

# Numeric / 숫자
## sum
> iterable 객체의 모든 요소를 더한 값을 반환한다.  
> 숫자 list, stack.data, tuble 등 사용할 수 있다.
```
sum(numStack.data)
```  
# String / 문자열
## split
> 문자열을 sep(구분자)로 나눠 리스트로 반환한다.  
> 반환된 리스트의 원소들은 문자열이다.  
> sep를 지정하지 않으면 기본은 공백문자, 줄바꿈이다.  
> maxsplit : 기본값은 -1이다. 제한없이 자를 수 있을 때 까지 문자열 전체를 자른다.

> str.split()  
> str.split(',')  
> str.split(',', 1)  
> str.split(sep=',', maxsplit=2)  

# List / 리스트
## append
> 리스트의 맨 끝에 원소를 덧붙이는 메서드
```
list.append(5)
```
## pop
> 리스트의 맨 끝에서 원소를 꺼내는 메서드(원소 자체가 리스트에서 제거됨)
```
list.pop()
list.pop(0)
```
> append, pop 메서드를 함께 사용하면 리스트를 Stack 자료구조로 사용할 수 있다.  
> pop 메서드를 아무 인자없이 호출하면 맨 끝의 원소를 삭제하면서 반환한다.  
> pop 메서드에 인덱스를 주고 호출하면 해당 인덱스 원소를 삭제하면서 반환한다.  
> - 이때 뒤의 원소들은 한 칸씩 앞으로 당겨진다.

# Class / 클래스
## dir()
> Python의 내장 함수로, 어떤 객체를 인자로 넣어주면 해당 객체가 어떤 변수와 메서드를 가지고 있는지 나열한다.
```
Q = Queue()
dir(Q)
```