# JavaScript

자바스크립트 배운거 기록

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

## Built in Classes

### `FileReader`

[MDN Reference](https://developer.mozilla.org/ko/docs/Web/API/FileReader)