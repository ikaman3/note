# UI 표현하기

[https://ko.react.dev/learn/describing-the-ui](https://ko.react.dev/learn/describing-the-ui)  

리액트 앱은 *컴포넌트*라고 불리는 독립된 UI 조각들로 이루어진다.    
컴포넌트는 마크업을 얹을 수 있는 자바스크립트 함수이다.  
- 컴포넌트는 버튼처럼 작을 수도 있고 전체 페이지처럼 클 수도 있다.  

## 첫 번째 컴포넌트

### 컴포넌트: UI 구성 요소

웹에서는 HTML을 통해 태그를 사용하여 아래와 같은 문서를 만들 수 있다.  

```
<article>
  <h1>My First Component</h1>
  <ol>
    <li>Components: UI Building Blocks</li>
    <li>Defining a Component</li>
    <li>Using a Component</li>
  </ol>
</article>
```

마크업은 스타일을 위한 CSS, 상호작용을 위한 JavaScript와 결합하여 웹에서 볼 수 있는 모든 사이드바, 아바타, 모달, 드롭다운 등 모든 UI의 기반이 된다.  
  
React를 사용하면 마크업, CSS, JavaScript를 앱의 재사용 가능한 UI 요소인 사용자 정의 *“컴포넌트”*로 결합할 수 있다.  
위에서 본 목차 코드는 모든 페이지에 렌더링할 수 있는 ```<TableOfContents />``` 컴포넌트로 전환될 수 있다.  
내부적으로는 여전히 ```<article>```, ```<h1>``` 등과 같은 동일한 HTML태그를 사용한다.  
  
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

```export default``` 접두사는 [표준 JavaScript 구문](https://developer.mozilla.org/docs/web/javascript/reference/statements/export)이다.  

- 다른 파일에서 가져올 수 있도록 파일에 주요 기능을 표시할 수 있다.  
- 더 자세한 내용 : [컴포넌트 Importing 및 Exporting](https://ko.react.dev/learn/importing-and-exporting-components)  

#### 2단계: 함수 정의하기

```function Profile() {  }``` 을 사용하면 ```Profile``` 이라는 이름의 JavaScript 함수를 정의할 수 있다.  

- **주의사항**: React 컴포넌트는 일반 JavaScript 함수이지만, 이름은 대문자로 시작해야만 한다  

#### 3단계: 마크업 추가하기

위의 컴포넌트는 ```src``` 및 ```alt``` 속성을 가진 ```<img />``` 태그를 반환한다.  
```<img />``` 는 HTML처럼 보이지만 실제로는 JavaScript이다.  

- 이러한 구문을 [JSX](https://ko.react.dev/learn/writing-markup-with-jsx)라고 하며, JavaScript 안에 마크업을 삽입할 수 있다.  

반환문은 한 줄에 모두 작성해도 된다.  

- ```return <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />;```  

그러나 마크업이 ```return``` 키워드와 같은 라인에 있지 않다면 괄호로 묶어야 한다.  

```
return (
  <div>
    <img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />
  </div>
);
```

- **주의사항**: 괄호가 없으면 ```return``` 뒷 라인의 코드가 무시된다.
- [https://stackoverflow.com/questions/2846283/what-are-the-rules-for-javascripts-automatic-semicolon-insertion-asi](https://stackoverflow.com/questions/2846283/what-are-the-rules-for-javascripts-automatic-semicolon-insertion-asi)  

## 컴포넌트 import 및 export 하기

## JSX로 마크업 작성하기

## 중괄호가 있는 JSX 안에서 자바스크립트 사용하기

## 컴포넌트에 props 전달하기

## 조건부 렌더링

## 리스트 렌더링

## 컴포넌트 순수하게 유지하기

## 트리로서 UI 이해하기

