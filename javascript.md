# JavaScript

자바스크립트 배운점 기록

## 객체 접근법

자바스크립트 객체의 속성 이름에 하이픈을 사용할 수 없었으나,  
ES6 이후에 객체 리터럴 내에서 문자열을 속성 이름으로 사용할 수 있는 방법이 있다.  
이를 통해 하이픈을 포함한 문자열을 속성 이름으로 사용할 수 있다.

그러나 하이픈이 포함된 문자열에 `.`으로 접근하려고 하면, 하이픈을 연산자로 인식하고 유효한 식별자가 아니므로 오류가 발생한다.  
따라서, 객체 속성 이름에 하이픈이 들어있다면 `[]`를 사용해서 접근해야 한다.

```javascript
// prettier-ignore
classes.header-background // -를 속성 이름이 아니라 연산자로 인식
classes["header-background"];
```

아래와 같은 객체가 정의되어 있을 때 접근법과 그 반환 값

```javascript
const classes = {
  "header-background": "header-background-class",
  "footer-background": "footer-background-class",
};

// classes['header-background'] = 'header-background-class'
// classes['footer-background'] = 'footer-background-class'
```
