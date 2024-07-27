# JavaScript

자바스크립트 정보 기록

## 연산

### Unary plus operator

단항 더하기(`+`)는 피연산자 앞에 위치하며 피연산자를 평가하지만, 만약 피연산자가 숫자가 아니라면 숫자로 변환을 시도한다.  
단항 부정(`-`)도 숫자가 아닌 값을 변환할 수 있지만, 숫자에 다른 연산을 수행하지 않기 때문에 단항 더하기는 어떤 것을 숫자로 변환하는 가장 빠르고 선호하는 방법이다.

```javascript
const x = 1;
const y = -1;

console.log(+x);
// Expected output: 1

console.log(+y);
// Expected output: -1

console.log(+"");
// Expected output: 0

console.log(+true);
// Expected output: 1

console.log(+false);
// Expected output: 0

console.log(+"hello");
// Expected output: NaN
```

> `parseInt()`와의 차이점
>
> - 단항 더하기는 소수도 그대로 변환하지만 `parseInt()`는 정수로 바꾼다.
> - `parseInt()`는 문자열에서 숫자를 파싱하며 문자열을 걸러내지만 단항 더하기는 모든 입력을 거름 없이 받아들인다. 따라서 `parseInt("5개")`를 하면 `5`를 반환하지만 `+"5개"`를 하면 `NaN`을 반환한다.

## 문자열

### `replace`

문자열을 치환하는 메서드

```javascript
topic.body.replace(/\n/g, "<br>");
```

### `startsWith()`

String.prototype.startsWith()  
어떤 문자열의 문자로 시작하는지 확인하여 결과를 적절하게 `true` 혹은 `false`로 반환하는 메서드  
대소문자를 구분한다.

```javascript
startsWith(searchString);
startsWith(searchString, position);
```

```javascript
const str1 = "Saturday night plans";

console.log(str1.startsWith("Sat"));
// Expected output: true

console.log(str1.startsWith("Sat", 3));
// Expected output: false
```

- `searchString`: 이 문자열의 시작 부분에서 검색할 문자. 정규식이 될 수 없다. 정규식이 아닌 모든 값은 문자열로 강제로 변환되므로 이를 생략하거나 `undefined`를 전달하면 `startsWith()`가 `"undefined"` 문자열을 검색하게 되는데, 이는 원하는 경우가 거의 없다.
- `position`: `searchString`이 발견될 것으로 예상되는 시작 위치(`searchString`의 첫 번째 문자의 인덱스)다. 기본값은 `0`

## 템플릿 리터럴

ES6 이전에는 템플릿 문자열이라고 불렀던 문법이며 ES6에서 개선되었다.  
내장된 표현식을 허용하는 문자열 리터럴로 표현식/문자열 삽입, 여러 줄 문자열, 문자열 형식화, 문자열 태깅 등 다양한 기능을 제공한다.

### 문자열 삽입

ES6 이전

```javascript
let name = "Ikaman";
let greeting = "Hello my name is " + name;
console.log(greeting); // Hello my name is Ikaman
```

ES6 이후

```javascript
let name = "Ikaman";
const greeting = "Hello my name is ${name}";
console.log(greeting); // Hello my name is Ikaman
```

### 표현식 삽입

ES6 이전

```javascript
let a = 1;
let b = 10;
console.log("1 * 10 is " + a * b); // 1 * 10 is 10
```

ES6 이후

```javascript
let a = 1;
let b = 10;
console.log(`1 * 10 is ${a * b}`); // 1 * 10 is 10
```

### 여러 줄 문자열 생성

ES6 이전

```javascript
let text =
  "Hello, \
my name is Alberto \
how are you?  ";
```

ES6 이후

```javascript
let text = `Hello, 
my name is Alberto 
how are you?`;
```

### 중첩 템플릿

```javascript
const people = [
  {
    name: "Ikaman 1",
    age: 27,
  },
  {
    name: "Ikaman 2",
    age: 28,
  },
  {
    name: "Ikaman 3",
    age: 29,
  },
];

const markup = `
<ul>
	${people.map((person) => `<li>  ${person.name}  </li>`)}
</ul>
`;
console.log(markup);

// <ul>
//   <li> Ikaman 1 </li>,<li> Ikaman 2 </li>, <li> Ikaman 3 </li>
// </ul>
```

- `map` 함수를 이용하여 `people`의 각 원소에 대해 반복 동작을 수행하고 `people` 내에 있는 `name`을 담아 `li` 태그를 표시하였다.

### 삼항 연산자 추가

삼항 연산자 기본 문법

```javascript
const isDiscounted = false;
function getPrice() {
  console.log(isDiscounted ? "$10" : "$20");
}
getPrice(); // $20
```

템플릿 리터럴과 삼항 연산자 응용

```javascript
// name, age와 함께 artist 객체 생성
const artist = {
  name: "Ikaman",
  age: 27,
};
// artist 객체에 song 프로퍼티가 있을 때만 문장에 추가하고,
// 없으면 아무것도 반환하지 않는다.
const text = `
	<div>
	  <p> ${artist.name} is ${artist.age} years old ${
  artist.song ? `and wrote song ${artist.song}` : ""
}
	  </p>
	</div>
`;
// <div>
//   <p> Ikaman is 27 years old
//   </p>
// </div>
const artist = {
  name: "Ikaman",
  age: 27,
  song: "Love",
};
// <div>
//   <p> Ikaman is 27 years old and wrote the song Love
//   </p>
// </div>
```

### 템플릿 리터럴에 함수 전달

필요할 때 템플릿 리터럴 내에 함수를 전달할 수도 있다. (`${groceriesList(groceries.others)}` 부분)

```javascript
const groceries = {
  meat: "pork chop",
  beggie: "salad",
  fruit: "apple",
  others: ["mushrooms", "instant noodles", "instant soup"],
};
// groceries의 각 값에 대해 map()을 수행하는 함수
function groceryList(others) {
  return `
	<p>
	  ${toehrs.map((other) => ` <span>${other}</span>`).join("\n")}
	</p>
  `;
}
// p 태그 내 모든 groceries를 출력. 마지막은 others 배열의 모든 원소를 포함한다.
const markup = `
	<div>
	  <p>${groceries.meat}</p>
	  <p>${groceries.veggie}</p>
	  <p>${groceries.fruit}</p>
	  <p>${groceryList(groceries.others)}</p>
	</div>
`;
//  <div>
//	  <p>pork chop</p>
//	  <p>salad</p>
//	  <p>apple</p>
//	  <p>
//	     <p>
//		<span>mushrooms</span>
//		<span>instant noodles</span>
//		<span>instant soup</span>
//	     <p>
//	  <p>
//  </div>
```

- 마지막 `p` 태그에서 함수 `groceryList`를 호출해 다른 모든 `others`를 인수로 전달했다.

### 태그된 템플릿 리터럴

함수를 태그하여 템플릿 리터럴을 실행하면 템플릿 내부에 있는 모든 항목이 태그된 함수의 인수로 제공된다.

```javascript
let person = "Ikaman";
let age = 27;

function myTag(strings, personName, personAge) {
  // strings: ["That ", " is a ", "!"]
  let str = string[1]; // " is a "
  let ageStr;

  personAge > 50 ? (ageStr = "grandpa") : (ageStr = "youngster");
  return personName + str + ageStr;
}

let sentence = myTag`That ${person} is a ${age}!`;
console.log(sentence); // Ikaman is a youngster
```

- 예제에서 `myTag` 함수의 첫번째 인수 `strings`는 `let sentence` 문의 전체 문자열 중 템플릿 리터럴 변수를 제외한 문자열들이 담긴 배열로 설정되고 템플릿 리터럴 변수들이 나머지 인수가 된다.
- 좀 풀어서 설명하자면 `strings` 배열의 각 원소는 템플릿 리터럴에 포함된 변수들을 구분자로 삼아 문자열을 나눈 결과와 같다.
  - 즉 문자열은 `That`, `${person}`, `is a`, `${age}`, `!` 이렇게 5가지 부분으로 나뉘므로 변수를 제외한 `["That", " is a ", "!"]` 가 `strings`가 되는 것이다.
  - 이에 대한 값은 배열 표기법을 사용해 중간에 있는 문자열에 접근할 수 도 있다.

```javascript
let str = strings[1]; // " is a "
```

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

## console

### 객체가 동일한지 비교

아래와 같이 비교하길 원하는 객체를 콘솔에 출력하고 브라우저 콘솔에서 해당 로그를 우클릭한다.  
'store object as global variable' 버튼을 눌러 전역 변수로 저장하고 `Object.is()` 메서드를 사용해서 비교한다.

```javascript
const visibleTodos = useMemo(() => filterTodos(todos, tab), [todos, tab]);
console.log([todos, tab]);

// 브라우저 콘솔
Object.is(temp1[0], temp2[0]);
```

### 실행 시간 측정

`console.time('name')`, `console.timeEnd('name')`를 사용

```javascript
console.time("filter array");
const visibleTodos = filterTodos(todos, tab);
console.timeEnd("filter array");
```

## export

### 선언부 앞에 export 붙이기

```javascript
// 배열 내보내기
export let months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

// 상수 내보내기
export const MODULES_BECAME_STANDARD_YEAR = 2015;

// 클래스 내보내기
export class User {
  constructor(name) {
    this.name = name;
  }
}
```

### 선언부와 떨어진 곳에 export 붙이기

```javascript
// 📁 say.js
function sayHi(user) {
  alert(`Hello, ${user}!`);
}

function sayBye(user) {
  alert(`Bye, ${user}!`);
}

export { sayHi, sayBye }; // 두 함수를 내보냄
```

`export`문을 함수 선언부 위에 적어주는 것도 동일하게 동작한다.

### as

export에도 `as`를 사용할 수 있다.

```javascript
// 📁 say.js
...
export {sayHi as hi, sayBye as bye};
```

이제 다른 모듈에서 이 함수들을 가져올 때 이름은 `hi`와 `bye`가 된다.

```javascript
// 📁 main.js
import * as say from "./say.js";

say.hi("John"); // Hello, John!
say.bye("John"); // Bye, John!
```

## import

```javascript
// 📁 main.js
import { sayHi, sayBye } from "./say.js";

sayHi("John"); // Hello, John!
sayBye("John"); // Bye, John!
```

가져올 것이 많으면 `import * as <obj>` 처럼 객체 형태로 원하는 것들을 가지고 올 수 있다.

```javascript
// 📁 main.js
import * as say from "./say.js";

say.sayHi("John");
say.sayBye("John");
```

이렇게 '한꺼번에 모든 걸 가져오는 방식’을 사용하면 코드가 짧아진다. 그런데도 어떤 걸 가져올 땐 그 대상을 구체적으로 명시하는 게 좋다.

1. 웹팩(webpack)과 같은 모던 빌드 툴은 로딩 속도를 높이기 위해 모듈들을 한데 모으는 번들링과 최적화를 수행한다. 이 과정에서 사용하지 않는 리소스가 삭제되기도 한다.  
   아래와 같이 프로젝트에 서드파티 라이브러리인 `say.js`를 도입하였다 가정한다. 이 라이브러리엔 수 많은 함수가 있다.

```javascript
// 📁 say.js
export function sayHi() { ... }
export function sayBye() { ... }
export function becomeSilent() { ... }
```

현재로선 `say.js`의 수 많은 함수 중 단 하나만 필요하기 때문에, 이 함수만 가져와 본다.

```javascript
// 📁 main.js
import { sayHi } from "./say.js";
```

빌드 툴은 실제 사용되는 함수가 무엇인지 파악해, 그렇지 않은 함수는 최종 번들링 결과물에 포함하지 않는다. 이 과정에서 불필요한 코드가 제거되기 때문에 빌드 결과물의 크기가 작아진다.  
이런 최적화 과정은 '가지치기(tree-shaking)'라고 부른다.

2. 어떤 걸 가지고 올지 명시하면 이름을 간결하게 써줄 수 있다. `say.sayHi()`보다 `sayHi()`가 더 간결하다.
3. 어디서 어떤 게 쓰이는지 명확하기 때문에 코드 구조를 파악하기가 쉬워 리팩토링이나 유지보수에 도움이 된다.

### as

`as`를 사용하면 이름을 바꿔서 모듈을 가져올 수 있다.

```javascript
// 📁 main.js
import { sayHi as hi, sayBye as bye } from "./say.js";

hi("John"); // Hello, John!
bye("John"); // Bye, John!
```

## Utils

### 의도적으로 딜레이 주는 방법

일반적으로 `setTimeout()` 함수에 콜백이나 `then` 체인을 사용하지만 가독성이 좋지 않다.  
대신 Promise를 래핑해서 async/await 구문을 이용할 수 있다.

```javascript
async function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
```

### 객체가 비었는지 확인하는 방법

객체 프로퍼티를 대상으로 반복문을 실행하다가 프로퍼티가 하나라도 있으면 그 즉시 `false`를 반환하게 코드를 작성

```javascript
function isEmpty(obj) {
  for (let key in obj) {
    // if the loop has started, there is a property
    return false;
  }
  return true;
}
```
