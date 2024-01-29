# react/syntax

# UI 표현하기

[https://ko.react.dev/learn/describing-the-ui](https://ko.react.dev/learn/describing-the-ui)  

리액트 앱은 *컴포넌트*라고 불리는 독립된 UI 조각들로 이루어진다.    
컴포넌트는 마크업을 얹을 수 있는 자바스크립트 함수이다.  
- 컴포넌트는 버튼처럼 작을 수도 있고 전체 페이지처럼 클 수도 있다.  

## 첫 번째 컴포넌트

### 컴포넌트: UI 구성 요소

웹에서는 HTML을 통해 태그를 사용하여 문서를 만들 수 있다.  
마크업은 스타일을 위한 CSS, 상호작용을 위한 JavaScript와 결합하여 웹에서 볼 수 있는 모든 사이드바, 아바타, 모달, 드롭다운 등 모든 UI의 기반이 된다.  
  
React를 사용하면 마크업, CSS, JavaScript를 앱의 재사용 가능한 UI 요소인 사용자 정의 *“컴포넌트”*로 결합할 수 있다.  
모든 페이지에 렌더링할 수 있는 <TableOfContents /> 컴포넌트로 전환될 수 있습니다. 내부적으로는 여전히 <article>, <h1> 등과 같은 동일한 HTML태그를 사용합니다.