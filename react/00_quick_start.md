# react/quick_start

[https://ko.react.dev/learn](https://ko.react.dev/learn)  

리액트 공식문서 '빠르게 시작하기'를 학습하고 개념을 요약한 마크다운 

# Quick Start

## Creating and nesting components(컴포넌트 생성 및 중첩하기)

리액트 앱은 컴포넌트로 구성된다.  

- 컴포넌트 : 자체 로직과 외관을 가진 UI 일부를 표시하는 재사용 가능한 코드의 조각  

컴포넌트는 버튼처럼 작을 수도 있고, 전체 페이지처럼 크게 설계할 수도 있다.  
리액트 컴포넌트는 마크업을 반환하는 **JavaScript 함수**다.  

```
function MyButton() {
  return (
    <button>I'm a button</button>
  );
}
```

컴포넌트를 선언했다면, 다른 컴포넌트 안에 중첩할 수 있다.  

```
export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```  

리액트 컴포넌트는 **대문자**로 시작한다( ```<MyButton />``` )  
리액트 컴포넌트는 항상 대문자로 시작해야 하며, HTML 태그는 **소문자**여야 한다.

```
// App.js

function MyButton() {
  return (
    <button>
      I'm a button
    </button>
  );
}

export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```  

- ```export default``` : 파일에서 주요 컴포넌트를 지정한다.

## Writing markup with JSX(JSX로 마크업 작성하기)

위의 마크업 구문은 JSX라고 부른다.  
선택사항이긴 하지만 편의성을 위해 대부분의 리액트 프로젝트에서 JSX를 사용한다.  
로컬 개발을 위해 권장하는 모든 도구는 JSX를 기본으로 지원한다.  
  
JSX는 HTML 태그보다 엄격하다. ```<br />``` 처럼 태그를 닫아야만 한다.  
또한 컴포넌트는 여러 JSX 태그를 반환할 수 없다.  
공통 부모인 ```<div>...</div>``` 나 비어있는 ```<>...<>``` 래퍼로 감싸야 한다.  

```
function AboutPage() {
  return (
    <>
      <h1>About</h1>
      <p>Hello there.<br />How do you do?</p>
    </>
  );
}
```

## Adding styles(스타일 추가하기)

리액트는 CSS 클래스를 지정할 때 ```className```을 사용한다.  
HTML의 class 속성과 동일한 방식으로 작동한다.  

```
<img className="avatar" />
```

그런 다음 별도의 CSS 파일에서 해당 클래스에 대한 CSS 규칙을 작성한다.  

```
/* In your CSS */
.avatar {
  border-radius: 50%;
}
```

리액트는 CSS 파일을 추가하는 방법을 규정하지 않는다.  
가장 간단한 방법은 HTML에 ```<link>```  태그를 추가하는 것  
빌드 도구나 프레임워크를 사용하는 경우 해당 규칙을 따라서 추가한다.  

## Displaying data(데이터 표시하기)

JSX를 사용하여 자바스크립트에 마크업을 넣을 수 있다.  
중괄호를 사용하면 코드에서 일부 변수를 삽입하여 사용자에게 표시할 수 있도록 자바스크립트로 'escape back(이스케이프 백)'할 수 있다.   

```
return (
  <h1>
    {user.name}
  </h1>
);
```  

JSX 어트리뷰트에서 따옴표 대신 중괄호를 사용하여 “escape into JavaScript(자바스크립트로 이스케이프)” 할 수도 있다.  
예를 들어 ```className="avatar"```는 "avatar" 문자열을 CSS로 전달하지만  
```src={user.imageUrl}```는 자바스크립트 ```user.imageUrl``` 변수 값을 읽은 다음 해당 값을 ```src``` 어트리뷰트로 전달한다.

```
return (
  <img
    className="avatar"
    src={user.imageUrl}
  />
);
```  

JSX 중괄호 안에 문자열 연결과 같이 더 복잡한 표현식을 넣을 수도 있다.  

```
// App.js

const user = {
  name: 'Hedy Lamarr',
  imageUrl: 'https://i.imgur.com/yXOvdOSs.jpg',
  imageSize: 90,
};

export default function Profile() {
  return (
    <>
      <h1>{user.name}</h1>
      <img
        className="avatar"
        src={user.imageUrl}
        alt={'Photo of ' + user.name}
        style={{
          width: user.imageSize,
          height: user.imageSize
        }}
      />
    </>
  );
}
```

- 위의 예시에서 ```style={{}}``` 은 특별한 문법이 아니라 ```style={ }``` JSX 중괄호 안에 있는 일반 ```{}``` 객체라는 의미다.  
- 스타일이 자바스크립트 변수에 의존하는 경우 ```style``` 어트리뷰트를 사용할 수 있다.  

## Conditional rendering(조건부 렌더링)

React에서 조건문을 작성하는 데에는 특별한 문법이 필요 없다.  
일반적인 자바스크립트 코드를 작성할 때 사용하는 것과 동일한 방법을 사용한다.  
예를 들어 ```if``` 문을 사용하여 조건부로 JSX를 포함할 수 있다.  

```
let content;
if (isLoggedIn) {
	content = <AdminPanel />;
} else {
	content = <LoginForm />;
}
return {
	<div>
		{content}
	</div>
);
```

조건부 삼항 연산자도 사용할 수 있다.  
```if```문과는 다르게 JSX **내부**에서 작동한다.  

```
<div>
  {isLoggedIn ? (
    <AdminPanel />
  ) : (
    <LoginForm />
  )}
</div>
```

```else```분기가 필요하지 않으면 더 짧은 ```&&```연산자를 사용할 수도 있다.  

```
<div>
  {isLoggedIn && <AdminPanel />}
</div>
```  

이러한 접근 방식은 어트리뷰트를 조건부로 지정할 때도 동작한다.  
이러한 자바스크립트 문법에 익숙하지 않다면 항상 ```if...else```를 사용하는 것으로 시작할 수 있다.  

## Rendering lists(리스트 렌더링하기)

컴포넌트 리스트를 렌더링하기 위해서는 ```for``` 문 및 ```map()``` 함수와 같은 자바스크립트 기능을 사용한다.  
예를 들어 여러 제품이 있다고 가정해 본다.  

```
const products = [
  { title: 'Cabbage', id: 1 },
  { title: 'Garlic', id: 2 },
  { title: 'Apple', id: 3 },
];
```

컴포넌트 안에서 ```map()``` 함수를 사용해 제품 배열을 ```<li>``` 항목 배열로 변환한다.  

```
const listItems = products.map(product =>
  <li key={product.id}>
    {product.title}
  </li>
);

return (
  <ul>{listItems}</ul>
);
```

```<li>```에 ```key``` 어트리뷰트가 존재한다.  

- 목록의 각 항목에 대해, 형제 항목 사이에서 해당 항목을 고유하게 식별하는 문자열 또는 숫자를 전달해야 한다.
- React는 나중에 항목을 삽입, 삭제 또는 재정렬할 때 어떤 일이 일어났는지 알기 위해 key를 사용한다.

```
// App.js

const products = [
  { title: 'Cabbage', isFruit: false, id: 1 },
  { title: 'Garlic', isFruit: false, id: 2 },
  { title: 'Apple', isFruit: true, id: 3 },
];

export default function ShoppingList() {
  const listItems = products.map(product =>
    <li
      key={product.id}
      style={{
        color: product.isFruit ? 'magenta' : 'darkgreen'
      }}
    >
      {product.title}
    </li>
  );

  return (
    <ul>{listItems}</ul>
  );
}
```

## Responding to events(이벤트에 응답하기)

컴포넌트 내부에 '이벤트 핸들러 함수'를 선언하여 이벤트에 응답할 수 있다.  

```
function MyButton() {
  function handleClick() {
    alert('You clicked me!');
  }

  return (
    <button onClick={handleClick}>
      Click me
    </button>
  );
}
```

- ```onClick={handleClick}```의 끝에 소괄호가 없는 것을 주의하자  
- 이벤트 핸들러 함수를 '호출'하지 않고 '전달'만 하면 된다(함수 실행이 아닌 함수의 주소(Reference)만 넘기는 것)
- 리액트는 사용자가 버튼을 클릭할 때 이벤트 핸들러를 호출한다

## Updating the screen(화면 업데이트하기)

컴포넌트가 특정 정보를 “기억”하여 표시하기를 원하는 경우가 종종 있다.  
예를 들어 버튼이 클릭된 횟수를 세고 싶을 수 있다. 이렇게 하려면 컴포넌트에 '*state*(상태)'를 추가하면 된다.  
먼저, React에서 ```useState```를 가져온다.  

```
import { useState } from 'react';
```
이제 컴포넌트 내부에 'state' 변수를 선언할 수 있다.  
```
function MyButton() {
  const [count, setCount] = useState(0);
  // ...
```

```useState```로부터 현재 state (```count```)와 이를 업데이트할 수 있는 함수(```setCount```)를 얻을 수 있다.  

- 이들을 어떤 이름으로도 지정할 수 있지만 ```[something, setSomething]``` 으로 작성하는 것이 일반적이다.

버튼이 처음 표시될 때는 ```useState()``` 에 ```0```을 전달했기 때문에 ```count```가 ```0```이 된다.  
state를 변경하고 싶다면 ```setCount()``` 를 실행하고 새 값을 전달한다.  
이 버튼을 클릭하면 카운터가 증가한다.  

```
function MyButton() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <button onClick={handleClick}>
      Clicked {count} times
    </button>
  );
}
```

React가 컴포넌트 함수를 다시 호출하면, 이번에는 ```count``` 가 ```1```이 되고, 그 다음에는 ```2```가 될 것이다.  
같은 컴포넌트를 여러 번 렌더링하면 각각의 컴포넌트는 고유한 state를 얻게 된다.  
각 버튼을 개별적으로 클릭해 보자.  

```
// App.js

import { useState } from 'react';

export default function MyApp() {
  return (
    <div>
      <h1>Counters that update separately</h1>
      <MyButton />
      <MyButton />
    </div>
  );
}

function MyButton() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <button onClick={handleClick}>
      Clicked {count} times
    </button>
  );
}
```

- 각 버튼이 고유한 ```count``` state를 '기억'하고 다른 버튼에 영향을 주지 않는 방식에 주목하자

## Using Hooks(Hooks 사용하기)

```use```로 시작하는 함수를 Hooks라고 한다.  
```useState```는 React에서 제공하는 내장 Hook이다.  
다른 내장 Hooks는 API 레퍼런스에서 찾아볼 수 있다.  
또한 기존의 것들을 조합하여 자신만의 Hooks를 작성할 수도 있다.  
Hooks는 다른 함수보다 더 제한적이다.  

- 컴포넌트(또는 다른 Hooks)의 상단에서만 Hooks를 호출할 수 있다.  
- 조건이나 반복에서 ```useState```를 사용하고 싶다면 새 컴포넌트를 추출하여 그곳에 넣는다.

## Sharing data between components(컴포넌트 간에 데이터 공유하기)

위의 예제에서는 각각의 ```MyButton``` 에 독립적인 ```count``` 가 있었고, 각 버튼을 클릭하면 클릭한 버튼의 ```count```만 변경되었다.  

```
        MyApp                       MyApp
          |                           |
     /----------\               /----------\
MyButton    MyButton        MyButton    MyButton
count|0     count|0         count|1     count|0 
```

하지만 데이터를 공유하고 항상 함께 업데이트하기 위한 컴포넌트가 필요한 경우가 많다.  
두 ```MyButton``` 컴포넌트가 동일한 ```count``` 를 표시하고 함께 업데이트하려면,  
state를 개별 버튼에서 모든 버튼이 포함된 가장 가까운 컴포넌트로 “위쪽”으로 이동해야 한다.  

```
        MyApp                       MyApp
        count|0                     count|1
          |                           |
    /----------\                /----------\
count|0     count|0         count|1     count|1
    |          |                |          |
MyButton    MyButton        MyButton    MyButton
```

- 처음에 ```MyApp``` 의 ```count``` state는 ```0``` 이며 두 자식에게 모두 전달된다.
- 클릭 시 ```MyApp``` 은 ```count``` state를 ```1``` 로 업데이트하고 두 자식에게 전달한다.

이제 두 버튼 중 하나를 클릭하면 ```MyApp``` 의 ```count``` 가 변경되어 ```MyButton``` 의 카운트가 모두 변경된다.  
이를 코드로 표현하는 방법은 다음과 같다. 먼저 ```MyButton``` 에서 ```MyApp``` 으로 state를 위로 이동합니다.  

```
export default function MyApp() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <div>
      <h1>Counters that update separately</h1>
      <MyButton />
      <MyButton />
    </div>
  );
}

function MyButton() {
  // ... we're moving code from here ...
}
```

그 다음 공유된 클릭 핸들러와 함께 ```MyApp``` 에서 각 ```MyButton``` 으로 state를 전달한다.  
이전에 ```<img>``` 와 같은 기본 제공 태그를 사용했던 것처럼 JSX 중괄호를 사용하여 ```MyButton``` 에 정보를 전달할 수 있다:  

```
export default function MyApp() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <div>
      <h1>Counters that update together</h1>
      <MyButton count={count} onClick={handleClick} />
      <MyButton count={count} onClick={handleClick} />
    </div>
  );
}
```

이렇게 전달한 정보를 props라고 한다.  
이제 ```MyApp``` 컴포넌트는 ```count``` state와 ```handleClick``` 이벤트 핸들러를 포함하며, 이 두 가지를 각 버튼에 props로 전달한다.  
마지막으로 부모 컴포넌트에서 전달한 props를 읽도록 ```MyButton``` 을 변경한다:  

```
function MyButton({ count, onClick }) {
  return (
    <button onClick={onClick}>
      Clicked {count} times
    </button>
  );
}
```

버튼을 클릭하면 ```onClick``` 핸들러가 실행된다. 각 버튼의 ```onClick``` prop는 ```MyApp``` 내부의 ```handleClick``` 함수로 설정되었으므로 그 안에 있는 코드가 실행된다.  

- 이 코드는 ```setCount(count + 1)``` 를 실행하여 ```count``` state 변수를 증가시킨다.
- 새로운 ```count``` 값은 각 버튼에 prop로 전달되므로 모든 버튼에는 새로운 값이 표시된다.

이를 “lifting state up(state 올리기)”라고 한다. state를 위로 이동함으로써 컴포넌트 간에 state를 공유하게 된다.  

```
// App.js

import { useState } from 'react';

export default function MyApp() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <div>
      <h1>Counters that update together</h1>
      <MyButton count={count} onClick={handleClick} />
      <MyButton count={count} onClick={handleClick} />
    </div>
  );
}

function MyButton({ count, onClick }) {
  return (
    <button onClick={onClick}>
      Clicked {count} times
    </button>
  );
}
```

## 개념 요약 

1. 리액트 앱은 컴포넌트로 구성되며, 컴포넌트란 '고유한 로직과 모양을 가진 UI의 일부'다. 컴포넌트는 버튼만큼 작을 수도, 전체 페이지만큼 클 수도 있다.
2. 리액트 컴포넌트는 마크업을 반환하는 자바스크립트 함수다.
3. 선언한 컴포넌트는 다른 컴포넌트 안에 중첩할 수 있다.
4. 컴포넌트의 이름은 항상 대문자로 시작한다.
5. JSX는 선택사항이지만 대부분의 리액트 프로젝트는 JSX를 사용한다.
6. JSX는 항상 태그를 닫아야 한다.
7. 컴포넌트는 여러 개의 JSX 태그를 반환할 수 없다.
8. 리액트는 ```className``` 으로 CSS class를 지정한다. 이것은 HTML의 ```class``` 어트리뷰트와 동일한 방식으로 동작한다.
9. 리액트는 CSS 파일을 추가하는 방법을 규정하지 않는다.
10. 컴포넌트가 특정 정보를 기억하기를 원한다면 state를 사용한다.
11. 같은 컴포넌트를 여러 번 렌더링하면 각각의 컴포넌트는 고유한 state를 얻는다.
12. ```use``` 로 시작하는 함수를 Hooks라고 하며, ```useState``` 는 리액트에서 제공하는 내장 Hook이다.
13. Hooks는 다른 함수보다 더 제한적이다. 컴포넌트(또는 다른 Hooks)의 상단에서만 Hooks를 호출할 수 있다.
14. 컴포넌트 간에 데이터를 공유하고 싶다면, 해당 컴포넌트들을 모두 포함하는 상위 컴포넌트에 state를 선언하고 두 자식 컴포넌트에 전달한다.
15. 자식 컴포넌트에 JSX 중괄호를 사용해서 전달하는 정보를 props라고 한다.
16. props를 사용한 컴포넌트 간의 state 공유를 'state 올리기'라고 한다. state를 위로 이동하여 컴포넌트 간에 state를 공유하는 것이다.
