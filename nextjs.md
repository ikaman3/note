# Next.js

Udemy 강의 및 공식문서, 구글링하며 정리하는 문서

## NextJS는 무엇이고 왜 사용하는가

NextJS: 리액트 프레임워크 = 리액트에 빌드됨

왜 필요한가?

- NextJS는 풀스택 리액트 프레임워크이므로 리액트로 풀스택 앱 구축 과정을 단순화함
- 최근 몇 달에서 몇 년 동안 클라이언트 측 SPA이 아닌 풀스택 앱을 구축하는 추세가 됨으로써 리액트 라이브러리 자체도 서버에서 사용을 쉽게하기 위해 기능을 추가하고 있다. 특히 서버에서 컴포넌트 렌더링 가능하게 하고 있다.(= Server Component)
- 그러나 풀스택 앱에는 양식 제출 처리, 데이터 가져오기, 사용자 인증 등 많은 것들이 필요하고 NextJS가 이것을 제공한다.

## NextJS의 기능과 장점

Fullstack Apps

- 데이터를 가져오고 렌더링하는 것이 효율적
- 양식 제출 처리가 쉽고 안전
- 파일 시스템을 사용하여 경로 설정 가능

File-based Routing

- 파일 시스템을 사용하여 경로 설정 가능
- 폴더와 파일을 설치하여 사용자가 방문할 수 있는 경로로 매핑
- 코드 기반 환경설정 또는 패키지가 불필요, 대신 NextJS에 내장됨

Server-side Rendering

- 페이지에 보이는 모든 내용을 렌더링
- 검색 엔진 크롤러도 완성된 콘텐츠(HTML Markup)를 볼 수 있음(SEO 유리)

## 프로젝트 생성

`npx create-next-app@latest`  
 간단하게 새 프로젝트를 생성할 수 있다.  
 Node.js를 내부적으로 사용하므로 먼저 설치되어 있어야 한다.

설치 옵션

- TypeScript: No
- ESLint: Yes
- Tailwind: Yes
- 다른 폴더 구성(`src/`): Yes
- App Router 사용 여부: Yes
- import alias: No

프로젝트 폴더로 이동하여 `npm run dev`를 실행하면 개발 서버가 시작되고, `localhost:3000`에서 확인할 수 있다.

## 시작하기 전에

`app` 폴더안에 `awesome` 폴더와 그 폴더 안에 `page.js` 파일을 추가한다.

- NextJS는 이 `app` 폴더를 검사하여 설치가 필요한 경로를 탐지한다.
- 파일의 이름은 꼭 `page.js`이어야 함
  - 폴더명과 파일 이름이 합쳐져 신규 경로가 생성된다.(awesome - page)

`page.js` 파일에서 리액트 컴포넌트 함수를 `default`로 export 한다.

- NextJS에서 페이지는 단순한 리액트 함수다.
- 이때 컴포넌트 이름은 상관없다.

`localhost:3000/awesome`으로 방문하면 새로운 페이지 내용이 보인다.

- 소스코드를 검사해보면 리액트(CSR)와는 다르게 모든 내용이 존재한다.

## 배포

```bash
# 배포할 소스 빌드
npm run build
# 빌드한 소스를 실행
npm run start
```

`.next`: 빌드되어 Client에게 response할 내용이 있는 폴더

- 소스코드를 수정했는데 오류가 있거나 반영이 되지 않는다면 해당 폴더를 지우고 다시 빌드할 것

## 폴더 구조

### App router의 routing

Next.js 13에서 추가된 App router는 폴더내에 `page.js` 또는 `page.jsx` 파일을 작성했을 때 해당 폴더의 이름으로 route 된다.

- 페이지들이 다른 폴더(페이지가 아닌)와 같은 depth에 위치하여 어떤 폴더가 페이지인지 구별하기 어려울 수 있다.
- 원치않는 폴더의 route가 생성될 수 있다.

### Route group

`(name)`  
route가 될 수 있는 페이지들을 하나의 그룹으로 묶는다.
route를 구분하기 위해 사용할 수도 있고 각각의 도메인에 맞게(admin, shop 등) 그룹을 나눌 수도 있다.

### Private folder

`_folder`  
해당 폴더는 route가 생성되지 않는다.

### (Option) material icon theme custom

VSCode의 Plugin인 `material icon theme`을 사용하는 중에  
폴더 이름에 `_`를 붙이면서 아이콘의 색이 모두 회색으로 되어버렸다.
VSCode에서 extension을 설정할 수 있는 `settings.json`을 수정한다.

`.vscode` 폴더를 생성하고 그 안에 `settings.json` 파일을 만들어서  
해당 프로젝트의 모두가 동일한 설정을 적용할 수 있다.

- 로컬의 파일을 수정하면 해당 PC에서만 설정이 적용된다.

```json
// setting.json
{
  "material-icon-theme.folders.associations": {
    // "적용할 폴더 이름": "적용할 아이콘"
    "_components": "Components",
    "_constants": "Constant",
    "_hooks": "Hook",
    "_service": "Api",
    "_store": "Container",
    "_types": "Typescript",
    "_utils": "Utils",
    "(route)": "Routes"
  }
}
```

## Linting

ESLint를 사용하며 발생한 error와 그 해결법 기록

### Failed to load config "next" to extend from.

`npm rum lint`를 실행했을 때 발생한 error  
Next.js 프로젝트의 기반이 되는 기본 설정인 `eslint-config-next` 패키지를 설치해야 한다.  
설치 후 `.exlintrc.json` 파일의 `extends`에 `"next"`를 넣는다.

```bash
npm install --save-dev eslint-config-next
```

### Error: JSX props should not use functions react/jsx-no-bind

[rule: jsx-no-bind](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/jsx-no-bind.md)
[solution](https://stackoverflow.com/questions/36677733/why-shouldnt-jsx-props-use-arrow-functions-or-bind)

인라인 화살표 함수를 JSX props에서 사용하지 말아야 하는 이유:  
JSX에서 화살표 함수나 binding을 사용하는 것은 성능을 저하시키는 나쁜 습관이다. 왜냐하면 함수가 각 렌더링마다 다시 생성되기 때문이다.

1. 함수가 생성될 때마다 이전 함수는 가비지 컬렉션이 된다. 많은 요소를 다시 렌더링하는 것은 애니메이션에서 끊김을 유발할 수 있다.
2. 인라인 화살표 함수를 사용하면 `PureComponents` 및 `shouldComponentUpdate` 메서드에서 `shallowCompare`를 사용하는 컴포넌트가 어쨌든 다시 렌더링된다.

#### 클래스 컴포넌트의 경우

화살표 함수 prop이 매번 재생성되기 때문에 `shallow compare`가 prop의 변경으로 인식하고 컴포넌트가 다시 렌더링된다.  
다음 두 예제에서 확인할 수 있듯이, 인라인 화살표 함수를 사용할 때마다 `<Button>` 컴포넌트가 다시 렌더링된다(콘솔에 'render button' 텍스트가 표시됨).

#### 함수 컴포넌트의 경우

함수 컴포넌트 안에서 내부 함수(예: 이벤트 핸들러)를 만들 때, 컴포넌트가 렌더링될 때마다 함수가 다시 생성된다. 함수가 props로 전달되거나(또는 컨텍스트를 통해 전달되는 경우) 자식 컴포넌트(밑의 예제에서 `Button`인 경우)로 전달되면 해당 자식도 다시 렌더링됩니다.

Example 1 - Function Component with an inner callback: 잘못된 방법

```javascript
const { memo, useState } = React;

const Button = memo(
  ({ onClick }) =>
    console.log("render button") || <button onClick={onClick}>Click</button>
);

const Parent = () => {
  const [counter, setCounter] = useState(0);

  const increment = () => setCounter((counter) => counter + 1); // the function is recreated all the time

  return (
    <div>
      <Button onClick={increment} />

      <div>{counter}</div>
    </div>
  );
};

ReactDOM.render(<Parent />, document.getElementById("root"));
```

이 문제를 해결하기 위해 `useCallback()` 훅으로 callback을 감싸고 의존성을 빈 배열로 설정할 수 있다.  
이 hook은 의존성 중 하나가 변경될 때만 변경되는 함수의 메모라이즈된 버전을 반환한다.

- 참고: `useState`에서 생성된 함수는 현재 상태를 제공하는 업데이터 함수를 받는다. 이렇게 함으로써, `useCallback`의 현재 상태를 의존성으로 설정할 필요가 없다.

Example 2 - Function Component with an inner callback wrapped **with `useCallback`**: 올바른 방법

```javascript
const { memo, useState, useCallback } = React;

const Button = memo(
  ({ onClick }) =>
    console.log("render button") || <button onClick={onClick}>Click</button>
);

const Parent = () => {
  const [counter, setCounter] = useState(0);

  const increment = useCallback(() => setCounter((counter) => counter + 1), []);

  return (
    <div>
      <Button onClick={increment} />

      <div>{counter}</div>
    </div>
  );
};

ReactDOM.render(<Parent />, document.getElementById("root"));
```

이렇게하면 `increment`가 의존성이 변경될 때만 다시 정의되므로 불필요한 다시 렌더링이 방지된다.

### 'prop-types' should be listed in the project's dependencies, not devDependencies import/no-extraneous-dependencies

`prop-types` 패키지는 배포될 production에서 필요하다.  
개발 버전이 아니라 배포 버전에 의존성을 설치한다.

- `dependencies`에서 필요한 이유 : [Runtime에 타입을 검증](https://github.com/facebook/prop-types)하기 때문이다.
- 리액트 공식문서에서는 런타임에 props 타입을 검증하는 것보다 [TypeScript를 사용하는 것을 권장](https://react.dev/reference/react/Component#static-proptypes)하고 있다.

```bash
npm install --save prop-types
# npm 5 버전부터 --save 옵션은 기본값이므로 생략 가능
npm install prop-types
```

```json
{
  "name": "your-website",
  ...
  "dependencies": {
    "react": "^16.10.2",
    "react-dom": "^16.10.2",
    "webpack": "^4.44.1",
    "prop-types": "^15.7.2",
    ...
  },
  "devDependencies": {
    "@types/node": "^14.0.18",
    ...
  },
}
```

### Error: 'foo' is missing in props validation react/prop-types

[rule: prop-types rule](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/prop-types.md)

[prop-types npm](https://www.npmjs.com/package/prop-types)

[prop-types github](https://github.com/facebook/prop-types)

`prop-types` 패키지를 import하고, 컴포넌트의 props의 타입을 검증해야 한다.

- prop-types에 대한 자세한 설명은 [react/props.md](https://github.com/ikaman3/note/blob/main/react/props.md#prop-types) 참조

`import PropTypes from 'prop-types'`

```javascript
export default function Controller({
  buttonNumbers = [-1, -10, -100, 100, 10, 1],
  onCountChange,
}) {
  return (
    ...
  )
}

Controller.propTypes = {
  buttonNumbers: PropTypes.arrayOf(PropTypes.number).isRequired,
  onCountChange: PropTypes.func,
}
```

### Error: propType "name" is not required, but has no corresponding defaultProps declaration. react/require-default-props

[rule: require-default-props](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/require-default-props.md)

[이 규칙을 꺼야하는 이유](https://stackoverflow.com/questions/64012257/proptype-name-is-not-required-but-has-no-corresponding-defaultprops-declarati)

이 규칙은 `defaultProps`를 사용하여 에러를 해결할 수 있다.  
그러나 함수 컴포넌트에 `defaultProps`를 사용하는 것은 추후 릴리즈에서 중지될 것이므로 사용하지 않는 것이 좋다.  
대신 JavaScript default parameter를 사용하자.

```json
"rules": {
  "react/require-default-props": "off"
}
```

#### Warning: Controller: Support for defaultProps will be removed from function components in a future major release. Use JavaScript default parameters instead.

이 경고 메시지는 Next.js의 future major release에서 function 컴포넌트에서의 defaultProps 지원이 제거될 것임을 알려주고 있다. 이것은 현재 사용하고 있는 컴포넌트에서 defaultProps를 사용하고 있다는 의미다.

경고를 해결하기 위한 방법은 해당 컴포넌트에서 defaultProps 대신에 JavaScript의 default parameters를 사용하는 것이다. defaultProps는 class 컴포넌트에서 사용되는 패턴이며, function 컴포넌트에서는 default parameters가 권장된다.

예를 들어, 기존 코드가 다음과 같이 defaultProps를 사용하고 있다면:

```javascript
function Controller(props) {
  // ...
}

Controller.defaultProps = {
  buttonNumbers: [],
  onCountChange: () => {},
};
```

다음과 같이 default parameters를 사용하도록 변경할 수 있다:

```javascript
function Controller({ buttonNumbers = [], onCountChange = () => {} }) {
  // ...
}
```

### Error: Prop type "array" is forbidden react/forbid-prop-types

[rule: forbid-prop-types](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/forbid-prop-types.md)

array, object, any 타입은 이 규칙에 의해 사용이 금지된다.  
해당 타입을 사용하면 모든 종류의 배열, 객체, 모든 타입을 받아들일 수 있기 때문에, 보다 구체적인 타입을 명시하는 것이 권장된다.  
이는 컴포넌트의 props가 어떤 종류의 배열을 기대하는지 더 명확하게 설명하고, 오류를 미연에 방지한다.

위의 타입 대신에 `PropTypes.arrayOf()`나 `PropTypes.shape()`를 사용할 수 있다.

```javascript
SmartTable.propTypes = {
  name: PropTypes.string.isRequired,
  cols: PropTypes.arrayOf(
    PropTypes.shape({
      label: PropTypes.string.isRequired,
      width: PropTypes.number.isRequired,
    })
  ).isRequired,
  rows: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      data: PropTypes.arrayOf(PropTypes.string).isRequired,
    })
  ).isRequired,
};
```
