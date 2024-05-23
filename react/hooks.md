# Hooks

## useActionState()

[React Docs](https://18.react.dev/reference/react/useActionState)

> React Canary 버전에서 React DOM의 useFormState()의 이름이 바뀌었다.  

import: react  
parameters: 

  1. `fn`: 양식을 제출하거나 버튼을 눌렀을 때 호출할 함수. 호출되면 양식의 이전 상태(처음에는 전달한 초기 상태, 이후에는 이전 반환 값)를 초기 인수로 받은 다음 form action이 일반적으로 받는 인수를 받는다.
  2. `initialState`: 처음 상태를 설정할 값. 직렬화 가능한 모든 값이 가능하며 이 인수는 액션이 처음 호출된 후에는 무시된다.
  3. **optional** `permalink`: 이 `form`이 수정하는 고유한 페이지 URL이 포함된 문자열 

returns: 두 개의 원소를 가진 Array

  1. `state`: 현재 상태. 첫 번째 렌더링 중에는 초기 상태와 일치하며 액션이 호출된 후에는 액션이 반환한 값과 일치한다.
  2. `formAction`: `form` 컴포넌트에 `action` 프로퍼티로 전달할 수 있는 새 액션 또는 `form` 내의 `button` 컴포넌트에 `formAction` 프로퍼티로 전달할 수 있는 새 액션

```javascript
const [state, formAction] = useActionState(fn, initialState, permalink?);
```

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

import: react-dom  
parameters: none
returns: `status` object  
  - properties: `pending`, `data`, `method`, `action`

부모 `form`의 제출 상태 정보를 제공하는 훅이다.  
반드시 `form` 안에서 선언해야 상태를 제공할 수 있으나 훅은 컴포넌트 최상단에서만 선언할 수 있다.  
따라서 별도의 컴포넌트로 구성하여 해당 컴포넌트를 `form` 안에 렌더링하는 방식으로 사용한다.  

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