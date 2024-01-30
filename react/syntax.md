# 리액트 정리

[https://ko.react.dev/learn/describing-the-ui](https://ko.react.dev/learn/describing-the-ui)  
  
공식 문서를 보며 기초 개념과 필요한 문법을 정리해두는 문서  

## 컴포넌트

### 개념

리액트를 사용하면 마크업, CSS, 자바스크립트를 **앱의 재사용 가능한 UI 요소**인 사용자 정의 "컴포넌트"로 결합할 수 있다.  
내부적으로는 여전히 `<article>`, `<h1>` 등과 같은 동일한 HTML태그를 사용한다.  

리액트 앱은 컴포넌트로 구성되며, 컴포넌트란 '고유한 로직과 모양을 가진 UI의 일부'다.  
컴포넌트는 버튼만큼 작을 수도, 전체 페이지만큼 클 수도 있다.  

리액트 컴포넌트는 **마크업을 반환하는 자바스크립트 함수**다.  
  
리액트는 서로 관련이 있는 마크업(HTML)과 렌더링 로직(자바스크립트)을 함께 그룹화한다.  

- 버튼의 렌더링 로직과 버튼의 마크업이 함께 있으면, 매번 변화가 생길 때마다 서로 동기화 상태를 유지할 수 있다.  
- 반대로 버튼의 마크업과 사이드바의 마크업처럼 서로 관련이 없는 항목들은 서로 분리되어 있으므로, 각각 개별적으로 변경하는 것이 더 안전하다.  
  
선언한 컴포넌트는 다른 컴포넌트 안에 **중첩**할 수 있다.  

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

컴포넌트의 이름은 항상 **대문자**로 시작한다.  
  
컴포넌트는 여러 개의 JSX 태그를 반환할 수 없다.  
  
컴포넌트는 다른 컴포넌트를 렌더링할 수 있지만, 그 정의를 중첩해서는 안 된다.  

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

리액트 앱은 root 컴포넌트에서 시작한다. 보통 새 프로젝트를 시작할 때 자동으로 생성된다.  
  
예제의 컴포넌트들은 모두 `App.js`라는 **root 컴포넌트** 파일에 존재한다.  
설정에 따라 root 컴포넌트가 다른 파일에 위치할 수 있다.  
  
Next.js의 경우 root 컴포넌트는 `pages/index.js`에 정의된다.  
리액트 기반 프레임워크들은 리액트 컴포넌트에서 HTML을 자동으로 생성하기도 한다.  
이를 통해 자바스크립트 코드가 로드되기 전에 앱에서 일부 컨텐츠를 표시할 수 있다.  

### export, import

`export default` 접두사는 표준 자바스크립트 구문이다.  

컴포넌트는 세 단계를 거쳐 별도의 파일로 옮길 수 있다. 

1. 컴포넌트를 추가할 JS 파일을 생성
2. JS 파일에서 함수 컴포넌트를 export
3. 컴포넌트를 사용할 파일에서 import

export와 import 방법에는 각각 `default`와 `named export/import`가 있다.  
  
import에는 두 방법이 있는데 `.js` 확장자를 명시하는 전자가 native ES Modules 사용법에 가깝다.  

- `import Gallery from './Gallery.js';` OR
    `import Gallery from './Gallery';`  

default와 named export는 한 파일에서 사용할 수도 있다.

> 다만 한 파일에서는 하나의 default export만 존재할 수 있고  
> named export는 여러 개가 존재할 수 있다.  

export 방식에 따라 import 방식이 정해져 있다. default export한 값을 named import로 가져오려고 하면 **Error**가 발생한다.  

| Syntax | export 구문 | import 구문 |
| :---: | :--- | :--- |
| Default | `export default function Button() {}` |	`import Button from './button.js';` |
| Named | `export function Button() {}` | `import { Button } from './button.js';` |

default import를 사용하는 경우 원한다면 `import` 단어 후에 다른 이름으로 값을 가져올 수 있다. 이름이 달라도 같은 default export 값을 가져온다.  

- `import Banana from './button.js'`

반대로 named import는 양쪽 파일에서 사용하려는 값의 이름이 같아야 한다.  

> 보편적으로 한 파일에서 하나의 컴포넌트만 export 할 때 default export 방식을 사용하고 
> 여러 컴포넌트를 export 할 경우엔 named export 방식을 사용한다.  
> 어떤 방식을 사용하든 컴포넌트와 파일의 이름을 의미 있게 명명하는 것은 중요  
> `export default () => {}` 처럼 이름 없는 컴포넌트는 나중에 디버깅하기 어렵기 때문에 권장하지 않음  

## JSX

JSX는 JavaScript를 사용하여 데이터와 논리를 구성할 수 있는 매우 작은 템플릿 언어이다.  

### 개념

JSX와 React는 서로 다른 별개의 개념  
JSX는 확장된 문법이고, React는 JavaScript 라이브러리다.  
  
종종 함께 사용되기도 하지만 독립적으로 사용할 수도 있다.  
JSX는 선택사항이지만 대부분의 리액트 프로젝트는 JSX를 사용한다.  

```
<img src="https://i.imgur.com/MK3eW3As.jpg" alt="Katherine Johnson" />;
```

- `src` 및 `alt` 속성을 가진 `<img />` 태그  
- `<img />` 태그는 HTML처럼 생겼지만 실제로는 자바스크립트이다.  
- 이러한 구문을 JSX라고 하며, 자바스크립트 안에 마크업을 삽입할 수 있다.  

### JSX의 규칙

#### 하나의 루트 엘리먼트로 반환하기  

한 컴포넌트에서 여러 엘리먼트를 반환하려면, 하나의 부모 태그로 감싼다.  

컴포넌트가 JSX 태그를 반환할 때는 `return`과 같은 줄에 한 줄로 작성하거나,  괄호로 묶어야 한다.  

- 괄호가 없으면 `return` 뒷 라인의 모든 코드가 무시된다.  

```
<div>
    <h1>...</h1>
    <img
        ...
    >
    <ul>
        ...
    </ul>
</div>
```

`<div>`를 마크업에 추가하기 싫다면, 빈 태그(`<> </>`)로 대체할 수 있다.  
이러한 빈 태그는 *Fragment*라고 한다. Fragments는 브라우저상의 HTML 트리 구조에서 흔적없이 그룹화해 준다.  

```
<>
    <h1>...</h1>
    <img
        ...
    >
    <ul>
        ...
    </ul>
</>
```

> 왜 JSX 태그를 하나로 감싸야 하는가?  
> JSX는 HTML처럼 보이지만 내부적으로는 일반 자바스크립트 객체로 변환된다.  
> 하나의 배열로 감싸지 않은 하나의 함수에서는 두 개의 객체를 반환할 수 없다.  
> 따라서 또 다른 태그나 Fragment로 감싸지 않으면 두 개의 JSX 태그를 반환할 수 없다.  

#### 모든 태그는 닫아주기  

JSX는 태그를 명시적으로 닫아야 한다.  
`<img>` 처럼 자체적으로 닫아주는 태그는 반드시 `<img />` 형태로 작성해야 하며,  
`<li>oranges` 같은 래핑 태그도 `<li>oranges</li>` 형태로 작성해야 한다.  

#### 거의 대부분 카멜 케이스

JSX는 자바스크립트로 바뀌고 JSX에서 작성된 어트리뷰트는 자바스크립트 객체의 키가 된다.  
컴포넌트에서는 종종 어트리뷰트를 변수로 읽을 때가 있다.  
그러나 자바스크립트는 변수명에 제한이 있다.  

- 변수명에 대시를 포함하거나, `class` 처럼 예약어를 사용할 수 없다.  
  
이것이 리액트에서 HTML과 SVG의 어트리뷰트 대부분이 카멜 케이스로 작성되는 이유이다.  

- `stroke-width` --> `strokeWidth`
- `class` 는 예약어이므로 리액트에서는 DOM의 프로퍼티의 이름을 따서 `className` 으로 대신한다.  

```
<img
  src="https://i.imgur.com/yXOvdOSs.jpg"
  alt="Hedy Lamarr"
  className="photo"
/>
```

**주의사항**  
역사적인 이유로, `aria-*`와 `data-*`의 어트리뷰트는 HTML과 동일하게 대시(-)를 사용한다.  

### JSX 안에서 JS 사용하기

문자열 어트리뷰트를 JSX에 전달하려면 작은/큰 따옴표로 묶어야 한다.  
- `className="avatar"`, `src="https://i.imgur.com/7vQD0fPs.jpg"`  

이러한 문자열 값들을 동적으로 지정하려면 {}를 사용하여 자바스크립트의 값을 사용할 수 있다.  

```
export default function Avatar() {
  const avatar = 'https://i.imgur.com/7vQD0fPs.jpg';
  const description = 'Gregorio Y. Zara';
  return (
    <img
      className="avatar"
      src={avatar}
      alt={description}
    />
  );
}
```

JSX는 자바스크립트를 작성하는 특별한 방법이고, 중괄호 사이에서 자바스크립트를 사용할 수 있다.  
`formatDate()`와 같은 함수 호출을 포함해 모든 자바스크립트 표현식은 중괄호 사이에서 작동한다.  

```
const today = new Date();

function formatDate(date) {
  return new Intl.DateTimeFormat(
    'en-US',
    { weekday: 'long' }
  ).format(date);
}

export default function TodoList() {
  return (
    <h1>To Do List for {formatDate(today)}</h1>
  );
}
```

JSX 안에서 중괄호는 두 가지 방법으로만 사용할 수 있다.  

1. JSX 태그 안의 문자: `<h1>{name}'s To Do List</h1>` 는 작동하지만, 
`<{tag}>Gregorio Y. Zara's To Do List</{tag}>`는 작동하지 않는다.  
2. `=` 바로 뒤의 어트리뷰트: `src={avatar}`는 `avatar` 변수를 읽지만 `src="{avatar}"`는 `"{avatar}"` 문자열을 전달한다.  

### 중괄호 안의 JSX로 하나의 객체 참조하기

여러 표현식을 한 객체로 옮기고 중괄호 안의 JSX에서 참조할 수 있다.  

```
const person = {
    name: 'Gregorio Y. Zara',
    theme: {
        backgroundColor: 'black',
        color: 'pink'
    }
};
<div style={person.theme}>
    <h1>{person.name}'s Todos</h1>
</div>

# 자바스크립트 표현식을 사용한 URL 생성
src={baseUrl + person.imageId + person.imageSize + ".jpg"}
```

### 이중 중괄호 사용하기 : JSX의 CSS와 다른 객체

JSX는 문자열, 숫자 및 기타 자바스크립트 표현식뿐만 아니라 객체를 전달할 수 있다.  
또한 객체는 중괄호로 표시되는데, 따라서 JSX에서 객체를 전달하려면 `person={{ name: "Hedy Lamarr", inventions: 5 }}`와 같이 다른 중괄호 쌍으로 감싸야 한다.  
  
JSX에서 이중 중괄호는 자바스크립트 객체에 불과하다는 것을 명심하자.  

JSX의 인라인 CSS 스타일에서도 이중 중괄호를 사용한다. 리액트에서 인라인 스타일을 사용할 필요가 없이 CSS 클래스는 대부분 잘 작동한다.  
인라인 스타일이 필요하면 `style` 어트리뷰트에 객체로 전달한다.  

- 인라인 `style` 프로퍼티는 HTML과 다르게 카멜 케이스로 작성하는 것에 주의  

```
<ul style={{
      backgroundColor: 'black',
      color: 'pink'
    }}>
        ...
</ul>
```

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

```use``` 로 시작하는 함수를 *Hooks*라고 하며, ```useState``` 는 리액트에서 제공하는 내장 Hook이다.  
Hooks는 다른 함수보다 더 제한적이다. 컴포넌트(또는 다른 Hooks)의 상단에서만 Hooks를 호출할 수 있다.  

## props

### 개념

*props*란?

- 자식 컴포넌트에 JSX 중괄호를 사용해서 전달하는 정보  
- JSX 태그에 전달하는 정보  
- 객체, 배열, 함수를 포함한 모든 자바스크립트 값을 props로 전달할 수 있다.  
- props를 사용하여 부모와 자식 컴포넌트를 독립적으로 생각할 수 있다.  
- props는 컴포넌트에 대한 유일한 인자다 = 리액트 컴포넌트 함수는 props 객체만을 인자로 받는다.  

이미 JSX 태그에 props를 전달하여 사용하고 있었다.  

- `<img>` 태그 등에 전달할 수 있는 props는 미리 정의되어 있다.  

직접 생성한 컴포넌트에도 props를 전달할 수 있다.  

```
function Avatar({ person, size }) {
    return (
        <img
        className="avatar"
        src={getImageUrl(person)}
        alt={person.name}
        width={size}
        height={size}
        />
    );
}

export default function Profile() {
    return (
        <Avatar
            person={{ name: 'Lin Lanying', imageId: '1bX5QH6' }}
            size={100}
        />
    );
}
```

- `{ person, size }` : 구조 분해 할당(Destructuring assignment)  
- 배열이나 객체의 속성을 해체하여 그 값을 개별 변수에 담는 자바스크립트의 문법이다.  
- 아래의 코드와 논리적으로 동등하다.  

```
function Avatar(props) {
    let person = props.person;
    let size = props.size;
    // ...
}
```

### prop 기본값 지정

기본값은 자바스크립트의 문법이다.  
변수 바로 뒤에 `=` 과 함께 기본값을 넣어 구조 분해 할당할 수 있다.  

```
function Avatar({ person, size = 100 }) {
    // ...
}
```

- 이제 `<Avatar person={...} />`가 `size` prop 없이 렌더링 된다면, `size`는 `100`으로 설정된다.  

기본값은 해당 prop이 존재하지 않거나, `undefined`로 전달될 때 사용된다.  
`null` 또는 `0`으로 전달되면 기본값는 사용되지 **않는다.**  

- 기본값이 적용됨 : `size` 없음, `size={undefined}`  
- 기본값이 적용되지 않음 : `size={null}`, `size={0}`

### spread 문법으로 props 전달

아래와 같이 props를 반복적으로 전달할 때가 있다.  

```
function Profile({ person, size, isSepia, thickBorder }) {
    return (
        <div className="card">
        <Avatar
            person={person}
            size={size}
            isSepia={isSepia}
            thickBorder={thickBorder}
        />
        </div>
    );
}
```

반복적인 코드는 가독성을 높일 수 있다는 점에서 잘못된 것은 아니지만, 간결함이 중요할 때도 있다.  
위에서 `Profile`은 props를 직접 사용하지 않고 자식 컴포넌트에 전달만 한다.  
이런 경우 *spread* 문법을 사용하는 것이 합리적이다.  

```
function Profile(props) {
    return (
        <div className="card">
        <Avatar {...props} />
        </div>
    );
}
```

단, spread 문법은 제한적으로 사용할 것.  
다른 모든 컴포넌트에 이 구문을 사용한다면,  
컴포넌트를 분할하여 자식을 JSX로 전달해야 함을 나타낸다.  

### 자식을 JSX로 전달

자체 컴포넌트를 중첩할 수 있다.  
JSX 태그 내에 콘텐츠를 중첩하면, 부모 컴포넌트는 해당 콘텐츠를 prop으로 받는다.  
예를 들어 아래의 `Card` 컴포넌트는 `text`로 설정된 `children` prop을 받아서 래퍼 div에 렌더링한다.  

```
function Card({ children }) {
    return (
        <div className="card">
            {children}
        </div>
    );
}

export default function Profile() {
    return (
        <Card>
            'text'
        </Card>
    );
}
```

```
<Card>
    <Avatar />
</Card>
```

- 여기에서는 `Card` 컴포넌트가 `<Avatar />`로 설정된 `children` prop을 받는다.  
- 패널, 그리드 등의 시각적 래퍼에 종종 `children` prop을 사용한다.  

### 시간에 따라 props가 변하는 방식

props는 항상 고정되어 있지 않다. props는 컴포넌트의 데이터를 처음에만 반영하는 것이 아니라 모든 시점에 반영한다.  
  
그러나 props는 컴퓨터 과학에서 '변경할 수 없다'라는 의미의 불변성을 가진다.  
컴포넌트가 props를 변경해야 한다면, 부모 컴포넌트에 다른 props = 새로운 객체를 전달하도록 **요청**해야 한다.  

- 이전의 props는 버려지고, 자바스크립트 엔진이 기존 props가 차지했던 메모리를 회수한다.  
- props를 변경하지 마라. 사용자 입력에 반응해야 하는 경우는 'set state'를 사용한다.  