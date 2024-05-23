# Hooks

## useFormStatus()

[React Docs](https://react.dev/reference/react-dom/hooks/useFormStatus)  

import: react-dom  
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