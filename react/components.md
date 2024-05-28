# Components

리액트를 사용하면 마크업, CSS, 자바스크립트를 **앱의 재사용 가능한 UI 요소**인 사용자 정의 "컴포넌트"로 결합할 수 있다.  
내부적으로는 여전히 `<article>`, `<h1>` 등과 같은 동일한 HTML태그를 사용한다.

리액트 앱은 컴포넌트로 구성되며, 컴포넌트란 '고유한 로직과 모양을 가진 UI의 일부'다.  
컴포넌트는 버튼만큼 작을 수도, 전체 페이지만큼 클 수도 있다.

리액트 컴포넌트는 **마크업을 반환하는 자바스크립트 함수**다.

리액트는 서로 관련이 있는 마크업(HTML)과 렌더링 로직(자바스크립트)을 함께 그룹화한다.

- 버튼의 렌더링 로직과 버튼의 마크업이 함께 있으면, 매번 변화가 생길 때마다 서로 동기화 상태를 유지할 수 있다.
- 반대로 버튼의 마크업과 사이드바의 마크업처럼 서로 관련이 없는 항목들은 서로 분리되어 있으므로, 각각 개별적으로 변경하는 것이 더 안전하다.

선언한 컴포넌트는 다른 컴포넌트 안에 **중첩**할 수 있다.

```
export default function Gallery() {
return (
    <section>
    <h1>Amazing scientists</h1>
    <Profile />
    <Profile />
    <Profile />
    </section>
);
}
```

- 위의 코드는 브라우저에서 다음과 같이 표시된다.

```
<section>
    <h1>Amazing scientists</h1>
    <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
    <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
    <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
</section>
```

컴포넌트의 이름은 항상 **대문자**로 시작한다.

컴포넌트는 여러 개의 JSX 태그를 반환할 수 없다.

컴포넌트는 다른 컴포넌트를 렌더링할 수 있지만, 그 정의를 중첩해서는 안 된다.

- 잘못된 컴포넌트 정의

```
export default function Gallery() {
// 🔴 Never define a component inside another component!
function Profile() {
    // ...
}
// ...
}
```

- 대신 최상위 레벨에서 컴포넌트를 정의해야 한다.

```
export default function Gallery() {
// ...
}

// ✅ Declare components at the top level
function Profile() {
// ...
}
```

리액트 앱은 root 컴포넌트에서 시작한다. 보통 새 프로젝트를 시작할 때 자동으로 생성된다.

예제의 컴포넌트들은 모두 `App.js`라는 **root 컴포넌트** 파일에 존재한다.  
설정에 따라 root 컴포넌트가 다른 파일에 위치할 수 있다.

Next.js의 경우 root 컴포넌트는 `pages/index.js`에 정의된다.  
리액트 기반 프레임워크들은 리액트 컴포넌트에서 HTML을 자동으로 생성하기도 한다.  
이를 통해 자바스크립트 코드가 로드되기 전에 앱에서 일부 컨텐츠를 표시할 수 있다.

## export, import

`export default` 접두사는 표준 자바스크립트 구문이다.  
변수와 상수도 export 할 수 있다.

`export const people = [{...}]`

컴포넌트는 세 단계를 거쳐 별도의 파일로 옮길 수 있다.

1. 컴포넌트를 추가할 JS 파일을 생성
2. JS 파일에서 함수 컴포넌트를 export
3. 컴포넌트를 사용할 파일에서 import

export와 import 방법에는 각각 `default`와 `named export/import`가 있다.

import에는 두 방법이 있는데 `.js` 확장자를 명시하는 전자가 native ES Modules 사용법에 가깝다.

- `import Gallery from './Gallery.js';` OR
  `import Gallery from './Gallery';`

default와 named export는 한 파일에서 사용할 수도 있다.

> 다만 한 파일에서는 하나의 default export만 존재할 수 있고  
> named export는 여러 개가 존재할 수 있다.

export 방식에 따라 import 방식이 정해져 있다. default export한 값을 named import로 가져오려고 하면 **Error**가 발생한다.

| Syntax  | <center>export 구문</center>          | <center>import 구문</center>            |
| :-----: | :------------------------------------ | :-------------------------------------- |
| Default | `export default function Button() {}` | `import Button from './button.js';`     |
|  Named  | `export function Button() {}`         | `import { Button } from './button.js';` |

default import를 사용하는 경우 원한다면 `import` 단어 후에 다른 이름으로 값을 가져올 수 있다. 이름이 달라도 같은 default export 값을 가져온다.

- `import Banana from './button.js'`

반대로 named import는 양쪽 파일에서 사용하려는 값의 이름이 같아야 한다.

> 보편적으로 한 파일에서 하나의 컴포넌트만 export 할 때 default export 방식을 사용하고
> 여러 컴포넌트를 export 할 경우엔 named export 방식을 사용한다.  
> 어떤 방식을 사용하든 컴포넌트와 파일의 이름을 의미 있게 명명하는 것은 중요  
> `export default () => {}` 처럼 이름 없는 컴포넌트는 나중에 디버깅하기 어렵기 때문에 권장하지 않음

## Purity(순수성)

CS에서 특히 함수형 프로그래밍에서 순수 함수는 다음의 특징을 가진 함수이다.

- 자신의 일의 집중: 함수가 호출되기 전에 존재했던 어떤 객체나 변수는 변경하지 않음
- 같은 입력, 같은 출력: 같은 입력이 주어지면 같은 결과를 반환

```javascript
function Recipe({ drinkers }) {
  return (
    <ol>
      <li>Boil {drinkers} cups of water.</li>
      <li>
        Add {drinkers} spoons of tea and {0.5 * drinkers} spoons of spice.
      </li>
      <li>Add {0.5 * drinkers} cups of milk to boil and sugar to taste.</li>
    </ol>
  );
}
```

### 순수성을 신경쓰는 이유

1. 컴포넌트는 다른 환경에서도 실행될 수 있음(서버 등) : 동일한 입력에 대해 동일한 결과를 반환하기 때문에 하나의 컴포넌트가 많은 사용자 요청을 처리할 수 있음
2. 입력이 변경되지 않은 컴포넌트 렌더링을 건너뛰어 성능 향상 : 순수 함수는 항상 동일 결과를 반환하므로 캐시하기에 안전함
3. 깊은 컴포넌트 트리를 렌더링하는 도중에 일부 데이터가 변경되는 경우 : 오래된 렌더링을 완료하는 데 시간을 낭비하지 않고 렌더링을 다시 시작함.  
   이때 순수함은 언제든지 연산을 중단하는 것을 안전하게 유지해줌
4. 리액트는 컴포넌트 함수가 특정 순서로 실행된다는 것을 보장하지 않음 : 변수로 컴포넌트 함수간에 통신할 수 없음

## Side Effects(사이드 이펙트)

> 사이트 이펙트의 예시
>
> - 아래 코드는 작동하지 않음

1. DOM 수정

```javascript
export default function Clock({ time }) {
  let hours = time.getHours();
  if (hours >= 0 && hours <= 6) {
    document.getElementById("time").className = "night";
  } else {
    document.getElementById("time").className = "day";
  }
  return <h1 id="time">{time.toLocaleTimeString()}</h1>;
}
```

리액트의 렌더링 과정은 항상 순수해야 한다.

- 컴포넌트는 렌더링하기 전에 존재했던 변수나 객체를 변경하지 않는다.
- 컴포넌트를 순수하지 않도록 하는 JSX만 반환한다.

> 순수성을 위반하는 예시

```javascript
let guest = 0;
function Cup() {
  // 나쁜 지점: 외부에 이미 존재하는 변수를 변경하고 있다!
  guest = guest + 1;
  return <h2>Tea cup for guest #{guest}</h2>;
}

export default function TeaSet() {
  return (
    <>
      <Cup />
      <Cup />
      <Cup />
    </>
  );
}
```

- 컴포넌트 밖에 선언된 `guest` 변수를 수정 : 컴포넌트가 여러번 불리면 다른 JSX를 생성함을 의미
- 다른 컴포넌트가 `guest`를 읽었다면 렌더링 시점에 따라 그 컴포넌트도 다른 JSX를 생성하고, 이것은 예측 불가능

`guest` 변수를 프로퍼티로 넘겨서 고칠 수 있다.

```javascript
function Cup({ guest }) {
  return <h2>Tea cup for guest #{guest}</h2>;
}
```

- 이러한 순수 함수는 연산만 하므로 여러번 호출해도 아무것도 변경되지 않는다.

리액트에서 사이드 이펙트는 보통 이벤트 핸들러에 포함한다.

- 이벤트 핸들러 : 리액트가 일부 작업을 수행할 때 반응하는 기능(버튼 클릭 등)
- 이벤트 핸들러는 컴포넌트 *내부*에 정의되어도 렌더링 중에 실행되지 않음
- 따라서 이벤트 핸들러는 순수할 필요가 없음

사이드 이펙트에 적합한 이벤트 핸들러를 찾을 수 없는 경우, 컴포넌트에서 `useEffect` 호출을 사용하여 반환된 JSX에 해당 이벤트 핸들러를 연결할 수 있다.  
리액트에게 사이드 이펙트가 허용될 때 렌더링 후 나중에 실행하도록 지시한다.

- **이 접근 방식이 최후의 수단이 되어야 함**
- 가능하면 렌더링만으로 로직을 표현할 것

## Strict mode(엄격 모드)

리액트에는 렌더링하면서 읽을 수 있는 세 가지 종류의 입력 요소(props, state, context)가 있다.  
이러한 입력 요소는 항상 읽기전용으로 취급해야 한다.  
사용자의 입력에 따라 무언가를 변경할 경우, 직접 수정 대신에 set state를 활용한다.  
컴포넌트 렌더링 중에 기존 변수나 객체를 변경하지 말 것

`<React.StrictMode>`

리액트는 개발 중에 각 컴포넌트의 함수를 두 번 호출하는 엄격 모드를 제공한다.  
최상단 컴포넌트를 위의 코드로 감싸서 사용한다.

- 컴포넌트 함수를 두 번 호출하여 규칙 위반 컴포넌트를 찾는데 도움을 줌
- 엄격 모드는 프로덕션에 영향을 주지 않아 사용자의 앱 속도가 느려지지 않음
- 몇몇 프레임워크는 기본적으로 이 문법을 사용함

## Local mutation(지역 변형)

렌더링하는 동안 컴포넌트가 기존 변수를 변경하는 것을 'mutation'이라고 한다.  
렌더링하는 동안 그냥 만든 변수를 변경하는 것은 문제가 없다.

```javascript
function Cup({ guest }) {
  return <h2>Tea cup for guest #{guest}</h2>;
}

export default function TeaGathering() {
  let cups = [];
  for (let i = 1; i <= 12; i++) {
    cups.push(<Cup key={i} guest={i} />);
  }
  return cups;
}
```

- 동일한 렌더링중에 생성된 변수를 변경하는 것은 괜찮다.
- 지역 변형: 다른 컴포넌트에서 이 현상이 벌어진 것을 모르는 것

## React Server Components

[React Server Components](https://ko.react.dev/reference/rsc/server-components#async-components-with-server-components)  

> 서버 컴포넌트는 `"use server"`로 표시된다는 오해가 있지만, 서버 컴포넌트에 대한 지시어(Directives)는 없다. `"use server"` 지시어는 서버 액션에 사용된다.

서버 컴포넌트는 번들링 전에 클라이언트 앱이나 SSR 서버와는 분리된 환경에서 미리 렌더링되는 새로운 유형의 컴포넌트다.  
이 별도의 환경이 바로 React 서버 컴포넌트에서의 *“서버”*다. 서버 컴포넌트는 빌드 시간에 CI 서버에서 한 번 실행되거나, 각 요청마다 웹 서버를 통해 실행될 수 있다.  

### 서버 컴포넌트에 상호작용 추가

서버 컴포넌트는 브라우저로 전송되지 않으므로 `useState`와 같은 상호작용 API를 사용할 수 없다.  
서버 컴포넌트에 상호작용을 추가하려면 `"use client"` 지시문을 사용하여 클라이언트 컴포넌트와 함께 구성할 수 있다.  
예제는 먼저 `Notes`를 서버 컴포넌트로 렌더링한 다음 번들러에 `Expandable` 클라이언트 컴포넌트의 번들을 생성하도록 지시한다.  
브라우저에서는 클라이언트 컴포넌트가 서버 컴포넌트의 출력을 `props`로 받는다.

```javascript
// Server Component
import Expandable from './Expandable';

async function Notes() {
  const notes = await db.notes.getAll();
  return (
    <div>
      {notes.map(note => (
        <Expandable key={note.id}>
          <p note={note} />
        </Expandable>
      ))}
    </div>
  )
}
```

```javascript
// Client Component
"use client"

export default function Expandable({children}) {
  const [expanded, setExpanded] = useState(false);
  return (
    <div>
      <button
        onClick={() => setExpanded(!expanded)}
      >
        Toggle
      </button>
      {expanded && children}
    </div>
  )
}
```

```javascript
<head>
  <!-- the bundle for Client Components -->
  <script src="bundle.js" />
</head>
<body>
  <div>
    <Expandable key={1}>
      <p>this is the first note</p>
    </Expandable>
    <Expandable key={2}>
      <p>this is the second note</p>
    </Expandable>
    <!--...-->
  </div> 
</body>
```

### 서버 컴포넌트와 함께 비동기 컴포넌트 사용하기

서버 컴포넌트는 async/await를 사용하는 새로운 방법을 소개한다.  
비동기 컴포넌트에서 `await`를 사용할 때 React는 중단하고, Promise가 해결될 때까지 렌더링을 기다린 후 다시 렌더링을 재개한다.  
이는 서버/클라이언트 경계를 넘어 서스펜스 스트리밍 지원과 함께 작동한다.  
심지어 서버에서 Promise를 생성하고 클라이언트에서 이를 기다릴 수 있다.  

`note` 콘텐츠는 페이지 렌더링에 중요한 데이터이므로 서버에서 `await` 한다.  
댓글(`comments`)은 중요도가 낮아 페이지 아래에 표시되므로 서버에서 Promise를 시작하고 클라이언트에서 `use` API를 사용하여 기다린다.  
이는 클라이언트에서 중단되지만 `note` 콘텐츠가 렌더링되는 것을 차단하지 않는다.  
비동기 컴포넌트는 클라이언트에서 지원되지 않으므로 Promise를 `use`로 기다린다.  

```javascript
// Server Component
import db from './database';

async function Page({id}) {
  // Will suspend the Server Component.
  const note = await db.notes.get(id);
  
  // NOTE: not awaited, will start here and await on the client. 
  const commentsPromise = db.comments.get(note.id);
  return (
    <div>
      {note}
      <Suspense fallback={<p>Loading Comments...</p>}>
        <Comments commentsPromise={commentsPromise} />
      </Suspense>
    </div>
  );
}
```

```javascript
// Client Component
"use client";
import {use} from 'react';

function Comments({commentsPromise}) {
  // NOTE: this will resume the promise from the server.
  // It will suspend until the data is available.
  const comments = use(commentsPromise);
  return comments.map(commment => <p>{comment}</p>);
}
```