# 리액트 정리

## 컴포넌트

### 개념

리액트를 사용하면 마크업, CSS, 자바스크립트를 **앱의 재사용 가능한 UI 요소**인 사용자 정의 "컴포넌트"로 결합할 수 있다.  
내부적으로는 여전히 `<article>`, `<h1>` 등과 같은 동일한 HTML태그를 사용한다.  

1. 리액트 앱은 컴포넌트로 구성되며, 컴포넌트란 '고유한 로직과 모양을 가진 UI의 일부'다. 컴포넌트는 버튼만큼 작을 수도, 전체 페이지만큼 클 수도 있다.
2. 리액트 컴포넌트는 **마크업을 반환하는 자바스크립트 함수**다.

3. 선언한 컴포넌트는 다른 컴포넌트 안에 **중첩**할 수 있다.

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

4. 컴포넌트의 이름은 항상 **대문자**로 시작한다.
5. 컴포넌트는 여러 개의 JSX 태그를 반환할 수 없다.
6. 컴포넌트는 다른 컴포넌트를 렌더링할 수 있지만, 그 정의를 중첩해서는 안 된다.  
    
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

7. 리액트 앱은 root 컴포넌트에서 시작한다. 보통 새 프로젝트를 시작할 때 자동으로 생성된다.  
8. 예제의 컴포넌트들은 모두 `App.js`라는 **root 컴포넌트** 파일에 존재한다. 설정에 따라 root 컴포넌트가 다른 파일에 위치할 수 있다.  
9. Next.js의 경우 root 컴포넌트는 `pages/index.js`에 정의된다.  
10. 리액트 기반 프레임워크들은 리액트 컴포넌트에서 HTML을 자동으로 생성하기도 한다. 이를 통해 자바스크립트 코드가 로드되기 전에 앱에서 일부 컨텐츠를 표시할 수 있다.  


### export, import

`export default` 접두사는 표준 자바스크립트 구문이다.  

1. 컴포넌트는 별도의 파일로 옮길 수 있다.

## JSX

### 개념

```
<img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />;
```

- `src` 및 `alt` 속성을 가진 `<img />` 태그  
- `<img />` 태그는 HTML처럼 생겼지만 실제로는 자바스크립트이다.  
- 이러한 구문을 JSX라고 하며, 자바스크립트 안에 마크업을 삽입할 수 있다.  

1. JSX는 선택사항이지만 대부분의 리액트 프로젝트는 JSX를 사용한다.
2. JSX는 항상 태그를 닫아야 한다. 
3. 컴포넌트가 JSX 태그를 반환할 때는 `return`과 같은 줄에 한 줄로 작성하거나, 괄호로 묶어야 한다.  
    - 괄호가 없으면 `return` 뒷 라인의 모든 코드가 무시된다.  


## CSS

1. 리액트는 ```className``` 으로 CSS class를 지정한다. 이것은 HTML의 ```class``` 어트리뷰트와 동일한 방식으로 동작한다.
2. 리액트는 CSS 파일을 추가하는 방법을 규정하지 않는다.

## state

### 개념

1. 컴포넌트가 특정 정보를 기억하기를 원한다면 state를 사용한다.
2. 같은 컴포넌트를 여러 번 렌더링하면 각각의 컴포넌트는 고유한 state를 얻는다.
3. 컴포넌트 간에 데이터를 공유하고 싶다면, 해당 컴포넌트들을 모두 포함하는 상위 컴포넌트에 state를 선언하고 두 자식 컴포넌트에 전달한다.
4. props를 사용한 컴포넌트 간의 state 공유를 'state 올리기'라고 한다. state를 위로 이동하여 컴포넌트 간에 state를 공유하는 것이다.

## Hooks

### 개념

1. ```use``` 로 시작하는 함수를 Hooks라고 하며, ```useState``` 는 리액트에서 제공하는 내장 Hook이다.
2. Hooks는 다른 함수보다 더 제한적이다. 컴포넌트(또는 다른 Hooks)의 상단에서만 Hooks를 호출할 수 있다.

## props

### 개념

1. 자식 컴포넌트에 JSX 중괄호를 사용해서 전달하는 정보를 props라고 한다.