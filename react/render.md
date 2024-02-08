# render

컴포넌트를 화면에 표시하기 이전에 리액트에서 렌더링해야 한다.  

> 렌더링은 항상 순수한 계산:  
>  
> - 동일한 입력에는 동일한 출력  
> - 이전의 state를 변경해서는 안 됨

## UI 요청 및 제공 단계

1. 렌더링 트리거
2. 컴포넌트 렌더링
3. DOM에 커밋

### 1단계: 렌더링 트리거

컴포넌트 렌더링이 일어나는 데에는 두 가지 이유가 있다.  

1. 컴포넌트의 초기 렌더링인 경우
2. 컴포넌트의 state가 업데이트된 경우  

#### 초기 렌더링

앱이 시작할 때 초기 렌더링을 한다.  
대상 DOM 노드로 `createRoot`를 호출한 다음 해당 컴포넌트로 `render` 메서드를 호출하여 수행한다.  

- 프레임워크나 샌드박스에서는 이 코드를 숨기기도 하지만, 내부적으로 수행된다.  

#### state 업데이트 시 리렌더링

컴포넌트가 처음으로 렌더링되면, `set` 함수를 사용하여 추가적인 렌더링을 트리거할 수 있다.  
컴포넌트의 상태를 업데이트하면 자동으로 렌더링이 대기열에 추가된다.  

### 2단계: 리액트 컴포넌트 렌더링

렌더링을 트리거한 후 리액트는 컴포넌트를 호출해 화면에 표시할 내용을 파악한다.  

> **"렌더링"이란 "리액트에서 컴포넌트를 호출하는 것"**이다.  

- 초기 렌더링에서 루트 컴포넌트를 호출
- 이후 렌더링에서 state 업데이트가 일어나 렌더링을 트리거한 컴포넌트를 호출

> 렌더링은 재귀적 단계:  
>  
> 업데이트된 컴포넌트가 다른 컴포넌트를 반환하면  
> 리액트는 다음으로 해당 컴포넌트를 렌더링하고  
> 해당 컴포넌트도 컴포넌트를 반환하면 반환된 컴포넌트를 다음에 렌더링한다.  
> 중첩된 컴포넌트가 더 이상 없고, 리액트가 화면에 표시될 내용을 정확히 알 때까지 이 단계는 계속된다.  

### 3단계: 리액트가 DOM에 변경사항을 커밋

컴포넌트를 렌더링(호출)한 후 리액트는 DOM을 수정한다.  

- 초기 렌더링의 경우: `appendChild()` DOM API를 사용하여 생성한 모든 DOM 노드를 화면에 표시  
- 리렌더링의 경우: 필요한 최소한의 작업을 적용해 DOM을 최신 렌더링 출력과 일치시킴

> 리액트는 렌더링 간에 차이가 있는 경우에만 DOM 노드를 변경한다.  
> - 매초 부모로부터 전달된 다른 props로 리렌더링하는 컴포넌트가 있을 때 `<input>`에 텍스트를 입력하여 `value`를 업데이트해도 리렌더링할 때 텍스트가 사라지지 않음
> - 리액트가 마지막 단계에서 `<h1>`의 내용만 새로운 `time`으로 업데이트하기 때문이다.  

## 브라우저 페인트

> 렌더링이 완료되고 리액트가 DOM을 업데이트한 후 브라우저는 화면을 다시 그린다.  
> 이 단계를 "브라우저 렌더링"이라고 하지만 혼동을 피하고자 "페인팅"으로 지칭한다.  

## state과 렌더링

리액트에서는 state를 설정하면 리렌더링을 수행한다. 즉, 인터페이스가 이벤트에 반응하려면 state를 업데이트해야 한다.  

```javascript
export default function Form() {
    const [isSent, setIsSent] = useState(false);
    const [message, setMessage] = useState('Hi!');
    ...
    return (
        <form onSubmit={(e) => {
            e.preventDefault();
            setIsSent(true);
            sendMessage(message);
        }}>
            <textarea
                placeholder="Message"
                value={message}
                onChange={e => setMessage(e.target.value)}
            />
            <button type="submit">Send</button>
        </form>
    );
}
```

- 위의 코드에서 버튼을 클릭하면 다음과 같은 일이 발생한다.  

1. `onSubmit` 이벤트 핸들러가 실행
2. `setIsSent(true)`가 `isSent`를 `true`로 설정하고 새로운 렌더링을 큐에 넣음
3. 리액트가 새로운 `isSent` 값에 따라 컴포넌트 리렌더링

함수가 반환된 후 사라지는 일반 변수와 다르게 state는 함수 외부, 리액트 자체에 존재한다.  
리액트가 컴포넌트를 호출하면 특정 렌더링에 대한 state의 스냅샷을 제공한다.  
컴포넌트는 **해당 렌더링의 state 값을 사용해** 계산된 새로운 props 세읕와 이벤트 핸들러가 포함된 UI의 스냅샷을 JSX에 반환한다.  

1. 리액트에 state 업데이트 명령
2. 리액트가 state 값을 업데이트
3. 리액트는 state 값의 스냅샷을 컴포넌트에 전달

## 렌더링은 그 시점의 스냅샷을 찍음

렌더링이란 리액트가 컴포넌트, 즉 함수를 호출한다는 뜻이다.  
해당 함수에서 반환하는 JSX는 시간상 UI의 스냅샷과 같다.  
prop, 이벤트 핸들러, 로컬 변수 모두 렌더링 당시의 state를 사용해 계산된다.  
  
사진이나 동영상 프레임과 달리 반환하는 *UI 스냅샷*은 대화형이다.  
여기에는 입력에 대한 응답으로 어떤 일이 일어날지 지정하는 이벤트 핸들러 같은 로직이 포함된다.  
그럼 리액트는 이 스냅샷과 일치하도록 화면을 업데이트하고 이벤트 핸들러를 연결한다.  
결과적으로 버튼을 누르면 JSX의 클릭 핸들러가 발동된다.  

### 리액트가 컴포넌트를 리렌더링할 때

1. 리액트가 함수를 다시 호출
2. 함수가 새로운 JSX 스냅샷을 반환(스냅샷 계산)
3. 리액트는 함수가 반환한 스냅샷과 일치하도록 화면을 업데이트(DOM Tree 업데이트)

## state와 렌더링

함수가 반환된 후 사라지는 일반 변수와 다르게 state는 함수 외부, 리액트 자체에 존재한다.  
리액트가 컴포넌트를 호출하면 특정 렌더링에 대한 state의 스냅샷을 제공한다.  
컴포넌트는 **해당 렌더링의 state 값을 사용해** 계산된 새로운 props 세읕와 이벤트 핸들러가 포함된 UI의 스냅샷을 JSX에 반환한다.  

1. 리액트에 state 업데이트 명령
2. 리액트가 state 값을 업데이트
3. 리액트는 state 값의 스냅샷을 컴포넌트에 전달

```javascript
export default function Counter() {
    const [number, setNumber] = useState(0);
    return (
        <>
            <h1>{number}</h1>
            <button onClick={() => {
                setNumber(number + 1);
                setNumber(number + 1);
                setNumber(number + 1);
            }}>+3</button>
        </>
    )
}
```

- 위 코드의 버튼을 클릭해도 `number`는 클릭당 한 번만 증가함  

**state를 설정하면 다음 렌더링에 대해서만 변경된다.**  
이 버튼의 클릭 핸들러가 리액트에 지시하는 작업은 다음과 같다.  

> 1. `setNumber(number + 1)`: `number`는 0이므로 `setNumber(0 + 1)`입니다.
> - React는 다음 렌더링에서 `number`를 1로 변경할 준비를 합니다.
> 2. `setNumber(number + 1)`: `number`는 0이므로 `setNumber(0 + 1)`입니다.
> - React는 다음 렌더링에서 `number`를 1로 변경할 준비를 합니다.
> 3. `setNumber(number + 1)`: `number`는 0이므로 `setNumber(0 + 1)`입니다.
> - React는 다음 렌더링에서 `number`를 1로 변경할 준비를 합니다.
>  
> `setNumber(number + 1)`를 세 번 호출했지만, 이 렌더링의 이벤트 핸들러에서 `number`는 항상 `0`이므로 state를 `1`로 세 번 설정한 것  

state 변수를 해당 값으로 대입하여 생각할 수 있다.  

```javascript
<button onClick={() => {
    setNumber(0 + 1);
    setNumber(0 + 1);
    setNumber(0 + 1);
}}>+3</button>
```

다음 렌더링

```javascript
<button onClick={() => {
    setNumber(1 + 1);
    setNumber(1 + 1);
    setNumber(1 + 1);
}}>+3</button>
```

## 시간 경과에 따른 state

```javascript
export default function Counter() {
    const [number, setNumber] = useState(0);
    return (
        <>
            <h1>{number}</h1>
            <button onClick={() => {
                setNumber(number + 5);
                setTimeout(() => {
                    alert(number);
                }, 3000);
            }}>+5</button>
        </>
    )
}

// alert()에 전달된 state의 스냅샷
setNumber(0 + 5);
setTimeout(() => {
    alert(0);
}, 3000);
```

state 변수의 값(컴포넌트를 호출해 리액트가 UI의 스냅샷을 찍을 때 고정된 값)은 이벤트 핸들러의 코드가 비동기적이더라도 **렌더링 내에서 절대 변경되지 않는다.**  

## state 업데이트 큐

state 변수를 설정하면 다음 렌더링이 큐에 들어간다.  
때에 따라 다음 렌더링을 큐에 넣기 전에, 값에 여러 작업을 수행할 수 있다.  

### 리액트 state batches 업데이트

리액트는 **state를 업데이트하기 전에 이벤트 핸들러의 모든 코드가 실행될 때까지 기다린다.**  
이러면 너무 많은 리렌더링 없이 여러 컴포넌트에서 나온 다수의 state 변수를 업데이트할 수 있다.  
하지만 이는 이벤트 핸들러와 그 안의 코드가 완료될 때까지 UI가 업데이트되지 않는다는 의미이기도 하다.  

- '**batching**'라고도 하는 이 동작은 리액트 앱이 훨씬 빠르게 실행되게 한다.  
- 또한, 일부 변수만 업데이트된 미완성 렌더링을 처리하지 않아도 된다.  

클릭과 같은 여러 의도적인 이벤트에 대해 batch 않으며, 각 클릭은 개별적으로 처리된다.  

- 예를 들어, 첫 번째 클릭으로 양식이 비활성화되면 두 번째 클릭으로 양식이 다시 제출되지 않도록 보장함  

### 업데이터 함수

`setNumber(number + 1)` 처럼 다음 state 값 대신,  
`setNumber(n => n + 1)` 같이 이전 큐의 state를 기반으로 다음 state를 계산하는 함수를 전달할 수 있다.  

- 단순히 state 값을 대체하는 것이 아니라 리액트에 'state 값으로 무언가를 하라'고 지시하는 방법이다.  
- 여기서 `n => n + 1`은 Updater function(업데이터 함수)라고 부른다.  

업데이터 함수를 state 설정자 함수에 전달할 때,  

1. 리액트는 이벤트 핸들러의 다른 코드가 모두 실행된 후에 이 함수가 처리되도록 큐에 넣음
2. 다음 렌더링 중에 리액트는 큐를 순회하여 최종 업데이트된 state를 제공

> 위의 코드의 작동 방식  
> 
> 1. setNumber(n => n + 1): n => n + 1 함수를 큐에 추가
> 2. setNumber(n => n + 1): n => n + 1 함수를 큐에 추가
> 3. setNumber(n => n + 1): n => n + 1 함수를 큐에 추가 
>   
> 다음 렌더링 중에 `useState`를 호출하면 리액트는 큐를 순회한다.  
> 이전 `number` state는 `0`이었으므로 이를 첫 번째 업데이터 함수에 `n`인수로 전달한다.  
> 그런 다음 이전 업데이터 함수의 반환 값을 가져와서 다음 업데이터 함수에 `n`으로 전달하는 식으로 반복  

| queued update | n | returns |
| :---: | :---: | :---: |
| `n => n + 1` | `0` | `0 + 1 = 1` |
| `n => n + 1` | `1` | `1 + 1 = 2` |
| `n => n + 1` | `2` | `2 + 1 = 3` |

- 리액트는 `3`을 최종 결과로 저장하고 `useState`에서 반환  

### state 교체 후 업데이트

```javascript
<button onClick={() => {
    setNumber(number + 5);
    setNumber(n => n + 1);
}}>
```

1. `setNumber(number + 5)`: `number`는 `0`이므로 `setNumber(0 + 5)`이다. React는 큐에 “5로 바꾸기” 를 추가
2. `setNumber(n => n + 1)`: `n => n + 1`는 업데이터 함수다. React는 해당 함수를 큐에 추가

| queued update | n | returns |
| :--: | :--: | :--: |
| `”replace with 5”` | `0`(unused) | `5` |
| `n => n + 1` | `5` | `5 + 1 = 6` |

- 리액트는 `6`을 최종 결과로 저장, `useState`에서 반환   
- `setState(5)`가 실제로는 `setState(n => 5)`처럼 동작하지만 `n`을 생략했다.  

> 이벤트 핸들러가 완료되면 리액트는 리렌더링을 실행  
> 리렌더링하는 동안 리액트는 큐를 처리  
> 업데이터 함수는 렌더링 중에 실행되므로, 업데이터 함수는 순수해야 하며 결과만 반환해야 함  
>  
> - 업데이터 함수 내부에서 state를 변경하거나 다른 사이드 이펙트를 추가하지 말 것  
>  
> Strict 모드에서 리액트는 각 업데이터 함수를 두 번 실행(두 번째 결과는 버림)하여 실수를 찾도록 도움  

### 명명 규칙

업데이터 함수 인수의 이름은 해당 state 변수의 첫 글자로 지정하는 것이 일반적  

```javascript
setEnabled(e => !e);
setLastName(ln => ln.reverse());
setFriendCount(fc => fc * 2);
```

좀 더 자세한 코드를 원한다면 다음과 같이 한다.  

```javascript
// 전체 state 변수 이름 반복
setEnabled(enabled => !enabled);
// 접두사 사용
setEnabled(prevEnabled => !prevEnabled)
```