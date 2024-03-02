# event

리액트에서 이벤트에 응답하는 방식을 정리

## 이벤트 핸들러 추가

이벤트 핸들러를 추가하려면 먼저 함수를 정의하고 JSX 태그에 prop 형태로 전달한다.

```
export default function Button() {
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

1. 컴포넌트 내부에 `handle~` 함수를 선언
2. 해당 함수 내부 로직 구현
3. JSX에 `onClick={hadle~}` 추가

- `handleClick` 함수를 정의하고 이를 `<button>`에 prop 형태로 전달했다.
- 이때 `handleClick`은 **이벤트 핸들러**이다.

이벤트 핸들러를 JSX 내에서 *인라인*으로 정의하는 방법

```
<button onClick={function handleClick() {
    alert('You clicked me!');
}}>
```

화살표 함수를 사용하는 방법

```
<button onClick={() => {
    alert('You clicked me!');
}}>
```

### 주의사항

이벤트 핸들러로 전달한 함수는 호출이 아니라 전달되어야 한다.

| <center>함수를 전달(올바른 예시)</center> | <center>함수를 호출(잘못된 예시)</center> |
| :---------------------------------------- | :---------------------------------------- |
| `<button onClick={handleClick}>`          | `<button onClick={handleClick()}>`        |

- 올바른 예시: 버튼을 클릭할 때 함수가 호출됨
- 잘못된 예시: 인라인으로 함수를 호출하면 컴포넌트가 렌더링 될 때마다 실행됨

## 이벤트 핸들러의 특징

> 주로 컴포넌트 내부에서 정의된다.  
> `handle`로 시작하고 그 뒤에 이벤트명을 붙인 함수명을 가진다.(관습적)

### 이벤트 핸들러 prop 명명 규칙

> `<button>`과 `<div>` 같은 빌트인 컴포넌트는 `onClick`과 같은 브라우저 이벤트 이름 만을 지원한다.  
> 그러나 사용자 정의 컴포넌트에서는 이벤트 핸들러 prop의 이름을 원하는 대로 명명할 수 있다.  
> 관습적으로 이벤트 핸들러 prop의 이름은 `on`으로 시작하여 대문자 영문으로 이어진다.

> 이벤트 핸들러는 **이벤트 오브젝트**를 유일한 매개변수로 받는다.  
> 관습적으로 "event"를 의미하는 `e`로 호출하는 것이 일반적이다.

```
function Button({ onSmash, children }) {
    return (
        <button onClick={onSmash}>
            {children}
        </button>
    );
}

export default function App() {
    return (
        <div>
            <Button onSmash={() => alert('Playing!')}>
                Play Movie
            </Button>
            <Button onSmash={() => alert('Uploading!')}>
                Upload Image
            </Button>
        </div>
    );
}
```

컴포넌트가 여러 상호작용을 지원한다면 이벤트 핸들러 prop을 앱에 특화시켜 명명할 수 있다.

```
export default function App() {
    return (
        <Toolbar
            onPlayMovie={() => alert('Playing!')}
            onUploadImage={() => alert('Uploading!')}
        />
    );
}

function Toolbar({ onPlayMovie, onUploadImage }) {
    return (
        <div>
            <Button onClick={onPlayMovie}>
                Play Movie
            </Button>
            <Button onClick={onUploadImage}>
                Upload Image
            </Button>
        </div>
    );
}

function Button({ onClick, children }) {
    return (
        <button onClick={onClick}>
            {children}
        </button>
    );
}
```

- `App` 컴포넌트는 `Toolbar`가 `onPlayMovie` 또는 `onUploadImage`를 가지고 무엇을 할 것인지 알 필요가 없다.
  - 이것은 `Toolbar` 구현의 특별한 부분으로, 지금 위 요소들을 `Button`의 `onClick` 핸들러 요소로 내려보내지만 추후에 키보드 바로가기 키 입력을 통해 활성화할 수도 있다.
- `onPlayMovie`처럼 prop 이름을 어플리케이션별 상호작용에 기반하여 명명해두면 어떻게 이용할지 유연성을 제공한다.

## 이벤트 핸들러 안에서 prop 읽기

이벤트 핸들러는 컴포넌트 내부에서 선언되므로 해당 컴포넌트의 prop에 접근할 수 있다.

```
function AlertButton({ message, children }) {
    return (
        <button onClick={() => alert(message)}>
            {children}
        </button>
    );
}
```

## 이벤트 핸들러를 prop으로 전달하기

부모 컴포넌트로 자식의 이벤트 핸들러를 지정하기 원할 수 있다.  
예를들어, `Button` 컴포넌트를 사용하는 위치에 따라 다른 기능을 수행하고 싶을 때

```
function Button({ onClick, children }) {
    return (
        <button onClick={onClick}>
            {children}
        </button>
    );
}

function PlayButton({ movieName }) {
    function handlePlayClick() {
        alert(`Playing ${movieName}!`);
    }

    return (
        <Button onClick={handlePlayClick}>
            Play "{movieName}"
        </Button>
    );
}

function UploadButton() {
    return (
        <Button onClick={() => alert('Uploading!')}>
            Upload Image
        </Button>
    );
}

export default function Toolbar() {
    return (
        <div>
            <PlayButton movieName="Kiki's Delivery Service" />
            <UploadButton />
        </div>
    );
}
```

위 코드에서는 `Toolbar` 컴포넌트가 `PlayButton`과 `UploadButton`을 렌더링한다.

- `PlayButton`은 `handlePlayClick`을 `Button` 내 `onClick` prop으로 전달
- `UploadButton`은 `() => alert('Uploading!')`을 `Button` 내 `onClick` prop으로 전달
- 최종적으로, `Button` 컴포넌트는 `onClick` prop을 받고, 받은 prop을 브라우저 빌트인 `<button>`의 `onClick={onClick}`으로 직접 전달

> 디자인 시스템을 적용한다면 버튼과 같은 컴포넌트는 동작을 지정하지 않고 스타일만 지정하는 것이 일반적이다.  
> 그 대신 `PlayButton`과 `UploadButton` 같은 컴포넌트가 이벤트 핸들러를 전달하도록 한다.

## Event propagation(이벤트 전파)

이벤트 핸들러는 해당 컴포넌트가 가진 자식 컴포넌트의 이벤트를 수신할 수 있다.

> 이를 이벤트가 트리를 따라 "bubble"되거나 "전파된다"고 표현한다.  
> 이때 이벤트는 발생 지점에서 시작하여 트리를 따라 위로 전달된다.

아래 `<div>`는 두 개의 버튼을 포함하고, `<div>`와 각 버튼은 각자의 `onClick` 핸들러를 갖는다.

```
export default function Toolbar() {
    return (
        <div className="Toolbar" onClick={() => {
            alert('You clicked on the toolbar!');
        }}>
        <button onClick={() => alert('Playing!')}>
            Play Movie
        </button>
            <button onClick={() => alert('Uploading!')}>
                Upload Image
            </button>
        </div>
    );
}
```

- 둘 중의 어느 버튼을 클릭해도 해당 버튼의 `onClick`이 실행된 후 부모인 `<div>`의 `onClick`이 실행됨
- 툴바 자체를 클릭하면 부모인 `<div>`의 `onClick`만 실행됨

**주의사항**

> 부여된 JSX 태그 내에서만 실행되는 `onScroll`을 제외한 React 내의 모든 이벤트는 전파된다.

## Stopping propagation(전파 멈추기)

이벤트 핸들러는 **이벤트 오브젝트**를 유일한 매개변수로 받는다.  
이 오브젝트를 이벤트의 정보를 읽어들이는데 사용할 수 있다.  
이벤트 오브젝트는 전파를 멈출 수 있게 해준다.  
자식 컴포넌트에서 `e.stopPropagation()`을 호출한다.

- `e.stopPropagation()`은 이벤트 핸들러가 상위 태그에서 실행되지 않도록 멈춤

> 관습적으로 "event"를 의미하는 `e`로 호출하는 것이 일반적이다.

```
function Button({ onClick, children }) {
    return (
        <button onClick={e => {
            e.stopPropagation();
            onClick();
        }}>
            {children}
        </button>
    );
}
```

> 버튼을 클릭하면 다음 절차가 진행됨
>
> 1. 리액트가 `<button>`에 전달된 `onClick` 핸들러 호출
> 2. `Button`에 정의된 해당 핸들러는 다음을 수행
>    > - `e.stopPropagation()`을 호출하여 이벤트가 더 이상 bubbling 되지 않도록 방지
>    > - `Toolbar` 컴포넌트가 전달해 준 `onClick` 함수 호출
> 3. `Toolbar` 컴포넌트에서 정의된 위 함수가 버튼의 alert 표시
> 4. 전파가 중단되었으므로 부모인 `<div>`의 `onClick`은 실행되지 않음

### 단계별 이벤트 캡쳐

전파가 중단되어도 자식의 모든 이벤트를 확인해야 할 때가 있다.  
예를 들어, 분석을 위해 전파 로직에 상관없이 모든 클릭 이벤트를 기록하고 싶다면 이벤트명 마지막에 `Capture`를 추가하면 된다.  
이벤트 캡처는 라우터나 분석을 위한 코드에 유용하지만, 일반 애플리케이션 코드에서는 사용하지 않을 가능성이 높다.

```
<div onClickCapture={() => { /* this runs first */ }}>
    <button onClick={e => e.stopPropagation()} />
    <button onClick={e => e.stopPropagation()} />
</div>
```

> 1. 아래로 전달되면서 만나는 모든 `onClickCapture` 핸들러를 호출
> 2. 클릭된 요소의 `onClick` 핸들러를 실행
> 3. 위로 전달되면서 만나는 모든 `onClick` 핸들러를 호출

## 전파의 대안으로 핸들러 전달

```
function Button({ onClick, children }) {
    return (
        <button onClick={e => {
            e.stopPropagation();
            onClick();
        }}>
            {children}
        </button>
    );
}
```

핸들러 안에서 부모의 `onClick` 이벤트 핸들러를 호출하는 부분 앞에 코드를 더 추가할 수 있다.  
부모 컴포넌트가 일부 추가적인 동작에 특화되도록 하면서  
자식 컴포넌트가 이벤트를 핸들링할 수 있다.

> 장점
>
> - 전파와는 다르게 자동으로 동작하지 않는다.
> - 일부 이벤트의 결과로 실행되는 전체 코드 체인을 명확히 좇을 수 있게 한다.

## 기본 동작 방지

일부 브라우저 이벤트는 기본 브라우저 동작을 가진다.  
예를 들어, `<form>`의 `submit` 이벤트는 그 내부의 버튼을 클릭 시 페이지 전체를 리로드한다.  
`e.preventDefault()`를 이벤트 오브젝트에서 호출하여 방지할 수 있다.

- `e.preventDefault()`는 기본 브라우저 동작을 가진 일부 이벤트가 해당 기본 동작을 실행하지 않도록 방지

```
export default function Signup() {
    return (
        <form onSubmit={e => {
            e.preventDefault();
            alert('Submitting!');
        }}>
            <input />
            <button>Send</button>
        </form>
    );
}
```

## 이벤트 핸들러와 사이드 이펙트

이벤트 핸들러는 사이드 이펙트를 위한 최고의 위치이다.  
함수를 렌더링하는 것과 다르게 이벤트 핸들러는 순수할 필요가 없기에 무언가를 *변경*하는데 최적의 위치다.  
예를 들어 '타이핑에 반응해 입력 값 수정', '버튼 입력에 따라 리스트 변경'에 적절하다.

그러나 일부 정보 수정을 위해서는 먼저 그 정보를 저장할 수단이 필요하다.  
리액트는 컴포넌트의 기억 역할을 하는 state를 이용할 수 있다.
