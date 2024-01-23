# react/syntax
리액트를 학습하며 정리하는 마크다운 문서  

# 기본 개념

## Creating and nesting components
리액트 앱은 컴포넌트로 구성된다.  
- 컴포넌트 : 자체 로직과 외관을 가진 UI의 한 부분  

컴포넌트는 버튼처럼 작을 수도 있고, 전체 페이지처럼 크게 설계할 수도 있다.  
리액트 컴포넌트는 마크업을 반환하는 JavaScript 함수다.  
```
function MyButton() {
  return (
    <button>I'm a button</button>
  );
}
```
컴포넌트를 선언했다면, 다른 컴포넌트 안에 중첩할 수 있다.  
```
export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```  

리액트 컴포넌트는 대문자로 시작한다( MyButton /> )  
리액트 컴포넌트는 항상 대문자로 시작해야 하며, HTML 태그는 소문자여야 한다.
```
// App.js

function MyButton() {
  return (
    <button>
      I'm a button
    </button>
  );
}

export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```  
- ```export default``` : 파일에서 주요 컴포넌트를 지정한다.

## Writing markup with JSX 
위의 마크업 구문은 JSX라고 부른다.  
선택사항이긴 하지만 편의성을 위해 대부분의 리액트 프로젝트에서 JSX를 사용한다.  
로컬 개발을 위해 권장하는 모든 도구는 JSX를 기본으로 지원한다.  
  
JSX는 HTML 태그보다 엄격하다. \<br /\> 처럼 태그를 닫아야만 한다.  
또한 컴포넌트는 여러 JSX 태그를 반환할 수 없다.  
공통 부모인 \<div\>...\</div\>나 비어있는 <>...<> 래퍼로 감싸야 한다.  

