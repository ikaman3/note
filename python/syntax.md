# Python 문법 정리

[Python Official Documents](https://docs.python.org/ko/3.13/library/functions.html)

# 숫자
## sum
> iterable 객체의 모든 요소를 더한 값을 반환한다.  
> 숫자 list, stack.data, tuble 등 사용할 수 있다.
```
sum(numStack.data)
```  
# 문자열
## split
> 문자열을 sep(구분자)로 나눠 리스트로 반환한다.  
> 반환된 리스트의 원소들은 문자열이다.  
> sep를 지정하지 않으면 기본은 공백문자, 줄바꿈이다.  
> maxsplit : 기본값은 -1이다. 제한없이 자를 수 있을 때 까지 문자열 전체를 자른다.

> str.split()  
> str.split(',')  
> str.split(',', 1)  
> str.split(sep=',', maxsplit=2)  