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

## useRef()

렌더링에 필요하지 않은 값을 참조할 수 있는 리액트 훅  
state와는 다르게 ref는 변경해도 리렌더링을 촉발하지 않음. 즉 ref는 컴포넌트의 시각적 출력에 영향을 미치지 않는 정보 저장에 적합  
리렌더링 사이에 정보를 저장할 수 있으며 각각의 컴포넌트에 로컬로 저장된다.

```javascript
// 선언
const fileInput = useRef(null)

// JSX 태그의 참조 전달
<input
  ...
  ref={fileInput}
/>

// 사용
fileInput.current?.click()
fileInput.current.value = ''
```

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
import { useActionState } from "react";
import { addToCart } from "./actions";

function AddToCartForm({ itemID, itemTitle }) {
  const [formState, formAction] = useActionState(addToCart, {});
  return (
    <form action={formAction}>
      <h2>{itemTitle}</h2>
      <input type="hidden" name="itemID" value={itemID} />
      <button type="submit">Add to Cart</button>
      {formState?.success && (
        <div className="toast">
          Added to cart! Your cart now has {formState.cartSize} items.
        </div>
      )}
      {formState?.success === false && (
        <div className="error">Failed to add to cart: {formState.message}</div>
      )}
    </form>
  );
}

export default function App() {
  return (
    <>
      <AddToCartForm itemID="1" itemTitle="JavaScript: The Definitive Guide" />
      <AddToCartForm itemID="2" itemTitle="JavaScript: The Good Parts" />
    </>
  );
}
```

```javascript
// actions.js
"use server";

export async function addToCart(prevState, queryData) {
  const itemID = queryData.get("itemID");
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
  {pending ? "Submitting..." : "Submut"}
</button>;

// 제출 메시지를 띄우기
{
  pending && <p>제출 중입니다...</p>;
}

// input에 사용
<input type="text" readOnly={pending} />;
```

#### 제출하는 데이터 보여주기

```javascript
<p>{data ? `Requesting ${data?.get("username")}...` : ""}</p>
```
