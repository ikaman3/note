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

ESLint를 사용하며 발생한 Error와 그 해결법을 모아두는 곳

### Error: JSX props should not use functions react/jsx-no-bind

[rule: jsx-no-bind](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/jsx-no-bind.md)
[solution](https://stackoverflow.com/questions/36677733/why-shouldnt-jsx-props-use-arrow-functions-or-bind)

In React, it's common to pass functions as props to handle events or side effects. However, if you're seeing a warning about this, it might be due to the way you're defining or using the function.

In your code snippet:

`onCountChange={handleCount}`

handleCount is a function that's being passed as a prop to a component. This is a common pattern in React and is generally fine.

However, if handleCount is defined inside a component that re-renders frequently, a new function will be created each time that component re-renders. This can lead to unnecessary re-renders of child components and performance issues.

To avoid this, you can define handleCount using the useCallback hook, which will return a memoized version of the function that only changes if one of the dependencies has changed.

Here's an example:

```javascript
const handleCount = useCallback((newCount) => {
  // handle the count change here
}, []); // add any dependencies here
```

Then, you can pass handleCount to onCountChange as before:

`onCountChange={handleCount}`

This way, handleCount will only be redefined if its dependencies change, preventing unnecessary re-renders.

### Error: 'foo' is missing in props validation react/prop-types

[rule: prop-types rule](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/prop-types.md)

[npm prop-types](https://www.npmjs.com/package/prop-types)

`import PropTypes from 'prop-types'`

### Error: propType "name" is not required, but has no corresponding defaultProps declaration. react/require-default-props

[rule: require-default-props](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/require-default-props.md)

[이 rule을 꺼야하는 이유](https://stackoverflow.com/questions/64012257/proptype-name-is-not-required-but-has-no-corresponding-defaultprops-declarati)

```json
"rules": {
  "react/require-default-props": "off"
}
```

#### Warning: Controller: Support for defaultProps will be removed from function components in a future major release. Use JavaScript default parameters instead.

이 경고 메시지는 Next.js의 future major release에서 function 컴포넌트에서의 defaultProps 지원이 제거될 것임을 알려주고 있습니다. 이것은 현재 사용하고 있는 컴포넌트에서 defaultProps를 사용하고 있다는 의미입니다.

경고를 해결하기 위한 방법은 해당 컴포넌트에서 defaultProps 대신에 JavaScript의 default parameters를 사용하는 것입니다. defaultProps는 class 컴포넌트에서 사용되는 패턴이며, function 컴포넌트에서는 default parameters가 권장됩니다.

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

다음과 같이 default parameters를 사용하도록 변경할 수 있습니다:

```javascript
function Controller({ buttonNumbers = [], onCountChange = () => {} }) {
  // ...
}
```

### Error: Prop type "array" is forbidden react/forbid-prop-types

[rule: forbid-prop-types](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/forbid-prop-types.md)
