# Hooks

## useState()

[React Docs](https://ko.react.dev/reference/react/useState)  


```javascript
import { useState } from 'react';

function MyComponent() {
  const [age, setAge] = useState(28);
  const [name, setName] = useState('Taylor');
  const [todos, setTodos] = useState(() => createTodos());
  // ...
```

**import**: react  
**parameters**: `initialState`  
  - state의 초기 설정값. 어떤 유형의 값이든 지정할 수 있지만 함수에 대해서는 특별한 동작이 있다. 이 인수는 초기 렌더링 이후에는 무시된다.
  - 함수를 `initialState`로 전달하면 이를 초기화 함수로 취급. 이 함수는 순수해야 하고 인수를 받지 않아야 하며 반드시 어떤 값을 반환해야 한다.  
    React는 컴포넌트를 초기화할 때 초기화 함수를 호출하고, 그 반환값을 초기 state로 저장한다.  

**returns**: 정확히 두 개의 값을 가진 배열을 반환  
  1. 현재 state. 첫 번째 렌더링 중에는 전달한 `initialState`와 일치한다.
  2. state를 다른 값으로 업데이트하고 리렌더링을 촉발할 수 있는 `set` 함수

컴포넌트에 state 변수를 추가할 수 있는 React Hook  
컴포넌트의 최상위 레벨에서 `useState`를 호출하여 state 변수를 선언한다.  
배열 구조 분해를 사용하여 `[something, setSomething]`과 같은 state 변수의 이름을 지정하는 것이 규칙이다.

### `set` functions

```javascript
const [name, setName] = useState('Edward');

function handleClick() {
  setName('Taylor');
  setAge(a => a + 1);
  // ...
```

**parameters**: `nextState`
  - state가 될 값. 값은 모든 데이터 타입이 허용되지만, 함수에 대해서는 특별한 동작이 있다.
  - 함수를 `nextState`로 전달하면 업데이터 함수로 취급한다. 이 함수는 순수해야 하고, 대기 중인 state를 유일한 인수로 사용해야 하며, 다음 state를 반환해야 한다.  
    React는 업데이터 함수를 대기열에 넣고 컴포넌트를 리렌더링 한다. 다음 렌더링 중에 React는 대기열에 있는 모든 업데이터를 이전 state에 적용하여 다음 state를 계산한다.

**returns**: none  
**caveats**:  

  - `set` 함수는 다음 렌더링에 대한 state 변수만 업데이트한다. `set` 함수를 호출한 후에도 state 변수에는 여전히 호출 전 화면에 있던 이전 값이 담겨 있다.
  - 사용자가 제공한 새로운 값이 [`Object.is`](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Object/is)에 의해 **현재 state와 동일하다고 판정되면, React는 컴포넌트와 그 자식들을 리렌더링하지 않는다.** 이것이 바로 최적화이다. 경우에 따라 React가 자식을 건너뛰기 전에 컴포넌트를 호출해야 할 수도 있지만, 코드에 영향을 미치지는 않는다.
  - React는 [state 업데이트를 batch 한다.](https://ko.react.dev/learn/queueing-a-series-of-state-updates) **모든 이벤트 핸들러가 실행되고** `set` 함수를 호출한 후에 화면을 업데이트한다. 
    이렇게 하면 단일 이벤트 중에 여러 번 리렌더링 하는 것을 방지할 수 있다. 드물지만 DOM에 접근하기 위해 React가 화면을 더 일찍 업데이트하도록 강제해야 하는 경우, [`flushSync`](https://ko.react.dev/reference/react-dom/flushSync)를 사용할 수 있다.  
  - 렌더링 도중 `set` 함수를 호출하는 것은 현재 렌더링 중인 컴포넌트 내에서만 허용된다. React는 해당 출력을 버리고 즉시 새로운 state로 다시 렌더링을 시도한다. 이 패턴은 거의 필요하지 않지만 **이전 렌더링의 정보를 저장하는 데 사용할 수 있다.**

`useState`가 반환하는 `set` 함수를 사용하면 state를 다른 값으로 업데이트하고 리렌더링을 촉발할 수 있다.  
여기에는 다음 state를 직접 전달하거나, 이전 state로부터 계산한 함수를 전달할 수도 있다.


## useActionState()

[React Docs](https://18.react.dev/reference/react/useActionState)

> React Canary 버전에서 React DOM의 useFormState()의 이름이 바뀌었다.  

```javascript
const [state, formAction] = useActionState(fn, initialState, permalink?);
```

**import**: react  
**parameters**: 

  1. `fn`: 양식을 제출하거나 버튼을 눌렀을 때 호출할 함수. 호출되면 양식의 이전 상태(처음에는 전달한 초기 상태, 이후에는 이전 반환 값)를 초기 인수로 받은 다음 form action이 일반적으로 받는 인수를 받는다.
  2. `initialState`: 처음 상태를 설정할 값. 직렬화 가능한 모든 값이 가능하며 이 인수는 액션이 처음 호출된 후에는 무시된다.
  3. **optional** `permalink`: 이 `form`이 수정하는 고유한 페이지 URL이 포함된 문자열 

**returns**: 두 개의 원소를 가진 Array

  1. `state`: 현재 상태. 첫 번째 렌더링 중에는 초기 상태와 일치하며 액션이 호출된 후에는 액션이 반환한 값과 일치한다.
  2. `formAction`: `form` 컴포넌트에 `action` 프로퍼티로 전달할 수 있는 새 액션 또는 `form` 내의 `button` 컴포넌트에 `formAction` 프로퍼티로 전달할 수 있는 새 액션

form action의 결과에 따라 상태를 업데이트할 수 있는 훅  
form action에서 return한 값이 `state`가 되고 이를 이용해 `form`을 대화형으로 구성할 수 있다.  
예를 들어 작업의 성공 여부에 따라 오류 메시지를 렌더링하거나 업데이트된 정보를 보여줄 수 있다.  

예시:

```javascript
import {useActionState} from 'react'
import {addToCart} from './actions'

function AddToCartForm({itemID, itemTitle}) {
  const [formState, formAction] = useActionState(addToCart, {});
  return (
    <form action={formAction}>
      <h2>{itemTitle}</h2>
      <input type="hidden" name="itemID" value={itemID} />
      <button type="submit">Add to Cart</button>
      {formState?.success &&
        <div className="toast">
          Added to cart! Your cart now has {formState.cartSize} items.
        </div>
      }
      {formState?.success === false &&
        <div className="error">
          Failed to add to cart: {formState.message}
        </div>
      }
    </form>
  );
}

export default function App() {
  return (
    <>
      <AddToCartForm itemID="1" itemTitle="JavaScript: The Definitive Guide" />
      <AddToCartForm itemID="2" itemTitle="JavaScript: The Good Parts" />
    </>
  )
}
```

```javascript
// actions.js
"use server";

export async function addToCart(prevState, queryData) {
  const itemID = queryData.get('itemID');
  if (itemID === "1") {
    return {
      success: true,
      cartSize: 12,
    };
  } else {
    return {
      success: false,
      message: "The item is sold out.",
    };
  }
}
```

## useFormStatus()

[React Docs](https://react.dev/reference/react-dom/hooks/useFormStatus)  

```javascript
import {useFormStatus} from 'react-dom'

// 같은 파일에서 별도의 컴포넌트를 정의하고 필요한 곳에서 렌더링했다.
// 외부 파일로 구성하고 import하여 사용할 수도 있다.
function ChildComponent() {
  const { pending, data, method, action } = useFormStatus()

  return (...)
}

export default function ParentComponent() {
  return(
    <ChildComponent />
  )
}
```

**import**: react-dom  
**parameters**: none
**returns**: `status` object  
  - properties: `pending`, `data`, `method`, `action`

부모 `form`의 제출 상태 정보를 제공하는 훅이다.  
반드시 `form` 안에서 선언해야 상태를 제공할 수 있으나 훅은 컴포넌트 최상단에서만 선언할 수 있다.  
따라서 별도의 컴포넌트로 구성하여 해당 컴포넌트를 `form` 안에 렌더링하는 방식으로 사용한다.  


### Usage

#### 제출 중 비활성화

```javascript
// button에 사용
<button type="submit" disabled={pending}>
  {pending ? 'Submitting...' : 'Submut'}
</button>

// 제출 메시지를 띄우기
{pending && <p>제출 중입니다...</p>}

// input에 사용
<input type="text" readOnly={pending} />
```

#### 제출하는 데이터 보여주기

```javascript
<p>{data ? `Requesting ${data?.get("username")}...` : ''}</p>
```

## use()

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