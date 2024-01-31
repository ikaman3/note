# props

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

## prop 기본값 지정

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

## spread 문법으로 props 전달

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

## 자식을 JSX로 전달

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

자식과 props를 함께 전달할 수도 있다.  

```
function Card({ children, title }) {
  return (
    <div className="card">
      <div className="card-content">
        <h1>{title}</h1>
        {children}
      </div>
    </div>
  );
}

<Card title="About">
    <p>...</p>
</Card>
```

## 시간에 따라 props가 변하는 방식

props는 항상 고정되어 있지 않다. props는 컴포넌트의 데이터를 처음에만 반영하는 것이 아니라 모든 시점에 반영한다.  
  
그러나 props는 컴퓨터 과학에서 '변경할 수 없다'라는 의미의 불변성을 가진다.  
컴포넌트가 props를 변경해야 한다면, 부모 컴포넌트에 다른 props = 새로운 객체를 전달하도록 **요청**해야 한다.  

- 이전의 props는 버려지고, 자바스크립트 엔진이 기존 props가 차지했던 메모리를 회수한다.  
- props를 변경하지 마라. 사용자 입력에 반응해야 하는 경우는 'set state'를 사용한다.  