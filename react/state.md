# state

## state의 특징

> 컴포넌트 간에 데이터를 공유하고 싶다면, 해당 컴포넌트들을 모두 포함하는 상위 컴포넌트에 state를 선언하고 두 자식 컴포넌트에 전달한다.  
> props를 사용한 컴포넌트 간의 state 공유를 'state 올리기'라고 한다.  
> state를 위로 이동하여 컴포넌트 간에 state를 공유하는 것이다.  

### 독립성과 비공개

> state는 화면에서 컴포넌트 인스턴스에 지역적이다. 
>  
> - 동일한 컴포넌트를 두 번 렌더링하면 각 복사본은 완전히 격리된 state를 가짐  
> - 대신, 화면의 특정 위치에 지역적이다. 같은 컴포넌트를 두 번 렌더링하면 그들의 state는 별도로 저장된다.  

> props와 달리, state는 선언한 컴포넌트에 완전히 비공개이다.  
> 부모 컴포넌트는 이를 변경할 수 없다.  


## state 변수가 필요한 순간

> 지역 변수는 렌더링 간에 유지되지 않는다.  
> - 같은 컴포넌트를 두 번째로 렌더링할 때 지역 변수에 대한 변경 사항은 고려하지 않고 처음부터 렌더링한다.  
>  
> 지역 변수를 변경해도 렌더링을 일으키지 않는다.  
> - 리액트가 새로운 데이터로 다시 렌더링해야 하는 것을 인식하지 못함  

즉, 컴포넌트를 새로운 데이터로 업데이트하기 위해선 두 가지가 필요하다.  

1. 렌더링 사이에 데이터를 **유지**  
2. 리액트가 새로운 데이터로 컴포넌트를 렌더링하도록 **유발**  

`useState` 훅은 이 두 가지를 제공한다.  

1. 렌더링 간에 데이터를 유지하기 위한 **state 변수**  
2. 변수를 업데이트하고 리액트가 컴포넌트를 다시 렌더링하도록 유발하는 **state setter 함수**  

## state 변수 추가

파일 상단의 React에서 `useState`를 가져온다.  

```javascript
import { useState } from 'react';

const [index, setIndex] = useState(0);

function handleClick() {
    setIndex(index + 1);
}
```

- 이때 `index`는 state 변수, `setIndex`는 setter 함수다.  
- 여기서 사용하는 `[]` 문법은 자바스크립트의 배열 구조 분해다.  
- `useState`가 반환하는 배열에는 항상 두 개의 항목이 있다.  

서로 연관이 없는 경우 여러 개의 state 변수를 가지는 것이 좋다.  
두 state 변수를 자주 함께 변경한다면(필드가 많은 form 등) 하나의 객체 state 변수를 사용하는 것이 편리하다.  

## hooks

> ```use``` 로 시작하는 함수를 *Hooks*라고 하며, ```useState``` 는 리액트에서 제공하는 내장 Hook이다.  
>  
> Hooks는 다른 함수보다 더 제한적이다.  
> 컴포넌트(또는 다른 Hooks)의 최상단 또는 커스텀 훅에서만 Hooks를 호출할 수 있다.  
> - 파일 상단에서 모듈을 "import"하는 것과 유사하게 컴포넌트 상단에서 리액트 기능을 "사용"한다.  
>  
> 훅은 리액트가 오직 렌더링 중일 때만 사용할 수 있다.  

### `useState`

state 변수와 state setter 함수의 이름은 원하는 대로 지을 수 있지만, 규칙을 사용하면 더 쉽게 이해할 수 있다.  
`const [something, setSomething]`  

> `useState`의 유일한 인수(arguments)는 state 변수의 **초깃값**이다.  

## 리액트가 state를 알아내는 방법

> 훅은 동일한 컴포넌트의 모든 렌더링에서 안정적인 호출 순서에 의존한다.  
> "최상단에서만 훅을 호출"한다는 규칙을 따르면, 훅은 항상 같은 순서로 호출되므로 잘 작동한다.  
>  
> 내부적으로 리액트는 모든 컴포넌트에 대해 한 쌍의 state 배열을 가진다.  
또한 렌더링 전에 `0`으로 설정된 현재 인덱스 쌍을 유지한다.  
> `useState`를 호출할 때마다, 다름 state 쌍을 제공하고 인덱스를 증가시킨다.  

## state와 렌더링

`render.md` 내용 참조

## 시간 경과에 따른 state

`render.md` 내용 참조

## state 업데이트 큐

`render.md` 내용 참조

## 객체 state 업데이트

state는 객체를 포함한 모든 종류의 자바스크립트 값을 가질 수 있다.  
하지만 state가 가진 객체를 직접 변경하면 안 된다.  
새로운 객체를 생성하여 (또는 기존 객체의 복사본으로), state가 복사본을 사용하도록 한다.  

다시 말해, state에 저장한 자바스크립트 객체는 어떤 것이라도 **읽기 전용**인 것처럼 다루어야 한다.  

`position.x = e.clientX;` 이처럼 기술적으로 객체 자체의 내용은 바꿀 수 있고, 이것을 **변경(mutation)**이라고 한다.  
그러나 기술적으로 가능할지라도, **숫자/불리언/문자열과 같이 불변성을 가진 것처럼** 다루어야 한다.  

> 잘못된 state 객체 변경  
>  
> - `position`에 할당된 객체를 이전 렌더링에서 수정하기 때문에 리액트가 객체의 변경을 감지할 수 없다.  

```javascript
onPointerMove={e => {
    position.x = e.clientX;
    position.y = e.clientY;
}}
```

> 올바른 state 객체 변경  
>  
> - 리렌더링을 발생시키려면, **새 객체를 생성하여 state 설정 함수로 전달**한다.  
> - `setPosition`은 리액트에게 다음과 같이 요청한다.  
>   > - `position`을 새로운 객체로 교체
>   > - 이 컴포넌트를 리렌더링  

```javascript
onPointerMove={e => {
    setPosition({
        x: e.clientX,
        y: e.clientY
    });
}}
```

> 로컬 변경은 괜찮다. 변경은 이미 state에 존재하는 객체를 변경할 때만 문제가 된다.  
> 컴포넌트 내에서 만든 객체를 수정하는 것은 아직 다른 코드가 해당 객체를 참조하지 않으므로 괜찮다.  

```javascript
const nextPosition = {};
nextPosition.x = e.clientX;
nextPosition.y = e.clientY;
setPosition(nextPosition);

// 아래와 같이 작성할 수 있다.
setPosition({
    x: e.clientX,
    y: e.clientY
});
```

### Spread 문법으로 객체 복사

새로 생성하는 객체에 기존에 존재하는 데이터를 포함하고 싶을 수 있다.  
(예를 들어 폼에서 단 한개의 필드만 수정 후, 나머지 모든 필드는 이전 값을 유지하고 싶은 경우 등)  

```javascript
setPerson({
    firstName: e.target.value, // input의 새로운 first name
    lastName: person.lastName,
    email: person.email
});
```

이럴 때 `...` 객체 전개 구문을 사용하여 모든 프로퍼티를 복사할 수 있다.  

```javascript
setPerson({
    ...person, // 이전 필드를 복사
    firstName: e.target.value // 새로운 부분은 덮어쓰기
});
```

각 필드에 대해 분리된 state를 선언하지 않고, 한 객체에 모든 데이터를 그룹화하여 저장하는 것이 편리하다.  

> `...` 전개 문법은 '얕다': 한 레벨 깊이의 내용만 복사한다.  
> 빠르고 간편하지만, 중첩된 프로퍼티를 업데이트하고 싶다면 한 번 이상 사용해야 한다는 의미다.  

### 여러 필드에 대해 단일 이벤트 핸들러 사용

`[]` 괄호를 객체 정의 안에 사용하여 동적 이름을 가진 프로퍼티를 명시할 수 있다.  

```javascript
function handleChange(e) {
    setPerson({
        ...person,
        [e.target.name]: e.target.value
    });
}

<label>
    First name:
    <input
        name="firstName" // 동적으로 프로퍼티의 이름을 명시
        value={person.firstName}
        onChange={handleChange}
    />
</label>
<label>
    Last name:
    <input
        name="lastName" // 동적으로 프로퍼티의 이름을 명시
        value={person.lastName}
        onChange={handleChange}
    />
</label>
<label>
    Email:
    <input
        name="email" // 동적으로 프로퍼티의 이름을 명시
        value={person.email}
        onChange={handleChange}
    />
</label>
<p>
    {person.firstName}{' '}
    {person.lastName}{' '}
    ({person.email})
</p>
```

- `e.target.name`은 `<input>` DOM 엘리먼트의 `name` 프로퍼티를 나타냄  

### 중첩된 객체 갱신

아래와 같이 중첩된 객체 구조가 있다.  

```javascript
const [person, setPerson] = useState({
    name: 'Niki de Saint Phalle',
    artwork: {
        title: 'Blue Nana',
        city: 'Hamburg',
        image: 'https://i.imgur.com/Sd1AgUOm.jpg',
    }
});
```

`person.artwork.city`를 업데이트하고 싶다면 새로운 `artwork` 객체를 생성한 뒤, 그것을 가리키는 새로운 `person` 객체를 만들거나 함수를 호출할 수 있다.  

```javascript
const nextArtwork = { ...person.artwork, city: 'New Delhi' };
const nextPerson = { ...person, artwork: nextArtwork };
setPerson(nextPerson);

// 함수 호출 방식
setPerson({
    ...person, // 다른 필드 복사
    artwork: { // artwork 교체
        ...person.artwork, // 동일한 값 사용
        city: 'New Delhi' // 하지만 New Delhi!
    }
});
```

### 객체는 실제로 중첩된 것이 아니다

> 위에서 본 중첩된 객체는 코드로 보기에 중첩되어 보인다.  
> 그러나 '중첩'은 객체의 동작을 이해하기에 부정확한 방법이다. 코드가 실행될 때, 중첩된 객체는 존재하지 않는다.  
> 실제로는 두 개의 다른 객체를 보는 것이다.  

```javascript
let obj1 = {
    title: 'Blue Nana',
    city: 'Hamburg',
    image: 'https://i.imgur.com/Sd1AgUOm.jpg',
};

let obj2 = {
    name: 'Niki de Saint Phalle',
    artwork: obj1
};
```

> `obj1` 객체는 `obj2` '안'에 존재하는 게 아니다.
> `obj3` 또한 `obj1`을 가리킬 수 있기 때문이다.  

```javascript
let obj1 = {
    ...
};

let obj2 = {
    ...
    artwork: obj1
};

let obj3 = {
    ...
    artwork: obj1
};
```

> `obj3.artwork.city`을 변경하려 했다면, `obj2.artwork.city`와 `obj1.city` 둘 다에 영향을 미친다.  
> `obj3.artwork`, `obj2.artwork`, `obj1`이 같은 객체이기 때문이다.  
> 이처럼 객체를 중첩된 것으로 이해하지 말고, 프로퍼티를 통해 서로를 **'가리키는'** 각각의 객체로 이해하자.  

## 배열 state 업데이트

> 자바스크립트에서 배열은 다른 종류의 객체다. 객체와 마찬가지로 읽기 전용으로 처리해야 한다.  
> 즉, `arr[0] = 'bird'`처럼 배열 내부의 항목을 재할당하면 안 되며 `push()`나 `pop()` 같은 함수로 변경해서도 안 된다.  
> 대신 배열을 업데이트할 때마다 새 배열을 state 설정 함수에 전달한다.  
> 원본 배열을 변경하지 않는 `filter()`, `map()` 같은 함수를 사용한다.  

일반적인 배열 연산에 대한 참조 표  

> 리액트 state 내에서 배열을 다룰 땐, 오른쪽 열의 함수를 선호한다.  

| | <center>비선호 (배열을 변경)</center> | <center>선호 (새 배열을 반환)</center> |
| :---: | :--- | :--- |
| 추가 | `push`, `unshift` | `concat`, `[...arr]` 전개 연산자 |
| 제거 | `pop`, `shift`, `splice` | `filter`, `slice` |
| 교체 | `splice`, `arr[i] = ...` 할당 | `map` |
| 정렬 | `reverse`, `sort` | 배열을 복사한 이후 처리 |

- `slice`: 배열 또는 그 일부를 복사  
- `splice`: 배열을 **변경**(항목을 추가하거나 제거)  

### 배열에 항목 추가

```javascript
// 원치 않는 방식
artists.push({
    id: nextId++,
    name: name,
});

// 바람직한 방식(push()와 동등한 결과)
setArtists( // 아래의 새로운 배열로 state를 변경
    [
        // 배열 전개 구문
        ...artists, // 기존 배열의 모든 항목에,
        { id: nextId++, name: name } // 마지막에 새 항목을 추가
    ]
);

// 기존 배열 앞에 항목을 배치하는 방법(unshift()와 동등한 결과)
setArtists([
    { id: nextId++, name: name }, // 추가할 항목을 앞에 배치하고,
    ...artists // 기존 배열의 항목들을 뒤에 배치
]);
```

### 배열에서 항목 제거

> `filter` 함수를 사용하여 필터링한다.  
> 즉, 해당 항목을 포함하지 않는 새 배열을 제공한다.  

```javascript
setArtists(
    artists.filter(a => a.id !== artist.id)
);
```

- "`artist.id`와 ID가 다른 `artists`로 구성된 배열을 생성한다" 라는 의미  

### 배열 변환하기

> `map()`을 사용해 배열의 일부 또는 전체 항목이 변경된 새로운 배열을 생성한다.  
> `map`에 전달할 함수는 데이터나 인덱스(또는 둘 다)를 기반으로 각 항목을 어떻게 처리할지 결정할 수 있다.  

```javascript
function handleClick() {
    const nextShapes = shapes.map(shape => {
    if (shape.type === 'square') {
        // 변경시키지 않고 반환합니다.
        return shape;
    } else {
        // 50px 아래로 이동한 새로운 원을 반환합니다.
        return {
            ...shape,
            y: shape.y + 50,
        };
    }
    });
    // 새로운 배열로 리렌더링합니다.
    setShapes(nextShapes);
}
```

### 배열 내 항목 교체하기

> 이 경우에도 `map`을 사용하는 편이 좋다.  
> `map`을 이용해서 새로운 배열을 만들 때 두 번째 인수로 항목의 인덱스를 받을 수 있다.  
> 인덱스는 원래 항목(첫 번째 인수)을 반환할지 다른 항목을 반환할지를 결정할 때 사용한다.  

```javascript
function handleIncrementClick(index) {
    const nextCounters = counters.map((c, i) => {
    if (i === index) {
        // 클릭된 counter를 증가시킵니다.
        return c + 1;
    } else {
        // 변경되지 않은 나머지를 반환합니다.
        return c;
    }
    });
    setCounters(nextCounters);
}
```

### 배열에 항목 삽입하기

항목을 시작, 끝이 아닌 중간에 삽입하는 경우 `...` 전개 구문과 `slice()` 함수를 사용한다.  
삽입 지점 앞에 자른 배열을 전개하고, 새 항목과 원본 배열의 나머지 부분을 전개하는 배열을 만든다.  

- 이 예시에서 삽입 버튼은 항상 인덱스 `1`에 삽입된다.  
- `slice(start, end - 1)`  

```javascript
function handleClick() {
    const insertAt = 1; // 모든 인덱스가 될 수 있다.
    const nextArtists = [
        // 삽입 지점 이전 항목
        ...artists.slice(0, insertAt), // 0 ~ insertAt
        // 새 항목
        { id: nextId++, name: name },
        // 삽입 지점 이후 항목
        ...artists.slice(insertAt) // insertAt ~ 
    ];
    setArtists(nextArtists);
    setName('');
}
```

### 배열에 기타 변경 적용

> 전개 구문과 `map()`, `filter()` 같은 비-변경 함수들만으로는 할 수 없는 일이 몇 가지 있다.  
> 예를 들어, 배열을 뒤집거나 정렬하는 `reverse()` 및 `sort()` 함수는 원본 배열을 변경시키므로 직접 사용하지 못한다.  
> 대신, **먼저 배열을 복사한 뒤 변경**한다.  

```javascript
    function handleClick() {
        const nextList = [...list];
        nextList.reverse();
        setList(nextList);
    }
```

**그러나 배열을 복사하더라도 배열 내부에 기존 항목을 직접 변경해서는 안 된다.**  

> 얕은 복사이기 때문에 복사한 새 배열은 원본 배열과 동일한 항목이 포함된다.  
> 따라서 복사된 배열 내부의 객체를 수정하면 기존 state가 변경된다.  
> 아래와 같은 코드가 문제가 된다.  

```javascript
// 잘못된 예시
const nextList = [...list];
nextList[0].seen = true; // 문제: list[0]을 변경시킨다.
setList(nextList);
```

- `nextList`와 `list`는 서로 다른 배열이지만,  
- **`nextList[0]`과 `list[0]`은 동일한 객체를 가리킨다.**  
    - 따라서 `nextList[0].seen`을 변경하면 `list[0].seen`도 변경된다.  
- 변경하려는 개별 항목을 변경하는 대신 복사한다. 방법은 [아래](#배열-내부의-객체-업데이트)와 같다.  

## 배열 내부의 객체 업데이트

> 객체는 실제로는 배열 '내부'에 위치하지 않는다. 코드에서 '내부'로 나타낼 수 있어도  
> 배열의 각 객체는 배열이 '가리키는' 별도의 값이다.  
> 중첩된 state를 업데이트할 때, **업데이트하려는 지점부터 최상위 레벨까지의 복사본을 만들어야 한다.**  

```javascript
// 잘못된 예시
const myNextList = [...myList];
const artwork = myNextList.find(a => a.id === artworkId);
artwork.seen = nextSeen; // 문제: 기존 항목을 변경시킨다.
setMyList(myNextList);
```

**`map`을 사용하면 이전 항목의 변경 없이 업데이트된 버전으로 대체할 수 있다.**  

```javascript
setMyList(myList.map(artwork => {
    if (artwork.id === artworkId) {
        // 변경된 *새* 객체를 만들어 반환
        return { ...artwork, seen: nextSeen };
    } else {
        // 변경시키지 않고 반환
        return artwork;
    }
}));
```

## 왜 state를 변경하는 것을 권장하지 않는가

- 디버깅: 만약 `console.log`를 사용하고 state를 변경하지 않는다면, 과거 로그들은 가장 최근 state 변경 사항에 의해 지워지지 않는다.  
따라서 state가 렌더링 사이에 어떻게 바뀌었는지 명확하게 알 수 있다.  
- 최적화: 보편적인 리액트 최적화 전략은 이전 props 또는 state가 다음 것과 동일할 때 작업을 건너뛰는 것에 의존한다.  
state를 절대 변경하지 않는다면 변경사항이 있었는지 확인하는 작업이 매우 빨라진다.  
`prevObj === obj`를 통해 내부적으로 아무것도 바뀌지 않았음을 확인할 수 있다.  
- 새로운 기능: 새로운 리액트 기능들은 스냅샷처럼 다루어지는 것에 의존한다.  
만약 state의 과거 버전을 변경한다면, 새로운 기능을 사용하지 못할 수 있다.  
- 요구사항 변화: 취소/복원 구현, 변화 내역 조회, 사용자가 이전 값을 재설정하기 등의 기능은 데이터가 변하지 않았을 때 더 쉽다. 메모리에 state의 이전 복사본을 저장하여 다시 사용할 수 있기 때문이다.  
- 더 간단한 구현: 변경에 의존하지 않으므로 객체로 특별한 것을 할 필요가 없다.  
프로퍼티를 가져오기, 프록시로 감싸기, 초기화 등 다른 작업이 불필요하다.  
이것은 리액트가 state에 추가적인 성능 또는 정확성 함정 없이 아무 객체나 넣을 수 있게 해주는 이유이기도 하다.  