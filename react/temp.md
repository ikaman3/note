# React

> 리액트를 학습한 내용을 기록하는 파일이다.

## React `setState` vs `useEffect`

### Updater function

함수가 반환된 후 사라지는 일반 변수와 다르게 state는 함수 외부(리액트 자체)에 존재함  
리액트는 컴포넌트가 호출되면 해당 렌더링에 대한 state의 스냅샷을 제공함  
컴포넌트는 해당 스냅샷의 state 값을 사용함  
state를 설정(`setState`)하면 **다음 렌더링**에 변경된다

- `setState`를 호출하면 리액트는 Update queue에 값 또는 함수를 push함  
  이때 화살표 함수를 전달하면 **Updater function**이라고 한다.

```javascript
const [number, setNumber] = useState(0)
setState((n) => n + 1)
```

- `(n) => n + 1`: 업데이터 함수

업데이터 함수를 사용하면 이전 상태값에 직접 참조할수 있으므로 복잡한 상태 업데이트 로직도 편하게 구현할 수 있다.  
그러나 업데이터 함수는 여전히 비동기적이다. 상태가 변경된 후 즉시 실행하는 게 아니라  
이벤트 루프 내의 다음 사이클에서 실행된다.

### `useEffect`

외부 시스템과 컴포넌트를 동기화하는 리액트 Hook  
상태나 props가 변경될 때 특정 작업을 실행한다.  
의존성 배열로 특정 상태와 props가 변경될 때만 실행하므로 불필요한 작업을 방지할 수 있다.  
useEffect 훅 내에서 동기적으로 작업할 수 있다.

의존성 배열을 잘못 설정하면 불필요한 동작이 발생할 수 있으므로 의존성 배열 관리가 중요하다.  
useEffect 훅은 컴포넌트 렌더링 때마다 실행되므로 side effect가 발생하는 경우를 조심해야 한다.  
cleanup 함수를 사용하여 side effect를 정리할 수 있다.

의존성 배열에 객체, 함수를 넣으면 필요 이상으로 재실행될 수 있다.

Effect가 상호작용(클릭 등)에 의해 일어나지 않는다면, 리액트는 브라우저가 업데이트된 화면을 그리도록 허용(_브라우저 렌더링 = 페인팅_)한 후  
Effect를 실행한다.

### Effect에서 이전 state를 기반으로 state 업데이트하기

Effect에서 이전 state를 기반으로 state 업데이트하면 문제가 발생할 수 있다.

잘못된 예:

```javascript
function Counter() {
  const [count, setCount] = useState(0)

  useEffect(() => {
    const intervalId = setInterval(() => {
      setCount(count + 1) // 매초마다 카운터 증가
    }, 1000)
    return () => clearInterval(intervalId)
  }, [count]) // count를 의존성으로 명시하면 항상 인터벌이 초기화됨
}
```

- `count`가 반응형 값이므로 반드시 의존성 배열에 추가해야 하지만  
  `count`의 변경이 Effect가 정리된 후 다시 설정되는 것을 야기하므로 `count` 값이 계속 증가함

이러한 현상을 방지하기 위해 업데이터 함수를 함께 사용할 수 있다.

```javascript
function Counter() {
  const [count, setCount] = useState(0)

  useEffect(() => {
    const intervalId = setInterval(() => {
      setCount((c) => c + 1) // state updater function 전달
    }, 1000)
    return () => clearInterval(intervalId)
  }, []) // 이제 count는 의존성이 아님
}
```

### 요약

`setState`를 동기처럼(엄밀히 말하면 여전히 비동기) 사용하려면 업데이터 함수를 이용할 수 있다.  
`setState`는 이름처럼 state를 설정하는 용도

Effect를 사용하면 페인팅 이후 작업을 수행해서 동기식으로 작업할 수 있으며  
Effect가 존재하는 의미는 외부 시스템(API, 라이브러리 등 리액트로 컨트롤되지 않는 모든 코드)과 컴포넌트를 연결(동기화)하는 것

두 훅을 함께 사용하는 것도 가능하다.

## 네이밍 컨벤션

내 나름대로 정해둠

컴포넌트: 중첩된 디렉터리 이름 + 파일 이름 / `diary/edit/page.js` --> `DiaryEditPage`  
root 디렉터리에 존재하는 파일의 컴포넌트: Root + 파일 이름 / `RootPage`, `RootLayout`  
서버 액션: 접두사 = get/create/update/delete, 접미사 = Action

## async/await과 `use` API

리액트의 서버 컴포넌트에서 asycn/await으로 비동기 작업을 할 수 있고 Promise를 생성하여 클라이언트 쪽으로 전달할 수도 있다.  
전달한 Promise를 클라이언트에서 `use` API를 사용하여 기다리는 방식으로 서버에서 클라이언트로 데이터 스트리밍하여 비동기 작업을 처리할 수 있다.

예시:  
`note` 컨텐츠는 페이지 렌더링에 중요한 데이터이므로 서버 측에서 `await`한다.  
댓글은 중요도가 낮아 페이지 아래에 표시하므로 서버에서 Promise를 시작하고 `use` API를 사용하여 기다린다.  
이는 클라이언트에서 중단되지만 `note` 컨텐츠가 렌더링되는 것을 차단하지 않는다.

```javascript
// Server Component
import db from './database'

async function Page({ id }) {
  // Will suspend the Server Component.
  const note = await db.notes.get(id)
  // NOTE: not awaited, will start here and await on the client
  const commentsPromise = db.comments.get(note.id)
  return (
    <div>
      {note}
      <Suspense fallback={<p>Loading comments...</p>}>
        <Comments commentsPromise={commentsPromise} />
      </Suspense>
    </div>
  )
}
```

```javascript
// Client Component
'use client'
import { use } from 'react'

function Comments({ commentsPromise }) {
  // NOTE: this will resume the promise from the server.
  // It will suspend until the data is available.
  const comments = use(commentsPromise)
  return comments.map((comment) => <p>{comment}</p>)
}
```

`note` 같은 메인 컨텐츠는 서버에서 `await`하여 데이터를 기다리고 댓글처럼 우선순위가 떨어지는 데이터는  
서버에서 Promise를 만들고 클라이언트에서 `use` API로 비동기 처리한다.

## Slug

해당 페이지의 내용을 함축하여 전달하기 위한 URL Segments  
임의로 만든 id나 난수보다 SEO에 도움이 된다.

일기의 id를 URL에 사용: `my.com/diary/123`  
일기의 제목과 작성날짜를 slug로 사용: `my.com/diary/라이브-지렸다-20240529`
