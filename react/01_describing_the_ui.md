# UI 표현하기

[https://ko.react.dev/learn/describing-the-ui](https://ko.react.dev/learn/describing-the-ui)

리액트 앱은 *컴포넌트*라고 불리는 독립된 UI 조각들로 이루어진다.  
컴포넌트는 마크업을 얹을 수 있는 자바스크립트 함수이다.

- 컴포넌트는 버튼처럼 작을 수도 있고 전체 페이지처럼 클 수도 있다.

## 첫 번째 컴포넌트

### 컴포넌트: UI 구성 요소

React를 사용하면 마크업, CSS, JavaScript를 앱의 재사용 가능한 UI 요소인 사용자 정의 *“컴포넌트”*로 결합할 수 있다.  
목차 코드는 모든 페이지에 렌더링할 수 있는 `<TableOfContents />` 컴포넌트로 전환될 수 있다.

- 내부적으로는 여전히 `<article>`, `<h1>` 등과 같은 동일한 HTML태그를 사용한다.

HTML 태그와 마찬가지로 컴포넌트를 작성, 순서 지정 및 중첩하여 전체 페이지를 디자인할 수 있다.

```
<PageLayout>
  <NavigationHeader>
    <SearchBar />
    <Link to="/docs">Docs</Link>
  </NavigationHeader>
  <Sidebar />
  <PageContent>
    <TableOfContents />
    <DocumentationText />
  </PageContent>
</PageLayout>
```

- 이미 작성한 컴포넌트를 재사용하여 개발 속도가 빨라진다.
- React 오픈 소스 커뮤니티에서 공유되는 컴포넌트로 프로젝트를 빠르게 시작할 수 있다.
- [https://chakra-ui.com/](https://chakra-ui.com/)
- [https://material-ui.com/](https://material-ui.com/)

### 컴포넌트 정의하기

React 컴포넌트는 마크업으로 뿌릴 수 있는 JavaScript 함수이다.  
그 모습은 다음과 같다.

```
export default function Profile() {
  return (
    <img
      src="https://i.imgur.com/MK3eW3Am.jpg"
      alt="Katherine Johnson"
    />
  )
}
```

### 컴포넌트 빌드 방법

#### 1단계: 컴포넌트 내보내기

`export default` 접두사는 [표준 JavaScript 구문](https://developer.mozilla.org/docs/web/javascript/reference/statements/export)이다.

- 다른 파일에서 가져올 수 있도록 파일에 주요 기능을 표시할 수 있다.
- 더 자세한 내용 : [컴포넌트 Importing 및 Exporting](https://ko.react.dev/learn/importing-and-exporting-components)

#### 2단계: 함수 정의하기

`function Profile() {  }` 을 사용하면 `Profile` 이라는 이름의 JavaScript 함수를 정의할 수 있다.

- **주의사항**: React 컴포넌트는 일반 JavaScript 함수이지만, 이름은 대문자로 시작해야만 한다

#### 3단계: 마크업 추가하기

위의 컴포넌트는 `src` 및 `alt` 속성을 가진 `<img />` 태그를 반환한다.  
`<img />` 는 HTML처럼 보이지만 실제로는 JavaScript이다.

- 이러한 구문을 [JSX](https://ko.react.dev/learn/writing-markup-with-jsx)라고 하며, JavaScript 안에 마크업을 삽입할 수 있다.

반환문은 한 줄에 모두 작성해도 된다.

- `return <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />;`

그러나 마크업이 `return` 키워드와 같은 라인에 있지 않다면 괄호로 묶어야 한다.

```
return (
  <div>
    <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
  </div>
);
```

- **주의사항**: 괄호가 없으면 `return` 뒷 라인의 코드가 무시된다.
- [https://stackoverflow.com/questions/2846283/what-are-the-rules-for-javascripts-automatic-semicolon-insertion-asi](https://stackoverflow.com/questions/2846283/what-are-the-rules-for-javascripts-automatic-semicolon-insertion-asi)

### 컴포넌트 사용하기

정의한 `Profile` 컴포넌트는 다른 컴포넌트 안에 중첩할 수 있다.

```
function Profile() {
  return (
    <img
      src="https://i.imgur.com/MK3eW3As.jpg"
      alt="Katherine Johnson"
    />
  );
}

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

### 브라우저에 표시되는 내용

- `<section>` 은 소문자이므로 React는 HTML 태그로 이해한다.
- `<Profile />` 대문자로 시작하므로 React는 컴포넌트로 이해한다.

`<Profile />` 컴포넌트는 더 많은 `<img />` 를 포함한다.

```
<section>
  <h1>Amazing scientists</h1>
  <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
  <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
  <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
</section>
```

### 컴포넌트 중첩 및 구성

컴포넌트가 복잡해지면 별도의 파일로 옮길 수 있다.  
`Profile` 컴포넌트는 `Gallery` 안에서 렌더링되므로 `Gallery` 는 `Profile` 을 '자식'으로 렌더링하는 **부모 컴포넌트** 라고 부른다.

**주의사항**: 컴포넌트는 다른 컴포넌트를 렌더링 할 수 있지만, 그 정의를 중첩해서는 안 된다.

> 잘못된 컴포넌트 정의
>
> - [https://ko.react.dev/learn/preserving-and-resetting-state#different-components-at-the-same-position-reset-state](https://ko.react.dev/learn/preserving-and-resetting-state#different-components-at-the-same-position-reset-state)

```
export default function Gallery() {
  // 🔴 Never define a component inside another component!
  function Profile() {
    // ...
  }
  // ...
}
```

> 올바른 컴포넌트 정의: 최상위 레벨에서 컴포넌트를 정의한다.
>
> - 자식 컴포넌트에 부모 컴포넌트의 일부 데이터가 필요한 경우, 정의를 중첩하는 대신 props로 전달하자.

```
export default function Gallery() {
    // ...
}

// ✅ Declare components at the top level
function Profile() {
    // ...
}
```

### Deep Dive

리액트 앱은 'root' 컴포넌트에서 시작하며, 보통 새 프로젝트를 시작할 때 자동으로 생성된다.

- CodeSandbox, Next.js의 경우 `pages/index.js`에 정의된다.

빈 HTML 파일을 사용하고 리액트가 JavaScript로 페이지 관리를 “다룰 수 있게” 하도록 하는 대신,  
리액트 기반 프레임워크들은 리액트 컴포넌트에서 HTML을 자동으로 생성하기도 한다. 이로써 자바스크립트 코드가 로드되기 전에 앱에서 일부 컨텐츠를 표시할 수 있다.

## 컴포넌트 import 및 export 하기

컴포넌트의 가장 큰 장점: 재사용성

- 컴포넌트를 여러 번 중첩하면 다른 파일로 분리할 시점이 생긴다.
- 이렇게 분리하면 파일을 찾기 쉽고 재사용하기 편하다.

### Root 컴포넌트란

[첫 컴포넌트](#첫-번째-컴포넌트)에서 만든 컴포넌트들은 모두 `App.js` 라는 root 컴포넌트 파일에 존재한다.  
설정에 따라 root 컴포넌트가 다른 파일에 위치할 수도 있다.

### 컴포넌트를 import 하거나 export 하는 방법

1. 컴포넌트를 추가할 JS 파일을 **생성**
2. JS 파일에서 함수 컴포넌트를 **export** (default OR named export)
3. 컴포넌트를 사용할 파일에서 **import** (default OR named import)

```
// App.js

import Gallery from './Gallery.js';

export default function App() {
  return (
    <Gallery />
  );
}
```

```
// Gallery.js

function Profile() {
  return (
    <img
      src="https://i.imgur.com/QIrZWGIs.jpg"
      alt="Alan L. Hart"
    />
  );
}

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

1. `Gallery.js`:
    - `Profile` 컴포넌트를 정의하고 해당 파일에서만 사용하므로 export 하지 않음
    - **Default** 방식으로 `Gallery`를 export
2. `App.js`: 
    - **Default** 방식으로 `Gallery.js`로부터 import
    - Root `App`컴포넌트를 **default** 방식으로 **export**

**중요**  
가끔 `.js` 같은 파일 확장자가 없을 때도 있다.  
`import Gallery from './Gallery';`
리액트는 두 방법 모두 지원하지만, 전자의 경우가 native ES Modules 사용 방법에 더 가깝다.  

### Deep Dive



## JSX로 마크업 작성하기

## 중괄호가 있는 JSX 안에서 자바스크립트 사용하기

## 컴포넌트에 props 전달하기

## 조건부 렌더링

## 리스트 렌더링

## 컴포넌트 순수하게 유지하기

## 트리로서 UI 이해하기
