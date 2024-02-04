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
| :--- | :--- |
| `<button onClick={handleClick}>` | `<button onClick={handleClick()}>` |

- 올바른 예시: 버튼을 클릭할 때 함수가 호출됨  
- 잘못된 예시: 인라인으로 함수를 호출하면 컴포넌트가 렌더링 될 때마다 실행됨  

## 이벤트 핸들러의 특징  

> 주로 컴포넌트 내부에서 정의된다.  
> `handle`로 시작하고 그 뒤에 이벤트명을 붙인 함수명을 가진다.(관습적) 

### 이벤트 핸들러 prop 명명 규칙

> `<button>`과 `<div>` 같은 빌트인 컴포넌트는 `onClick`과 같은 브라우저 이벤트 이름 만을 지원한다.  
> 그러나 사용자 정의 컴포넌트에서는 이벤트 핸들러 prop의 이름을 원하는 대로 명명할 수 있다.  
> 관습적으로 이벤트 핸들러 prop의 이름은 `on`으로 시작하여 대문자 영문으로 이어진다.  

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

