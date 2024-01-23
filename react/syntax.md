# react/syntax
리액트를 학습하며 정리하는 마크다운 문서  

# 기본 개념
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
