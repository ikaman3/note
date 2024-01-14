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

# Class / 클래스
## dir()
> Python의 내장 함수로, 어떤 객체를 인자로 넣어주면 해당 객체가 어떤 변수와 메서드를 가지고 있는지 나열한다.
```
Q = Queue()
dir(Q)
```

# List / 리스트
## append
> 리스트의 맨 끝에 원소를 덧붙이는 메서드
```
list.append(5)
```
> 딕셔너리의 키와 값으로 이루어진 튜플의 리스트 생성  
```
list_of_tuples = list(my_dict.items())
# 출력: [('a', 1), ('b', 2), ('c', 3)]
```
> 딕셔너리의 키와 값으로 이루어진 리스트 생성  
```
list_of_lists = [[key, value] for key, value in my_dict.items()]
# 출력: [['a', 1], ['b', 2], ['c', 3]]
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

# Hash / 해시
## hash()
> 내장 함수이며 입력된 객체의 해시 값을 반환한다.  
> 일반적으로 immutable한 객체들은 동일한 입력이 주어진 경우 항상 동일한 해시 값을 반환한다.  
> - 숫자, 문자열, 튜플 등이 해당
```
hashValue = hash("example")
```
## hashlib
> 다양한 해시 함수를 제공하는 모듈  
> 주로 데이터의 무결성을 확인하는 데 사용된다.  
```
import hashlib
data = "example"
sha256_hash = hashlib.sha256(data.encode()).hexdigest()
```

# Dictionary / 딕셔너리
> 해시 가능한 자료형을 활용  
> 딕셔너리의 키로 사용되는 객체는 해시 가능 (hashable) 해야 한다.  
> - 즉, 동일한 키 값은 동일한 해시 값을 가져야 한다.
> - 문자열, 숫자, 튜플 등이 해시 가능한 자료형
> - 리스트 같은 가변적인 (mutable) 자료형은 해시 불가능이며 키로 사용할 수 없음

> dict() : 키와 값을 연결하거나 리스트, 튜플, 딕셔너리로 딕셔너리를 만들 때 사용  
> - dict(key1=val1, key2=val2) : ''이나 "" 사용하지 않음. 키는 문자열로 바뀜
> - dict(zip([key1, key2], [val1, val2])) : zip 내장 함수 이용
> - dict([(key1=val1), (key2=val2)]) : 리스트로 튜플을 나열하는 방법
> - dict({key1: val1, key2: val2})  

> .keys() : 딕셔너리의 키를 얻는 메서드  
> - 반환 값 : ```dict_keys(['leo', 'kiki', 'eden'])```  

> .values() : 딕셔너리의 값을 얻는 메서드  
> - 반환 값 : ```dict_values([1, 0, 0])```  

> .items() : 딕셔너리의 키와 값을 얻는 메서드  
> - 반환 값 : ```dict_items([('leo', 1), ('kiki', 0), ('eden', 0)])```  

> 리스트 컴프리헨션과 조건문을 사용하여 딕셔너리의 값을 조건에 따라 처리하는 방법  
```
keys_with_nonzero_values = [key for key, value in my_dict.items() if value != 0]
# 출력: ['a', 'c', 'e']
```

> Counter() : 등장한 원소의 개수를 세는 데 유용한 클래스  
> ```
> print(Counter(participant))
> # 결과
> # Counter({'leo': 1, 'kiki': 1, 'eden': 1})
> ```
```
# 기본적인 딕셔너리 생성 방법
dict = {'a': 1, 'b': 2}
lux1 = dict(health=490, mana=334, melee=550, armor=18.72)
lux2 = dict(zip(['health', 'mana', 'melee', 'armor'], [490, 334, 550, 18.72]))
lux3 = dict([('health', 490), ('mana', 334), ('melee', 550), ('armor', 18.72)])
lux4 = dict({'health': 490, 'mana': 334, 'melee': 550, 'armor': 18.72})

# 문자열로 이루어진 리스트에서 등장한 문자열을 키로 사용하고, 
# 동일한 문자열이 반복 등장하면 그 값을 1 증가시키는 코드
from collections import Counter
partDict = dict(Counter(participant)) 
```
