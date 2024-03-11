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

```javascript
// props 객체로 받아서 사용하는 방법
function Avatar(props) {
  return (
    <img
      className="avatar"
      src={getImageUrl(props.person)}
      alt={props.person.name}
      width={props.size}
      height={props.size}
    />
  );
}
// 구조 분해 할당 문법을 써서 각 변수로 나누어 사용하는 방법
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
    <Avatar person={{ name: "Lin Lanying", imageId: "1bX5QH6" }} size={100} />
  );
}
```

- `{ person, size }` : 구조 분해 할당(Destructuring assignment)
- 배열이나 객체의 속성을 해체하여 그 값을 개별 변수에 담는 자바스크립트의 문법이다.
- 아래의 코드와 논리적으로 동등하다.

```javascript
function Avatar(props) {
  let person = props.person;
  let size = props.size;
  // ...
}
```

## prop 기본값 지정

기본값은 자바스크립트의 문법이다.  
변수 바로 뒤에 `=` 과 함께 기본값을 넣어 구조 분해 할당할 수 있다.

```javascript
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

```javascript
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
이런 경우 _spread_ 문법을 사용하는 것이 합리적이다.

```javascript
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

```javascript
function Card({ children }) {
  return <div className="card">{children}</div>;
}

export default function Profile() {
  return <Card>'text'</Card>;
}
```

```javascript
<Card>
  <Avatar />
</Card>
```

- 여기에서는 `Card` 컴포넌트가 `<Avatar />`로 설정된 `children` prop을 받는다.
- 패널, 그리드 등의 시각적 래퍼에 종종 `children` prop을 사용한다.

자식과 props를 함께 전달할 수도 있다.

```javascript
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
</Card>;
```

## 시간에 따라 props가 변하는 방식

props는 항상 고정되어 있지 않다. props는 컴포넌트의 데이터를 처음에만 반영하는 것이 아니라 모든 시점에 반영한다.

그러나 props는 컴퓨터 과학에서 '변경할 수 없다'라는 의미의 불변성을 가진다.  
컴포넌트가 props를 변경해야 한다면, 부모 컴포넌트에 다른 props = 새로운 객체를 전달하도록 **요청**해야 한다.

- 이전의 props는 버려지고, 자바스크립트 엔진이 기존 props가 차지했던 메모리를 회수한다.
- props를 변경하지 마라. 사용자 입력에 반응해야 하는 경우는 'set state'를 사용한다.

## prop-types

런타임에 prop 타입을 검증하는 `prop-types` 패키지에 대한 내용  
PropTypes는 원래 React 코어 모듈의 일부로 노출되었으며, React 컴포넌트와 함께 일반적으로 사용된다.

```javascript
MyComponent.propTypes = {
  // 특정 JS 기본 자료형(primitive)
  optionalArray: PropTypes.array,
  optionalBigInt: PropTypes.bigint,
  optionalBool: PropTypes.bool,
  optionalFunc: PropTypes.func,
  optionalNumber: PropTypes.number,
  optionalObject: PropTypes.object,
  optionalString: PropTypes.string,
  optionalSymbol: PropTypes.symbol,

  // 렌더링할 수 있는 모든 것: 숫자, 문자열, 요소 또는 이러한 유형을 포함하는 배열 또는 Fragment
  // 자세한 정보 : https://reactjs.org/docs/rendering-elements.html
  optionalNode: PropTypes.node,

  // React element (예: `<MyComponent />`)
  optionalElement: PropTypes.element,

  // React element type (예: `MyComponent`)
  // 함수, 문자열 또는 "요소와 유사한" 객체 (예: React.Fragment, Suspense 등)
  // 자세한 정보 : https://github.com/facebook/react/blob/HEAD/packages/shared/isValidElementType.js
  optionalElementType: PropTypes.elementType,

  // prop이 클래스의 인스턴스인 것을 선언할 수도 있다. 이는 JS의 `instanceof` 연산자를 사용한다.
  optionalMessage: PropTypes.instanceOf(Message),

  // prop을 enum으로 취급하여 특정 값으로 제한할 수 있다.
  optionalEnum: PropTypes.oneOf(["News", "Photos"]),

  // 여러 유형 중 하나가 될 수 있는 객체
  optionalUnion: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number,
    PropTypes.instanceOf(Message),
  ]),

  // 특정 유형의 배열
  optionalArrayOf: PropTypes.arrayOf(PropTypes.number),

  // 특정 유형의 속성 값으로 구성된 객체
  optionalObjectOf: PropTypes.objectOf(PropTypes.number),

  // 위의 어떤 것이든 isRequired와 연결하여 prop이 제공되지 않은 경우 경고가 표시되도록 할 수 있다.

  // 특정 모양을 취하는 객체
  optionalObjectWithShape: PropTypes.shape({
    optionalProperty: PropTypes.string,
    requiredProperty: PropTypes.number.isRequired,
  }),

  // 추가 속성에 대한 경고가 있는 객체
  optionalObjectWithStrictShape: PropTypes.exact({
    optionalProperty: PropTypes.string,
    requiredProperty: PropTypes.number.isRequired,
  }),

  requiredFunc: PropTypes.func.isRequired,

  // 모든 데이터 타입의 값
  requiredAny: PropTypes.any.isRequired,

  // 사용자 정의 유효성 검사기(Custom validator)도 지정할 수 있다.
  // 유효성 검사가 실패하면 Error 객체를 반환해야 한다.
  // `console.warn`이나 `throw`를 사용하지 말 것.
  // 이는 `oneOfType` 내에서 작동하지 않는다.
  customProp: function (props, propName, componentName) {
    if (!/matchme/.test(props[propName])) {
      return new Error(
        "Invalid prop `" +
          propName +
          "` supplied to" +
          " `" +
          componentName +
          "`. Validation failed."
      );
    }
  },

  // `arrayOf` 및 `objectOf`에 사용자 정의 유효성 검사기를 제공할 수도 있다.
  // 유효성 검사가 실패하면 Error 객체를 반환해야 한다.
  // 유효성 검사기는 배열이나 객체의 각 키에 대해 호출된다.
  // 유효성 검사기의 첫 번째 인수는 배열이나 객체 자체이고, 두 번째 인수는 현재 항목의 key다.
  customArrayProp: PropTypes.arrayOf(function (
    propValue,
    key,
    componentName,
    location,
    propFullName
  ) {
    if (!/matchme/.test(propValue[key])) {
      return new Error(
        "Invalid prop `" +
          propFullName +
          "` supplied to" +
          " `" +
          componentName +
          "`. Validation failed."
      );
    }
  }),
};
```

- `isRequired` : 맨 끝에 붙여서 해당 prop이 필수임을 명시
- `optionalNumber: PropTypes.number` : 다른 많은 프로그래밍 언어와는 다르게, JavaScript는 정수와 실수를 별도의 타입으로 다루지 않는다. 다만 어떤 수가 정수인지, 혹은 실수인지를 판별할 수는 있고, 이를 위해 `Number.isInteger` 메소드를 사용한다.
- `optionalNode: PropTypes.node` : React 노드(Node) - React의 모든 요소(Elements)와 컴포넌트(Component)는 노드이다. 화면에 렌더링될 수 있는 숫자나 문자열과 같은 모든 **렌더링 가능한 값**
- `arrayOf(PropTypes.number)` : 배열 prop의 경우 배열 안에 어떤 타입의 원소가 들어올 수 있는지도 함께 명시한다.
- `any` : 렌더링 불가능한 값을 포함한 **모든 값**

[React documentation : Type checking with proptypes](https://facebook.github.io/react/docs/typechecking-with-proptypes.html)
