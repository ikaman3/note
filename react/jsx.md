# JSX

JSX는 JavaScript를 사용하여 데이터와 논리를 구성할 수 있는 매우 작은 템플릿 언어이다.  

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

## JSX의 규칙

### 하나의 루트 엘리먼트로 반환하기  

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

### 모든 태그는 닫아주기  

JSX는 태그를 명시적으로 닫아야 한다.  
`<img>` 처럼 자체적으로 닫아주는 태그는 반드시 `<img />` 형태로 작성해야 하며,  
`<li>oranges` 같은 래핑 태그도 `<li>oranges</li>` 형태로 작성해야 한다.  

### 거의 대부분 카멜 케이스

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

## JSX 안에서 JS 사용하기

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

## 중괄호 안의 JSX로 하나의 객체 참조하기

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

## 이중 중괄호 사용하기 : JSX의 CSS와 다른 객체

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

## 조건부 렌더링

`<Item isPacked={true} />` 이러한 컴포넌트가 있을 때,  

```
if (isPacked) {
  return <li className="item">{name} ✔</li>;
}
return <li className="item">{name}</li>;
```

자바스크립트의 if/else 문으로 분기할 수 있다.  

### null 반환

컴포넌트는 반드시 무언가를 반환해야 하는데 아무것도 렌더링하고 싶지 않을 수 있다.  
이 경우에 `null`을 반환할 수 있다.  

```
if (isPacked) {
  return null;
}
return <li className="item">{name}</li>;
```

- 실제로 컴포넌트가 `null`을 반환하면 개발자가 렌더링하려고 할 때 놀랄 수 있으므로 흔한 경우는 아니다.  
- 또한, `<li>` 중복코드가 유지 보수를 어렵게 할 수 있다.  

### 삼항 조건 연산자

```
return (
    <li className="item">
        {isPacked ? name + ' ✔' : name}
    </li>
);

return (
    <li className="item">
        {isPacked ? (
        <del>
            {name + ' ✔'}
        </del>
        ) : (
            name
        )}
    </li>
);
```

[위의 예제](#조건부-렌더링)와의 차이는 전혀 없다.  

> 두 가지 다른 `<li>` 인스턴스를 만들 수 있으므로 미묘하게 다르다고 생각할 수 있으나  
> JSX 엘리먼트는 내부 상태를 보유하지 않으며 실제 DOM 노드가 아니므로 인스턴스가 아니다. 따라서 두 예시 코드는 *완전히 동일*하다.  
> 이 스타일은 간단한 조건에는 어울리지만, 중첩 마크업이 많다면 자식 컴포넌트를 추출하여 정리하라.  

### 논리 AND 연산자(`&&`)

자바스크립트의 `&&` 표현식을 사용

- 왼쪽(조건)이 `true`이면 오른쪽(체크 표시)의 값을 반환  
- 조건이 `false`이면 전체 표현식이 `false`  
- 리액트는 `false`를 `null` 또는 `undefined`처럼 JSX 트리의 구멍으로 간주하고 아무것도 렌더링하지 않음  

```
<li className="item">
    {name} {isPacked && '✔'}
</li>
```

- `isPacked`이면 '✔' 표시를 렌더링하고, 그렇지 않으면 아무것도 렌더링하지 않음  

**주의사항**  
> `&&` 왼쪽에 숫자를 두지 말 것  
> 자바스크립트는 왼쪽을 boolean으로 변환한다. 왼쪽이 `0`이면 전체 식이(`0`)을 얻고, 리액트는 `0`을 렌더링한다.  
> 흔한 실수: `messageCount && <p>New messages</p>`  
> 올바른 예시: `messageCount > 0 && <p>New messages</p>`  
>   > 왼쪽을 boolean으로 만들 것

### 변수에 조건부로 JSX를 할당

`if` 문과 변수를 사용해서 보기좋게 정리할 수 있다.  

```
let itemContent = name;
if (isPacked) {
    itemContent = name + " ✔";
}

<li className="item">
    {itemContent}
</li>
```

```
let itemContent = name;
if (isPacked) {
    itemContent = (
        <del>
            {name + " ✔"}
        </del>
    );
}
return (
    <li className="item">
        {itemContent}
    </li>
);
```

### 정보를 객체로 이동하여 조건을 완전히 제거하는 방법  

```
const drinks = {
    tea: {
        part: 'leaf',
        caffeine: '15–70 mg/cup',
        age: '4,000+ years'
    },
    coffee: {
        part: 'bean',
        caffeine: '80–185 mg/cup',
        age: '1,000+ years'
    }
};

function Drink({ name }) {
    const info = drinks[name];
    return (
        <section>
            <h1>{name}</h1>
            <dl>
                <dt>Part of plant</dt>
                <dd>{info.part}</dd>
                <dt>Caffeine content</dt>
                <dd>{info.caffeine}</dd>
                <dt>Age</dt>
                <dd>{info.age}</dd>
            </dl>
        </section>
    );
}
```

## 화살표 함수

### 암시적 반환

화살표 함수는 암시적으로 `=>` 바로 뒤에 식을 반환하기 때문에 `return` 문이 필요없다.  

```
const listItems = chemists.map(person =>
    <li>...</li> // 암시적 반환!
);
```

하지만 `=>` 뒤에 `{` 중괄호가 오는 경우 `return`을 명시적으로 작성해야 한다.  

```
const listItems = chemists.map(person => { // 중괄호
    return <li>...</li>;
});
```

중괄호를 가진 화살표 함수를 "block body"를 가지고 있다고 말한다.  
한 줄 이상의 코드를 작성할 수 있지만 `return` 문이 반드시 필요하다.  