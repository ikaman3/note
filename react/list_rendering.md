# List Rendering

데이터 모음에서 유사한 컴포넌트를 여러 개 표시할 때 사용  
자바스크립트 배열 메서드를 사용하여 데이터 배열을 조작할 수 있다.  

## 배열을 데이터로 렌더링

1. 데이터를 배열로 이동  

```
const people = [
    'Creola Katherine Johnson: mathematician',
    'Mario José Molina-Pasquel Henríquez: chemist',
    'Mohammad Abdus Salam: physicist',
    'Percy Lavon Julian: chemist',
    'Subrahmanyan Chandrasekhar: astrophysicist'
];
```

2. `people`의 요소를 새로운 JSX 노드 배열인 `listItems`에 매핑  

`const listItems = people.map(person => <li>{person}</li>);`  

3. `<ul>`로 매핑된 컴포넌트의 `listItems`를 반환  

`return <ul>{listItems}</ul>;`  

## 배열의 항목 필터링

더 구조화된 데이터에서 직업이 `chemist`인 사람만 표시하는 방법  

```
const people = [{
    id: 0,
    name: 'Creola Katherine Johnson',
    profession: 'mathematician',
}, {
    id: 1,
    name: 'Mario José Molina-Pasquel Henríquez',
    profession: 'chemist',
}, {
    id: 2,
    name: 'Mohammad Abdus Salam',
    profession: 'physicist',
}, {
    name: 'Percy Lavon Julian',
    profession: 'chemist',
}, {
    name: 'Subrahmanyan Chandrasekhar',
    profession: 'astrophysicist',
}];
```

1. `people`에서 `filter()`를 호출해 `person.profession === 'chemist'`로 필터링하여, 'chemist'로만 구성된 새로운 배열 `chemists` 생성  

```
const chemists = people.filter(person =>
    person.profession === 'chemist'
);
```

2. `chemists` 매핑  

```
const listItems = chemists.map(person =>
    <li>
        <img
            src={getImageUrl(person)}
            alt={person.name}
        />
        <p>
            <b>{person.name}:</b>
            {' ' + person.profession + ' '}
            known for {person.accomplishment}
        </p>
    </li>
);
```

3. 컴포넌트에서 `listItems` 반환  

`return <ul>{listItems}</ul>;`  

## 리스트 항목 순서대로 유지

각 배열 항목에 고유하게 식별가능한 문자열 또는 숫자를 `key`로 지정해야 한다.  

> **중요**: `map()` 호출 내부의 JSX 엘리먼트는 항상 key가 필요하다.  

`<li key={person.id}>...</li>`

key는 각 컴포넌트가 어떤 항목에 해당하는지 리액트에 알려주어 일치시키도록 한다.  
정렬이나 삽입, 삭제하는 경우 중요해진다.  
즉석에서 key를 생성하는 대신 데이터 안에 key를 포함해야 한다.  

```
export const people = [{
    id: 0, // JSX에서 key로 사용됩니다.
    ...
}, {
    id: 1, // JSX에서 key로 사용됩니다.
    ...
}, {
    id: 2, // JSX에서 key로 사용됩니다.
    ...
}, {
    id: 3, // JSX에서 key로 사용됩니다.
    ...
}, {
    id: 4, // JSX에서 key로 사용됩니다.
    ...
}];

<li key={person.id}>
    <img
        src={getImageUrl(person)}
        alt={person.name}
    />
</li>
```

## 각 리스트 항목에 대해 여러 DOM 노드 표시

각 항목이 하나가 아닌 여러 개의 DOM 노드를 렌더링할 경우  
짧은 `<></>` fragment 구문으로 key를 전달할 수 없으므로  
key를 단일 `<div>`로 그룹화하거나 명시적인 `<Fragment>` 문법을 사용한다.  

```
import { Fragment } from 'react';

// ...

const listItems = people.map(person =>
    <Fragment key={person.id}>
        <h1>{person.name}</h1>
        <p>{person.bio}</p>
    </Fragment>
);
```

Fragment는 DOM에서 사라지므로 `<h1>`, `<p>`, `<h1>`, `<p>` 등의 평평한 리스트가 생성된다.  

## `key`를 가져오는 곳

> 데이터베이스의 데이터: DB에서 데이터를 가져오는 경우 본질적으로 고유한 DB key/ID를 사용할 수 있다.  

> 로컬에서 생성된 데이터: 데이터가 로컬에서 생성되고 유지되는 경우(예: 메모 작성 앱의 노트 등), 항목을 만들 때 증분(auto increment) id나 `crypto.randomUUID()` 또는 `uuid` 같은 패키지를 사용할 것  

## key 규칙

> key는 형제 간에 고유해야 한다.  
> 하지만 같은 key를 *다른* 배열의 JSX 노드에 동일한 key를 사용해도 괜찮다.  

> key는 변경되어서는 안 되므로 렌더링 중에는 key를 생성하지 말 것  

**주의사항**  
> key를 전혀 지정하지 않으면 리액트는 배열에서 항목의 인덱스를 key로 사용한다.  
> 이는 삽입, 삭제, 배열의 정렬 등이 일어나면 렌더링 순서가 변경되므로 버그가 발생할 수 있다.  

> `key={Math.random()}` 처럼 즉석에서 key를 생성하지 마라.  
> 렌더링 간에 key가 일치하지 않아 모든 컴포넌트와 DOM이 매번 다시 생성된다.  
> 속도도 느려지고 리스트 항목 내부의 모든 사용자 입력도 손실된다.  

> 컴포넌트는 key를 prop으로 받지 않는다.  
> key는 리액트 자체에서 힌트로만 사용된다.  
> 컴포넌트에 ID가 필요하다면 `<Profile key={id} userId={id} />` 처럼 별도의 prop으로 전달한다.  