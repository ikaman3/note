# API

리액트의 API 관련 내용

## use

[React Docs](https://ko.react.dev/reference/react/use)

```javascript
const value = use(resource);
```

```javascript
import { use } from 'react';

function MessageComponent({ messagePromise }) {
  const message = use(messagePromise);
  const theme = use(ThemeContext);
  // ...
```

**import**: react  
**parameters**: `resource`

- 참조하려는 데이터다. 데이터는 Promise나 context일 수 있다.

**returns**: Promise나 context에서 참조한 값을 반환한다.

- 서버 컴포넌트에서 데이터를 fetch 할 때는 `use`보다 `async` 및 `await`를 사용한다.
- `async` 및 `await`은 `await`이 호출된 시점부터 렌더링을 시작하는 반면 `use`는 데이터가 리졸브된 후 컴포넌트를 리렌더링한다.
- 클라이언트 컴포넌트에서 Promise를 생성하는 것보다 서버 컴포넌트에서 Promise를 생성하여 클라이언트 컴포넌트에 전달하는 것이 좋다.  
  클라이언트 컴포넌트에서 생성된 Promise는 렌더링할 때마다 다시 생성된다. 서버 컴포넌트에서 클라이언트 컴포넌트로 전달된 Promise는 리렌더링 전반에 걸쳐 안정적이다.

`use`는 Promise나 context와 같은 데이터를 참조하는 React Hook이다.  
다른 React Hook과 달리 `use`는 `if`와 같은 조건문과 반복문 내부에서 호출할 수 있다. 또한, 다른 React Hook과 같이 `use`는 컴포넌트 또는 Hook에서만 호출할 수 있다.  
Promise와 함께 호출될 때 `use` Hook은 `Suspense` 및 error boundaries와 통합된다. `use`에 전달된 Promise가 pending 되는 동안 `use`를 호출하는 컴포넌트는 suspend된다.  
`use`를 호출하는 컴포넌트가 Suspense 경계로 둘러싸여 있으면 fallback이 표시된다. Promise가 리졸브되면 Suspense fallback은 `use` Hook이 반환한 컴포넌트로 대체된다. `use`에 전달된 Promise가 reject 되면 가장 가까운 Error Boundary의 fallback이 표시된다.

### `use`를 사용하여 context 참조하기

```javascript
import { use } from 'react';

function Button() {
  const theme = use(ThemeContext);
  // ...
```

context가 `use`에 전달되면 `useContext`와 유사하게 작동한다.  
`useContext`는 컴포넌트의 최상위 수준에서 호출해야 하지만 `use`는 `if`와 같은 조건문이나 `for`과 같은 반복문 내부에서 호출할 수 있다.
`use`는 유연하므로 `useContext`보다 선호된다.  
`use`는 전달한 context의 context 값을 반환한다. context 값을 결정하기 위해 React는 컴포넌트 트리를 검색하고 위에서 가장 가까운 context provider를 찾는다.  
context를 `Button`에 전달하려면 `Button` 또는 상위 컴포넌트 중 하나를 context provider로 래핑한다.

```javascript
function MyPage() {
  return (
    <ThemeContext.Provider value="dark">
      <Form />
    </ThemeContext.Provider>
  );
}

function Form() {
  // ... 버튼 렌더링 ...
}
```

provider와 `Button` 사이에 얼마나 많은 컴포넌트가 있는지는 중요하지 않다. `Form` 내부의 어느 곳이든 `Button`이 `use(ThemeContext)`를 호출하면 `"dark"`를 값으로 받는다.  
`useContext`와 달리 `use`는 `if`와 같은 조건문과 반복문 내부에서 호출할 수 있다.
`use`는 `if` 내부에서 호출되므로 context에서 조건부로 값을 참조할 수 있다.

```javascript
function HorizontalRule({ show }) {
  if (show) {
    const theme = use(ThemeContext);
    return <hr className={theme} />;
  }
  return false;
}
```

### 서버에서 클라이언트로 데이터 스트리밍하기

서버 컴포넌트에서 클라이언트 컴포넌트로 Promise prop을 전달하여 서버에서 클라이언트로 데이터를 스트리밍할 수 있다.  
클라이언트 컴포넌트는 prop으로 받은 Promise를 `use` API 에 전달한다.
Client Component는 서버 컴포넌트가 처음에 생성한 Promise에서 값을 읽을 수 있다.

`Message`는 Suspense로 래핑되어 있으므로 Promise가 리졸브될 때까지 fallback이 표시된다.  
Promise가 리졸브되면 `use` Hook이 값을 참조하고 `Message` 컴포넌트가 Suspense fallback을 대체한다.

> 서버 컴포넌트에서 클라이언트 컴포넌트로 Promise를 전달할 때 리졸브된 값이 직렬화 가능해야 한다. 함수는 직렬화할 수 없으므로 Promise의 리졸브 값이 될 수 없다.

> **Deep Dive**  
> Promise는 서버 컴포넌트에서 클라이언트 컴포넌트로 전달될 수 있으며 `use` API 를 통해 클라이언트 컴포넌트에서 리졸브된다.  
> 또한 서버 컴포넌트에서 `await`을 사용하여 Promise를 리졸브하고 데이터를 클라이언트 컴포넌트에 prop으로 전달하는 방법도 존재한다.  
> 하지만 서버 컴포넌트에서 `await`을 사용하면 `await`문이 완료될 때까지 렌더링이 차단된다.  
> 서버 컴포넌트에서 클라이언트 컴포넌트로 Promise를 prop으로 전달하면 Promise가 서버 컴포넌트의 렌더링을 차단하는 것을 방지할 수 있다.

### 거부된 Promise 처리하기

1. `ErrorBoundary` 컴포넌트로 래핑하여 `ErrorBoundary`의 fallback을 출력
2. `Promise.catch`로 대체 값 제공

`catch`는 오류 메시지를 인자로 받는 함수를 인수로 받는다. `catch`에 전달된 함수가 반환하는 값은 모두 Promise의 리졸브 값으로 사용된다.

## lazy

[React Docs](https://ko.react.dev/reference/react/lazy)

```javascript
const SomeComponent = lazy(load);
```

```javascript
import { lazy } from "react";

const MarkdownPreview = lazy(() => import("./MarkdownPreview.js"));
```

로딩 중인 컴포넌트 코드가 처음으로 렌더링 될 때까지 연기할 수 있다.  
`lazy`를 이용하여 로딩하는 React 컴포넌트를 선언하려면 컴포넌트 외부에서 `lazy`를 호출한다.  
로딩 중에 loading indicator를 표시하려면 `<Suspense>`를 사용한다.

## createRoot

## hydrateRoot
