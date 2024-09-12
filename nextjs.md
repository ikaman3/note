# Next.js

Next.js 강의와 공식 문서에서 얻은 정보를 기록해두는 문서

## Index

> [Next.js는 무엇이고 왜 사용하는가](#nextjs는-무엇이고-왜-사용하는가)  
> [Next.js의 기능과 장점](#nextjs의-기능과-장점)  
> [Next.js 프로젝트 생성](#nextjs-프로젝트-생성)  
> [Next.js의 폴더 구조](#nextjs의-폴더-구조)
>
> > [Route group](#route-group)  
> > [Private folder](#private-folder)  
> > [(Option) material icon theme custom](#option-material-icon-theme-custom)
>
> [Configuration](#configuration)  
> [배포](#배포)  
> [App Router](#app-router)  
> [Server Component](#server-component)  
> [Fullstack Framework](#fullstack-framework)  
> [Layout](#layout)  
> [Templates](#templates)  
> [Metadata](#metadata)
>
> > [Static Metadata](#static-metadata)  
> > [Dynamic Metadata](#dynamic-metadata)
>
> [CSS](#css)
>
> > [globals.css](#globalscss)  
> > [Tailwind](#tailwind)  
> > [CSS Module](#css-module)
>
> [Linking and Navigating](#linking-and-navigating)
>
> > [`<Link>` Component](#link-component)  
> > [`useRouter()` hook](#userouter-hook)  
> > [`redirect` function](#redirect-function)  
> > [Using the native History API](#using-the-native-history-api)  
> > [How Routing and Navigation Works](#how-routing-and-navigation-works)
>
> [Server vs Client Component in React - 적절한 선택 방법](#server-vs-client-component-in-react---적절한-선택-방법)  
> [DB](#db)
>
> > [`better-sqlite3`](#better-sqlite3)  
> > [Save data](#save-data)
>
> [Slug](#slug)  
> [XSS(Cross Site Scripting)](#xsscross-site-scripting)  
> [File System API](#file-system-api)  
> [Loading](#loading)  
> [Caching](#caching)
>
> > [Triggering Cache Revalidations](#triggering-cache-revalidations)  
> > [Local File System에 파일 저장 금지](#local-file-system에-파일-저장-금지)
>
> [Error Handling](#error-handling)  
> [Not Found](#not-found)  
> [Dynamic routing](#dynamic-routing)  
> [HTML Output](#html-output)  
> [Custom Image Picker](#custom-image-picker)  
> [Server Action](#server-action)
>
> > [Server side input validation](#server-side-input-validation)  
> > [Server Action Response](#server-action-response)
>
> [`form` 제출 상태 관리](#form-제출-상태-관리)  
> [Parallel Routes](#parallel-routes)  
> [Build-in Components](#build-in-components)
>
> > [`<Link>`](#link)  
> > [`<Image>`](#image)
>
> [Linting](#linting)
>
> > [Failed to load config "next" to extend from.](#failed-to-load-config-next-to-extend-from)  
> > [Error: JSX props should not use functions react/jsx-no-bind](#error-jsx-props-should-not-use-functions-reactjsx-no-bind)  
> > ['prop-types' should be listed in the project's dependencies, not devDependencies import/no-extraneous-dependencies](#prop-types-should-be-listed-in-the-projects-dependencies-not-devdependencies-importno-extraneous-dependencies)  
> > [Error: 'foo' is missing in props validation react/prop-types](#error-foo-is-missing-in-props-validation-reactprop-types)  
> > [Error: propType "name" is not required, but has no corresponding defaultProps declaration. react/require-default-props](#error-proptype-name-is-not-required-but-has-no-corresponding-defaultprops-declaration-reactrequire-default-props)  
> > [Error: Prop type "array" is forbidden react/forbid-prop-types](#error-prop-type-array-is-forbidden-reactforbid-prop-types)
>
> [Troubleshooting](#troubleshooting)
>
> > [뒤로가기하면 'use client' 오류가 나타나는 문제](#뒤로가기하면-use-client-오류가-나타나는-문제)  
> > [You provided a `value` prop to a form field without an `onChange` handler ...](#you-provided-a-value-prop-to-a-form-field-without-an-onchange-handler-)

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
- 코드 기반 환경설정 또는 패키지가 불필요, NextJS에 내장됨

Server-side Rendering

- 페이지에 보이는 모든 내용을 렌더링
- 검색 엔진 크롤러도 완성된 콘텐츠(HTML Markup)를 볼 수 있음(SEO 유리)

## Page Pre-rendering & Data Fetching

기존 React 앱의 단점을 Next.js는 사전 렌더링으로 보완했다.  
어떤 페이지(`/some-route`)는 데이터를 필요로하고 이 라우트에 요청이 들어오면 사전 렌더링된 페이지를 반환한다.  
표준 React는 빈 HTML 파일과 모든 JavaScript 코드가 표시될 것이다. 일반 DOM 구조 외에 필요한 데이터가 서버로부터 로딩될 때에는 시간이 걸린다.  
Next.js는 페이지와 필요한 모든 데이터가 있는 HTML 컨텐츠를 사전에 완성해 놓고 완전히 채워진 HTML 페이지를 클라이언트에게 전송한다. 이는 SEO 관점에서 훌륭하다.

그래도 여전히 대화형(Interactive) React 앱은 필요하다. 포럼 접속이나 에러 검증, 버튼 클릭 등에 반응한 사용자 상호작용이 필요하기 때문이다.  
Next.js는 단순히 사전 렌더링된 파일을 전송하는 것뿐만 아니라 포함(**Bundling**)된 JavaScript 코드를 모두 반환한다.  
이러한 반환을 해당 페이지에 대해 **Hydrate**(**수화**)한다고 한다.  
반환된 JavaScript 코드는 나중에 사전 렌더링된 페이지를 대체하고 React가 작업을 수행한다.  
이때 처음에 반환한 사전 렌더링된 페이지에는 주요 컨텐츠가 모두 포함되어 있어 검색 엔진 크롤러도 모든 컨텐츠를 살펴볼 수 있다.

> [Hydrate](https://helloinyong.tistory.com/315):  
> 리액트와 Next.js에의 Hydrate는 서버에서 렌더링된 HTML 마크업에 기반하여 클라이언트 측에서  
> JavaScript 이벤트와 상태를 연결하는 과정을 말한다.  
> 이를 통해 초기 로딩 시 클라이언트 측에서 즉시 상호작용이 가능하고 이후에 일반적인 리액트 앱처럼 동작한다.

사전 렌더링은 오직 최초 로딩에만 영향을 미친다. 즉, 페이지를 방문하면 로딩되는 첫 번째 페이지가 사전 렌더링된 것이다.  
Next.js와 리액트 앱은 페이지의 hydrate, 즉 첫 번째 렌더링이 끝나고 나면 표준 Single Page Application으로 돌아간다. 그때부터는 리액트가 프론트엔드에서 처리를 수행한다.  
이후 페이지가 바뀔 때, 즉 같은 웹 사이트의 다른 페이지로 넘어갈 때는 해당 페이지가 사전 렌더링되지 않고  
리액트를 통해 클라이언트 측에서 생성된다.

Next.js에는 두 가지의 사전 렌더링 방식이 존재한다.  
첫 번째 방법이자 권장하는 것은 **Static Generation(정적 생성)**  
두 번째 방법은 Server-Side Rendering(SSR, 서버 측 렌더링)  
가장 큰 차이는 정적 생성은 Build-time에 모든 페이지가 사전 생성된다는 것이다. 따라서 배포 전에 모든 페이지가 준비되는 것이다.  
SSR은 배포 후 요청이 서버까지 오는 바로 그때 모든 페이지가 생성된다.  
이 둘은 함께 사용할 수도 있다.

## Next.js 프로젝트 생성

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

## Next.js의 폴더 구조

Next.js 13에서 추가된 App router는 폴더내에 `page.js` 파일을 작성했을 때 해당 폴더의 이름으로 route 된다.

- 페이지들이 페이지가 아닌 폴더와 같은 depth에 위치하여 어떤 폴더가 페이지인지 구별하기 어려울 수 있다.
- 프로그래머의 실수로 인해 원치않는 폴더의 route가 생성될 수 있다.

### Route group

`(name)`  
route가 될 수 있는 페이지들을 하나의 그룹으로 묶는다.
route를 구분하기 위해 사용할 수도 있고 각각의 도메인에 맞게(admin, shop 등) 그룹을 나눌 수도 있다.

라우트 그룹을 이용해 폴더 구조의 가독성을 향상시킨다.

### Private folder

`_folder`  
해당 폴더는 route가 생성되지 않는다.

프라이빗 폴더를 이용해 원치않는 라우트의 생성을 예방한다.

### (Option) material icon theme custom

VSCode의 Plugin `material icon theme`을 사용하는 중에  
폴더 이름에 `_`를 붙이면서 아이콘의 색이 모두 회색으로 되어버렸다.

VSCode에서 extension을 설정할 수 있는 `settings.json`을 수정하여 해결할 수 있다.  
`.vscode` 폴더를 생성하고 그 안에 `settings.json` 파일을 만들면  
해당 프로젝트의 모두가 동일한 설정을 적용할 수 있다.

로컬의 `settings.json` 파일이나 VSCode의 설정을 직접 수정하면 해당 PC에서만 설정이 적용된다.

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

## Configuration

### env

루트 디렉터리에 `.env.local` 파일을 생성하여 정의한다.

```bash
NEXT_PUBLIC_API_URL=http://localhost:9999
```

사용법:

```javascript
const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/topics`);
```

## 배포

프로젝트 폴더에서 `npm run dev`를 실행하면 개발 서버가 시작되고, 기본적으로 `localhost:3000`에서 확인할 수 있다.

```bash
# 개발 서버 실행
npm run dev
# 포트 번호 지정 개발 서버 실행
PORT=22223 npm run dev
# 배포할 소스 빌드
npm run build
# 빌드한 소스를 실행
npm run start
```

`.next`: 빌드되어 Client에게 response할 내용이 있는 폴더

- 소스코드를 수정했는데 오류가 있거나 반영이 되지 않는다면 해당 폴더를 지우고 다시 빌드할 것

## App router

`app` 폴더안에 `awesome` 폴더와 그 폴더 안에 `page.js` 파일을 추가한다.

- NextJS는 이 `app` 폴더를 검사하여 설치가 필요한 경로를 탐지한다.
- 파일의 이름은 꼭 `page.js`이어야 함
  - 폴더명과 파일 이름이 합쳐져 신규 경로가 생성된다.(awesome - page)

`page.js` 파일에서 리액트 컴포넌트 함수를 `default`로 export 한다.

- Next.js에서 페이지는 단순한 리액트 함수다.
- 이때 컴포넌트 이름은 상관없다.

`localhost:3000/awesome`으로 방문하면 새로운 페이지 내용이 보인다.

- 소스코드를 검사해보면 리액트(CSR)와는 다르게 모든 내용이 존재한다.

기존 NextJS는 `/pages` 폴더에 웹 사이트의 모든 페이지를 나타내는 Page Router를 사용했다.  
Next.js 13 버전부터 앱 라우터가 도입되었다.

app 폴더에서 페이지를 설정한다. 이 페이지는 전반적인 웹사이트에 넣고 싶은 페이지를 의미한다.  
`page.js`, `layout.js`라는 보호된 파일이 존재하는데,  
`page.js` 파일은 NextJS에게 해당 페이지를 렌더링해야 한다고 전한다.

`localhost:3000/about` 이라는 페이지를 만들고 싶다면,  
`app` 디렉터리 하위에 라우트로 취급되길 원하는 폴더(`about`)를 생성한다.  
그리고 해당 폴더에 `page.js` 파일이 존재한다면 페이지를 렌더링할 수 있다. 이때, export할 함수 컴포넌트의 이름은 중요하지 않다.

```javascript
// app/about/page.js

export default function AboutPage() {
  return <h1>About us</h1>;
}
```

## Server Component

Next.js에서 리액트 컴포넌트는 기본적으로 서버 컴포넌트다.  
Next.js는 이 컴포넌트가 서버에 렌더링되고 서버에서 실행되는 것을 보장한다.  
예를 들어, 서버 컴포넌트에서 `console.log()`를 실행하면 클라이언트(브라우저 등)에서 보이지 않는다.  
대신 서버가 동작중인 터미널에 로그가 출력되며 이것이 해당 컴포넌트가 서버에서 실행된다는 것을 입증한다.

서버 컴포넌트는 서버에서 HTML로 렌더링되어 클라이언트에 응답으로 전달된다.

## Fullstack Framework

`<a></a>` 태그로 만든 버튼을 눌러 페이지를 이동하면 새로고침 아이콘이 일시적으로 X 모양으로 바뀐다.  
백엔드로부터 새로운 페이지를 다운로드했다는 의미이다.  
일반적인 리액트와는 다르게 단일 페이지 애플리케이션(Single page application)이 아니라는 뜻이다.

Next.js의 장점은 둘 다 가능하다는 것이다.  
특정 페이지를 처음 방문하거나 URL을 입력하여 접속한다면 서버에서 렌더링되고 완성된 페이지에 접속한다.  
이미 페이지에 있고 링크를 누르며 둘러본다면 SPA에 머무를 수 있게  
Client-side 자바스크립트 코드로 UI를 업데이트한다.

SPA에서 벗어나는 이유는 일반 앵커 태그(`<a></a>`)를 사용했기 때문이다.  
SPA에 머물기 위해서 `Link`라는 컴포넌트를 사용해야 한다.

```javascript
<Link href="/about">About Us</Link>
```

## Layout

`layout.js`(.jsx, .ts) 파일은 `page.js`와 마찬가지로 특별한 종류의 파일이다.  
`page.js` 파일이 페이지의 내용을 정의한다면,  
`layout.js` 파일은 하나 또는 그 이상의 페이지를 감싸는 껍데기를 정의한다.  
이름이 의미하는 것처럼 페이지가 렌더링되는 레이아웃을 의미하며,  
모든 Next 프로젝트에는 최소 하나의 root `layout.js` 파일이 필요하다.  
즉, app 폴더를 위한 `layout.js` 파일이 있어야 한다.

`layout.js` 파일은 중첩이 가능하다.  
`about` 폴더 안에 정의한 `layout.js` 파일은 `about` 폴더의 페이지와 중첩된 폴더에만 적용된다.

`page.js`와 동일하게 리액트 컴포넌트를 export하는데,  
리액트에서 모든 컴포넌트가 사용할 수 있는 표준 `children` prop을 이 컴포넌트가 사용해서 태그 사이에 내용을 추가한다.

루트 레이아웃은 웹사이트의 일반적인 HTML 뼈대(skeleton)를 잡기 위해 필수이다.
루트 레이아웃은 실제로 HTML과 `body` 태그를 렌더링한다.
`html`, `body` 태그는 루트 레이아웃에서만 렌더링 가능하다.

Next.js에서 `head` 태그 대신 `metadata`라는 특별한 변수를 선언하여 객체를 export해서 메타데이터 및 제목을 설정한다.  
상수 또는 변수일 수 있고 미리 정해진 이름이다.

```javascript
export const metadata = {
  title: "My Next.js App",
  description: "My first Next.js app!",
};
```

따라서 `head` 태그가 없는 이유는 해당 태그에 들어가는 모든 내용이 `metadata`에 의해 설정되거나  
Next.js의 백그라운드에서 자동으로 설정되기 때문이다.

`children`은 현재 활성화된 페이지(`page.js`)의 내용이다.  
레이아웃은 하나 또는 그 이상의 페이지를 감싸는 포장지(wrapper)와 같다.

> Good to know:
>
> - `.js`, `.jsx`, `.tsx` 파일 확장자를 `layout`에 사용할 수 있다.
> - `<html>`, `<body>` 태그는 루트 레이아웃에만 사용할 수 있다.
> - `layout`과 `page`가 같은 폴더에 정의되면, 레이아웃이 페이지를 랩핑한다.
> - 레이아웃은 기본적으로 서버 컴포넌트다. 그러나 원한다면 클라이언트 컴포넌트로 설정할 수 있다.
> - 레이아웃은 데이터 가져오기(fetch)를 할 수 있다. 자세한 내용은 [Data Fetching](https://nextjs.org/docs/app/building-your-application/data-fetching) section
> - 부모 레이아웃과 해당 자식 레이아웃 간에 데이터를 전달하는 건 불가능하다. 그러나 route에서 동일한 데이터를 두 번 이상 가져올 수 있으며, 리액트는 성능에 영향을 주지 않고 자동으로 요청을 중복 제거한다([automatically dedupe the requests](https://nextjs.org/docs/app/building-your-application/caching#request-memoization)).
> - 레이아웃은 자체 아래 route의 세그먼트에 접근할 수 없다. 모든 route 세그먼트에 접근하려면, 클라이언트 컴포넌트에서 [`useSelectedLayoutSegment`](https://nextjs.org/docs/app/api-reference/functions/use-selected-layout-segment) 또는 [`useSelectedLayoutSegments`](https://nextjs.org/docs/app/api-reference/functions/use-selected-layout-segments)를 사용할 수 있다.
> - [Route Groups](https://nextjs.org/docs/app/building-your-application/routing/route-groups)을 사용하여 공유 레이아웃 안팎에서 특정 route 세그먼트를 선택할 수 있다.
> - [Route Groups](https://nextjs.org/docs/app/building-your-application/routing/route-groups)을 사용하여 여러 루트 레이아웃을 생성할 수 있다. [보다 여기서 예제](https://nextjs.org/docs/app/building-your-application/routing/route-groups#creating-multiple-root-layouts)
> - 페이지 디렉터리로부터 마이그레이션: 루트 레이아웃은 [`_app.js`](https://nextjs.org/docs/pages/building-your-application/routing/custom-app)과 [`_document.js`](https://nextjs.org/docs/pages/building-your-application/routing/custom-document) 파일을 대체한다. [힘세고 강한 마이그레이션 가이드](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration#migrating-_documentjs-and-_appjs)

## Templates

템플릿은 각 하위 레이아웃이나 페이지를 래핑한다는 점에서 레이아웃과 유사하다.  
route 전반에 걸쳐 지속되고 상태를 유지하는 레이아웃과 달리, 템플릿은 탐색 시 각 하위 항목에 대해 새 인스턴스를 만든다.

이는 사용자가 템플릿을 공유하는 route 사이를 탐색할 때, 컴포넌트의 새 인스턴스가 마운트되고 DOM 요소가 다시 생성되며  
상태가 유지되지 않고 effects가 다시 동기화됨을 의미한다.  
이러한 특정 동작이 필요한 경우가 있을 수 있으며, 그 경우에 템플릿은 레이아웃보다 더 적합한 선택이다.

예를 들어:

- `useEffect`(예: logging page views) 및 `useState`(예: per-page feedback form)에 의존하는 기능
- 기본 프레임워크 동작을 변경하는 경우: 예를 들어 레이아웃 내부의 정지 경계(Suspense Boundaries)는 레이아웃이 처음 로드될 때만 대체(the fallback)를 표시하고 페이지를 전환할 때는 표시하지 않는다. 템플릿의 경우 각 탐색에 fallback이 표시된다.

`template.js` 파일에서 디폴트 리액트 컴포넌트를 export해서 템플릿을 정의할 수 있다.  
컴포넌트는 `children` prop을 허용해야 한다.

```javascript
// app/template.js

export default function Template({ children }) {
  return <div>{children}</div>;
}
```

중첩 측면(In terms of nesting)에서 `template.js`은 레이아웃과 해당 하위 항목 사이에 렌더링된다. 다음은 간단한 예시 출력이다:

```javascript
<Layout>
  {/* Note that the template is given a unique key. */}
  <Template key={routeParam}>{children}</Template>
</Layout>
```

## Metadata

`App` 디렉터리에서 [Metadata APIs](https://nextjs.org/docs/app/building-your-application/optimizing/metadata)를 이용하여 `title`이나 `meta` 같은 `<head>` HTML elements를 수정할 수 있다.

메타데이터는 `layout.js` 또는 `page.js` 파일 안에서 [metadata object](https://nextjs.org/docs/app/api-reference/functions/generate-metadata#the-metadata-object)나 [`generateMetadata` function](https://nextjs.org/docs/app/api-reference/functions/generate-metadata#generatemetadata-function)를 export하여 정의할 수 있다.

Next.js는 모든 `layout.js` 또는 `page.js` 파일에서 메타데이터를 찾아낸다.
메타데이터는 Search Engine Crawler에 노출되게 하거나 페이지 링크를 SNS에 공유할 때 보여주기도 한다.  
자세한 필드는 위의 문서에서 확인할 수 있다.

- 메타데이터를 `layout.js`에 추가하면 그 `layout`이 감싸는 모든 `page`에 자동으로 적용한다.
- `page`에 메타데이터가 존재하면 `layout`보다 `page`의 메타데이터가 우선한다.
- 중첩된 `layout`에 메타데이터가 존재하면 root `layout` 메타데이터가 우선한다.

아래의 두 `meta` 태그는 기본적으로 추가된다.

```html
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

### Static Metadata

```javascript
export const metadata = {
  title: "All Meals",
  description: "Browse the delicious meals shared by our vibrant community.",
};
```

> Good to know:  
> 루트 `layout`에는 수동으로 `<title>` 및 `<meta>`와 같은 `<head>` 태그를 추가해서는 안 된다.  
> 대신 Metadata API를 사용해야 한다. Metadata API는 스트리밍(streaming) 및 `<head>` 요소의 중복을 처리(de-duplicating)하는 등 고급 요구 사항을 자동으로 처리한다.

### Dynamic Metadata

`generateMetadata()`라는 async 함수를 export하여 메타데이터를 동적으로 추가할 수 있다.  
정적 메타데이터가 존재하지 않는다면 Next.js가 이 함수를 찾아서 실행한다.  
반드시 이 함수는 metadata 객체를 반환해야 한다.

이 함수는 페이지 컴포넌트가 props로 받는 것과 동일한 데이터를 받는다.  
동일하게 `params`라는 prop을 받아서 데이터를 가져올 수 있다.

```javascript
export async function generateMetadata({ params }) {
  const meal = getMeal(params.mealSlug);
  if (!meal) {
    notFound();
  }

  return {
    title: meal.title,
    description: meal.summary,
  };
}
```

이때 유효하지 않은 동적 페이지에 방문하면 Not Found가 아닌 에러 페이지가 나온다.  
메타데이터는 처음에 만들어지기 때문에 `meal.title`이 `undefined`이므로 에러가 발생하기 때문이다.  
따라서 `if` 조건문으로 Not Found 페이지로 가도록 해야한다.

## CSS

리액트와 마찬가지로 여러 개의 옵션을 갖는다.

### globals.css

여러 개의 css 파일을 추가할 수 있고, 이름은 자유다.  
globals인 이유는 해당 파일이 root `layout.js` 파일에서 import되기 때문이다.  
어느 css 파일이든 root `layout.js` 파일로 import되는 것은 모든 `page`에서 유효하다.

```javascript
import "./globals.css";
```

### Tailwind

테일윈드는 최근 인기있는 선택으로, css 라이브러리이다.
Element를 스타일링할 때 그 요소에 유틸리티 클래스를 추가하여 구현한다.

### CSS Module

Next.js에서 기본으로 지원하는 솔루션이다.  
일반적인 css 코드이지만 css 파일에 특정 이름을 지정하여 특정 컴포넌트로 스코핑된다.  
`.module.css`로 끝나는 css 파일을 추가하면, 그 파일로부터 객체를 불러올 수 있고  
기본 빌드 프로세스 및 개발 서버에 의해 자동으로 생성되며, 해당 파일에서 정의한 모든 css 클래스를 속성 이름으로 접근할 수 있다.

이때 이름은 css를 적용할 `js`, `jsx`, `ts` 파일의 이름과 같아야하고 `.module.css`로 끝나야 한다.
`globals.css`와는 약간 다른 방식으로 import하게 된다.

```javascript
import classes from "./page.module.css";

<Link className={classes.logo} href="/">
```

- import할 변수의 이름은 자유다. 관습적으로 `classes` 또는 `styles`를 사용한다.
- `classes` 변수는 객체이며, css 파일에 정의한 모든 클래스는 이 객체에서 속성으로 사용된다.
- `className`에 문자열이 아닌 동적인 값으로 `classes` 객체에 접근할 수 있다. 해당 예시에서는 `logo` 클래스이다.

## Linking and Navigating

Next.js에는 routes 사이를 탐색하는 4개의 방법이 존재한다.

- Using the [`<Link>` Component](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#link-component)
- Using the [`useRouter`](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#userouter-hook) hook ([Client Components](https://nextjs.org/docs/app/building-your-application/rendering/client-components))
- Using the [`redirect` function](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#redirect-function) ([Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components))
- Using the native [History API](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#using-the-native-history-api)

### `<Link>` Component

`<Link>`는 HTML `<a>` 태그를 확장하여 라우트 간 prefetching 및 클라이언트 측(client-side) 내비게이션을 제공하는 build-in 컴포넌트다.  
Next.js에서 라우트 간 이동하는 주요하고 권장되는 방법이다.  
앵커 태그와는 다르게 사이트를 SPA로 유지하며 이동할 수 있게 한다.

`next/link`에서 가져와서 컴포넌트에 `href` 속성을 전달하여 사용할 수 있다.
그 밖에도 `<Link>` 컴포넌트에 전달할 수 있는 prop이 있다. [API reference](https://nextjs.org/docs/app/api-reference/components/link)에서 확인

```javascript
import Link from "next/link";

export default function Page() {
  return <Link href="/dashboard">Dashboard</Link>;
}
```

#### Example

##### Linking to Dynamic Segments

동적 세그먼트에 링크를 연결할 때, 템플릿 리터럴과 보간법을 사용하여 링크 목록을 생성할 수 있다. 예를 들어, 블로그 게시물 목록을 생성하려면:

```javascript
// /app/blog/PostList.js

import Link from "next/link";

export default function PostList({ posts }) {
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.id}>
          <Link href={`/blog/${post.slug}`}>{post.title}</Link>
        </li>
      ))}
    </ul>
  );
}
```

##### Checking Active Links

`usePathname()` 함수를 사용하여 링크가 active 상태인지 확인할 수 있다.  
예를 들어, active link에 클래스를 추가하려면 현재 `pathname`이 링크의 `href`와 일치하는지 확인할 수 있다.
클라이언트 컴포넌트에서만 사용할 수 있으며, `next/navigation`에서 import한다.

이 훅은 도메인 다음 부분인 path를 반환한다.
`startsWith` 메서드를 사용하면 특정 경로 세그먼트로 시작하는지 검사할 수 있다. 이를 이용해 중첩된 라우트의 경로를 활용할 수 있다.

```javascript
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

export function Links() {
  const pathname = usePathname();

  return (
    <Link className={`link ${pathname === "/" ? "active" : ""}`} href="/">
      Home
    </Link>
    <Link
      className={`link ${pathname === "/about" ? "active" : ""}`}
      href="/about"
    >
    <Link href="/meals" className={path.startsWith("/meals") ? `${classes.link} ${classes.active}` : classes.link}>
      {children}
    </Link>
  );
}
```

##### Scrolling to an `id`

Next.js App router의 기본 동작은 새 route로 스크롤을 맨 위로 이동하거나 뒤로/앞으로 탐색 시 스크롤 위치를 유지한다.  
만약 특정 `id`로 스크롤하고 싶다면, URL에 `#` 해시 링크를 추가하거나  
`href` 속성에 해시 링크를 전달할 수 있다. 이것은 `<Link>`가 `<a>` 요소로 렌더링되기 때문에 가능하다.

```javascript
<Link href="/dashboard#settings">Settings</Link>

// Output
<a href="/dashboard#settings">Settings</a>
```

> Good to know:
> Next.js는 탐색 시 페이지가 viewpoert에 보이지 않을 때 해당 페이지로 스크롤된다.

##### Disabling scroll restoration

Next.js App router의 기본 동작은 새 route로 넘어갈 때 스크롤을 맨 위로 이동하거나 뒤로/앞으로 탐색 시 스크롤 위치를 유지하는 것이다.  
이 동작을 비활성화하려면 `<Link>` 컴포넌트에 `scroll={false}`를 전달하거나 `router.push()` 또는 `router.replace()`에 `scroll: false`를 전달할 수 있다.

```javascript
// next/link
<Link href="/dashboard" scroll={false}>
  Dashboard
</Link>
```

```javascript
// useRouter
import { useRouter } from "next/navigation";
const router = useRouter();
router.push("/dashboard", { scroll: false });
```

### `useRouter()` hook

`useRouter` 훅을 사용하면 클라이언트 컴포넌트에서 프로그래밍 방식으로 라우트를 변경할 수 있다.

```javascript
"use client";

import { useRouter } from "next/navigation";

export default function Page() {
  const router = useRouter();
  return (
    <button type="button" onClick={() => router.push("/dashboard")}>
      Dashboard
    </button>
  );
}
```

`useRouter` 훅의 자세한 내용은 링크 참고 [API Reference](https://nextjs.org/docs/app/api-reference/functions/use-router)

> Recommendation:
> `useRouter`를 사용해야 하는 특정 요구사항이 없는 한 라우트 간의 이동에 `<Link>` 컴포넌트를 사용할 것

### 상대경로

현재 페이지의 URL 경로를 기준으로 './'의 의미를 설명드리겠습니다:
현재 페이지가 '/sample/post/create'인 경우:  
'./' = '/sample/post/'
현재 페이지가 '/sample/post/view/1234'인 경우:  
'./' = '/sample/post/view'  
현재 페이지가 '/sample/post/update/1234'인 경우:
'./' = '/sample/post/update'
현재 페이지가 '/sample/post/list'인 경우:
'./' = '/sample/post/'
즉, './'는 현재 URL의 마지막 세그먼트를 제외한 경로를 가리킵니다. 이는 파일 시스템의 디렉토리 구조와 유사하게 동작합니다.
예를 들어, '/sample/post/create' 페이지에서 './list'로 라우팅하면 '/sample/post/list'로 이동하게 됩니다.

`./`는 동적 파라미터가 포함된 경우에도 맨 마지막 세그먼트를 제외한 경로를 가리킨다. 따라서 뒤에 세그먼트가 추가된 라우트에서 다른 라우트로 이동할 때는 `../`으로 상위 라우트로 이동하도록 해야한다.

### `redirect` function

서버 컴포넌트라면 대신 `redirect` 함수를 사용할 수 있다.

```javascript
// app/team/[id]/page.js
import { redirect } from "next/navigation";

async function fetchTeam(id) {
  const res = await fetch("https://...");
  if (!res.ok) return undefined;
  return res.json();
}

export default async function Profile({ params }) {
  const team = await fetchTeam(params.id);
  if (!team) {
    redirect("/login");
  }

  // ...
}
```

> Good to know:
> `redirect`는 기본적으로 307(임시 리디렉션) 상태 코드를 반환한다. 서버 액션에서 사용할 경우, POST 요청의 결과로 성공 페이지로 리디렉션할 때 일반적으로 사용되는 303(다른 곳 보기)을 반환한다.  
> `redirect`는 내부적으로 오류를 throw하기 때문에 `try/catch` 블록 외부에서 호출되어야 한다.  
> `redirect`는 클라이언트 컴포넌트에서 렌더링 프로세스 중에 호출될 수 있지만 이벤트 핸들러에서는 호출할 수 없다. 대신 `useRouter` 훅을 사용할 수 있다.  
> `redirect`는 절대(absolute) URL도 허용하며 외부 링크로 리디렉션하는 데 사용할 수 있다.  
> 렌더링 프로세스 이전에 리디렉션을 하려면 [`next.config.js`](https://nextjs.org/docs/app/building-your-application/routing/redirecting#redirects-in-nextconfigjs) 또는 [Middleware](https://nextjs.org/docs/app/building-your-application/routing/redirecting#nextresponseredirect-in-middleware)를 사용

[`redirect` API Reference](https://nextjs.org/docs/app/api-reference/functions/redirect)

### Using the native History API

Next.js에서는 페이지 reloading 없이 브라우저의 history stack을 업데이트하기 위해 네이티브 `window.history.pushState` 및 `window.history.replaceState` 메서드를 사용할 수 있다.  
`pushState` 및 `replaceState` 호출은 Next.js Router에 통합되어 `usePathname` 및 `useSearchParams`와 동기화할 수 있도록 한다.

#### `window.history.pushState`

브라우저의 history stack에 새 항목을 추가하여 이전 상태로 돌아갈 수 있다.  
예를 들어, 제품 목록을 정렬할 때 사용할 수 있다.

```javascript
"use client";

import { useSearchParams } from "next/navigation";

export default function SortProducts() {
  const searchParams = useSearchParams();

  function updateSorting(sortOrder) {
    const params = new URLSearchParams(searchParams.toString());
    params.set("sort", sortOrder);
    window.history.pushState(null, "", `?${params.toString()}`);
  }

  return (
    <>
      <button onClick={() => updateSorting("asc")}>Sort Ascending</button>
      <button onClick={() => updateSorting("desc")}>Sort Descending</button>
    </>
  );
}
```

#### `window.history.replaceState`

브라우저의 history stack에서 현재 항목을 대체하여 이전 상태로 돌아갈 수 없도록 할 수 있다.  
예를 들어, 애플리케이션의 locale을 변경할 때 사용할 수 있다.

```javascript
"use client";

import { usePathname } from "next/navigation";

export function LocaleSwitcher() {
  const pathname = usePathname();

  function switchLocale(locale) {
    // e.g. '/en/about' or '/fr/contact'
    const newPath = `/${locale}${pathname}`;
    window.history.replaceState(null, "", newPath);
  }

  return (
    <>
      <button onClick={() => switchLocale("en")}>English</button>
      <button onClick={() => switchLocale("fr")}>French</button>
    </>
  );
}
```

### How Routing and Navigation Works

App Router는 라우팅 및 네비게이션에 대해 하이브리드 접근 방식을 사용한다.  
서버에서는 애플리케이션 코드가 자동으로 라우트 세그먼트로 [code-split](https://nextjs.org/docs/app/building-your-application/routing/linking-and-navigating#1-code-splitting)한다.  
그리고 클라이언트에서는 Next.js가 라우트 세그먼트를 prefetches하고 caches한다.  
이것은 사용자가 새로운 route로 이동할 때 브라우저가 페이지를 reload하지 않고 변경된 라우트 세그먼트만 re-render되므로 네비게이션 경험과 성능이 향상된다.

#### 1. Code Splitting

코드 분할을 통해 애플리케이션 코드를 더 작은 번들로 분할하여 브라우저가 다운로드하고 실행할 수 있다.  
이렇게 하면 전송되는 데이터 양과 각 요청의 실행 시간이 감소하여 성능이 향상된다.
서버 컴포넌트를 사용하면 애플리케이션 코드가 자동으로 코드를 라우트 세그먼트로 분할한다.  
이것은 네비게이션 시 현재 경로에 필요한 코드만 로드된다는 것을 의미한다.

#### 2. Prefetching

사전로드는 사용자가 방문하기 전에 백그라운드에서 라우트를 미리 로드하는 방법이다.
Next.js에서 라우트를 사전로드하는 두 가지 방법이 있다:

- `<Link>` component : 사용자 뷰포트에 표시되는 대로 라우트가 자동으로 사전로드됩니다. 사전로드는 페이지가 처음 로드될 때 또는 스크롤을 통해 뷰에 나타날 때 발생한다.
- `router.prefetch()` : `useRouter` 훅을 사용하여 프로그래밍 방식으로 라우트를 사전로드할 수 있다.

`<Link>`의 사전로드 동작은 정적 및 동적 라우트에 따라 다르다:

- [Static Routes](https://nextjs.org/docs/app/building-your-application/rendering/server-components#static-rendering-default) : `prefetch`는 기본적으로 `true`다. 전체 라우트가 사전로드되고 캐시된다.
- [Dynamic Routes](https://nextjs.org/docs/app/building-your-application/rendering/server-components#dynamic-rendering) : `prefetch`는 기본적으로 automatic입니다. 공유 레이아웃만 사전로드되며 렌더링된 **"트리"**의 구성 요소가 로드될 때까지 첫 번째 `loading.js` 파일까지 사전로드되고 캐시된다. 이렇게 함으로써 전체 동적 라우트를 가져오는 비용이 감소하고 사용자에게 더 나은 시각적 피드백을 제공하기 위해 즉시 로딩 상태를 표시할 수 있다.

`prefetch` prop을 `false`로 설정하여 사전로드를 비활성화할 수 있다.

> Good to know:  
> 사전로드는 개발 환경에서는 활성화되지 않으며, 오직 프로덕션 환경에서만 활성화된다.

#### 3. Caching

Next.js에는 Router Cache라는 in-memory 클라이언트 측 캐시가 있다.  
사용자가 앱을 탐색하는 동안 사전로드된 라우트 세그먼트와 방문한 라우트의 React 서버 컴포넌트 페이로드가 캐시에 저장된다.  
이는 네비게이션 시 서버로의 새 요청을 만드는 대신에 가능한 한 많이 캐시를 재사용함으로써 성능을 향상시킨다.(요청 수와 데이터 전송량을 줄임으로써 성능을 향상시킨다.)

[Router Cache](https://nextjs.org/docs/app/building-your-application/caching#router-cache)

#### 4. Partial Rendering

네비게이션 시 변경된 라우트 세그먼트만 클라이언트에서 re-render되고 공유 세그먼트는 보존된다.  
예를 들어, 두 개의 형제 경로(sibling route)(`/dashboard/settings`와 `/dashboard/analytics`) 사이를 이동할 때,  
`settings` 및 `analytics` 페이지가 렌더링되고 공유되는 `dashboard` 레이아웃이 보존된다.

부분 렌더링이 없으면 각 네비게이션마다 클라이언트에서 전체 페이지를 다시 렌더링해야 한다.  
변경된 세그먼트만 렌더링하면 전송되는 데이터 양과 실행 시간이 줄어들어 성능이 향상된다.

#### 5. Soft Navigation

브라우저는 페이지 간 탐색 시 "hard navigation"을 수행한다.  
Next.js 앱 라우터는 페이지 간 "soft navigation"을 가능하게 하여 변경된 라우트 세그먼트만 다시 렌더링되도록 한다(partial rendering).  
이로써 클라이언트 React 상태가 탐색 중에 보존된다.

#### 6. Back and Forward Navigation

기본적으로 Next.js는 뒤로 및 앞으로 탐색에 대해 스크롤 위치를 유지하고 Router Cache에서 라우트 세그먼트를 재사용한다.

#### 7. Routing between `pages/` and `app/`

`page/`에서 앱으로 점진적으로 마이그레이션할 때 Next.js 라우터는 두 사이의 하드 네비게이션을 자동으로 처리합니다. `page/`에서 앱으로의 전환을 감지하기 위해 앱 라우트의 확률적 확인을 활용하는 클라이언트 라우터 필터가 있습니다. 이는 가끔 거짓 양성을 유발할 수 있습니다. 기본적으로 이러한 발생 빈도는 매우 드빕니다. 왜냐하면 거짓 양성 가능성을 0.01%로 구성하기 때문입니다. 이 가능성은 next.config.js의 experimental.clientRouterFilterAllowedRate 옵션을 통해 사용자 정의할 수 있습니다. 거짓 양성 확률을 낮추면 클라이언트 번들에서 생성된 필터의 크기가 커집니다.

다른 방법으로, 이러한 처리를 완전히 비활성화하고 `page/`와 앱 사이의 라우팅을 수동으로 관리하려면 `next.config.js`에서 `experimental.clientRouterFilter`를 `false`로 설정할 수 있다.  
이 기능이 비활성화되면 페이지의 동적 라우트가 앱 라우트와 겹치는 경우 기본적으로 올바르게 네비게이션되지 않는다.

## Server vs Client Component in React - 적절한 선택 방법

`create-react-app`이나 Vite의 도움으로 만드는 모든 바닐라 리액트 앱에서 기본적으로 클라이언트 컴포넌트를 사용한다.  
왜냐하면 이런 프로젝트에서 React.js는 순수한 클라이언트-사이드 라이브러리로, 클라이언트 측의 브라우저에서 코드를 실행하기 때문이다.

Next.js는 풀스택 프레임워크이기 때문에 기본적으로 모든 컴포넌트는 페이지, 레이아웃, 기본 컴포넌트에 관계없이 오직 서버에서만 렌더링된다.  
그래서 이들은 리액트 서버 컴포넌트라고 불린다.

리액트 서버 컴포넌트는 리액트에 내장된 기능이지만 특정한 뒷단 빌드 프로세스와 구조로 잠겨있어서 대부분의 리액트 프로젝트의 일부가 아니다.  
그러나 Next.js 프로젝트에서는 잠금해제되어있고, 기본적인 것이다.  
따라서 Next.js에서 모든 리액트 컴포넌트는 기본적으로 서버에서 렌더링된다.
아무 컴포넌트에가서 `console.log`로 문자열을 출력해보면 브라우저의 콘솔에서는 찾을 수 없다. 대신 서버를 실행중인 터미널에 로그를 볼 수 있다.

Next.js에서 클라이언트 컴포넌트는 서버에서 pre-rendered되고 잠재적으로 클라이언트에 렌더링된다.  
이 컴포넌트는 클라이언트에만 사용할 수 있는 코드나 기능을 포함하고 있다.  
예를 들어 `useState`, `useEffect` 훅이 대표적이다. 이 훅들은 서버 측에서 사용 불가한데,  
interval 등을 서버에 설정하는 것이 아니라 브라우저에 페이지가 로드된 후에 이미지가 5초마다 변경되는 등의 결과를 원하기 때문이다.

또 하나의 기능은 eventHandler다. `onClcik` 속성으로 몇 가지 함수를 트리거하면,  
그곳에서 사용자 상호작용을 기다리고 있기에 클라이언트에서 실행되는 코드가 필요하므로 클라이언트 컴포넌트여야 한다.

Next.js에서는 기본적으로 모두 서버 컴포넌트이므로 클라이언트 컴포넌트로 만들려면  
파일 최상단에 특별한 지시어 `'use client'`를 추가해야 한다.

## DB

### `better-sqlite3`

로컬에서 간단하게 사용할 수 있는 sqlite 패키지

```bash
npm install better-sqlite3
```

<details markdown="1">
  <summary>DB 파일 생성 스크립트: `initdb.js`</summary>

```javascript
const sql = require("better-sqlite3");
// 같은 이름의 db가 있다면 기존 것을 사용하고 없으면 생성
const db = sql("meals.db");

const dummyMeals = [
  {
    title: "Juicy Cheese Burger",
    slug: "juicy-cheese-burger",
    image: "/images/burger.jpg",
    summary:
      "A mouth-watering burger with a juicy beef patty and melted cheese, served in a soft bun.",
    instructions: `
      1. Prepare the patty:
         Mix 200g of ground beef with salt and pepper. Form into a patty.

      2. Cook the patty:
         Heat a pan with a bit of oil. Cook the patty for 2-3 minutes each side, until browned.

      3. Assemble the burger:
         Toast the burger bun halves. Place lettuce and tomato on the bottom half. Add the cooked patty and top with a slice of cheese.

      4. Serve:
         Complete the assembly with the top bun and serve hot.
    `,
    creator: "John Doe",
    creator_email: "johndoe@example.com",
  },
  ...
];

db.prepare(
  `
   CREATE TABLE IF NOT EXISTS meals (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       slug TEXT NOT NULL UNIQUE,
       title TEXT NOT NULL,
       image TEXT NOT NULL,
       summary TEXT NOT NULL,
       instructions TEXT NOT NULL,
       creator TEXT NOT NULL,
       creator_email TEXT NOT NULL
    )
`
).run();

async function initData() {
  const stmt = db.prepare(`
      INSERT INTO meals VALUES (
         null,
         @slug,
         @title,
         @image,
         @summary,
         @instructions,
         @creator,
         @creator_email
      )
   `);

  for (const meal of dummyMeals) {
    stmt.run(meal);
  }
}

initData();
```

</details>

스크립트 실행 명령어:

```bash
node initdb.js
# root 폴더에 meals.db 이름의 파일이 생성되면 완료
```

쿼리 작성:

`better-sqlite3`는 `Promise`를 사용하지 않지만 함수 자체를 `async`로 만들어 `Promise`로 래핑할 수 있다.

- `sql("<DB name>")`: 해당 이름의 DB에 접근
- `run()`: insert, update할 때 사용
- `all()`: 모든 데이터를 fetching할 때 사용
- `get()`: 한 개의 데이터를 fetching할 때 사용

> **주의사항**  
> 사용자의 입력값을 사용할 때 SQL Injection 공격을 주의해야 한다.  
> 아래의 예에서 `db.prepare("SELECT * FROM meals WHERE slug = " + slug);` 이렇게 처리할 수도 있지만 사용자의 입력을 그대로 쿼리에 담기때문에 위험하다.  
> 대신 플레이스 홀더(`?`)를 사용해서 뒤에 오는 메서드(`get()` 등)에 값을 넘긴다.

```javascript
import sql from "better-sqlite3";

const db = sql("meals.db");

export async function getMeals() {
  return db.prepare("SELECT * FROM meals").all();
}

export function getMeal(slug) {
  return db.prepare("SELECT * FROM meals WHERE slug = ?").get(slug);
}
```

사용법:

```javascript
import { getMeal } from "@/lib/meals";

export default function Page({ params }) {
  const meal = getMeal(params.mealSlug);
  ...
  <h1>{meal.title}</h1>
}
```

### Save data

sql을 작성하는 파일에 데이터 저장 함수를 추가한다.  
DB에 Slug를 저장해야 하는데 `form`에서 받는 게 아닌 `title`로부터 만들어서 저장한다.
두 개의 패키지 `slugify`, `xss`가 필요하다.

이미지는 DB가 아닌 파일 시스템에 저장해야 한다. DB는 기본적으로 파일의 저장을 위해 설계되지 않았기 때문이다.  
업로드된 파일을 public 폴더에 저장하면 어디서든 접근이 용이하여 문제없이 화면에 렌더링할 수 있다.  
폴더에 파일을 저장(write)하려면 File System API를 사용한다.

```javascript
export async function saveMeal(meal) {
  meal.slug = slugify(meal.title, { lower: true });
  meal.instructions = xss(meal.instructions);

  const extension = meal.image.name.split(".").pop();
  const fileName = `${meal.slug}.${extension}`;

  const stream = fs.createWriteStream(`public/images/${fileName}`);
  const bufferedImage = await meal.image.arrayBuffer();
  stream.write(Buffer.from(bufferedImage), (error) => {
    if (error) {
      throw new Error("Saving image failed!");
    }
  });

  meal.image = `/images/${fileName}`;

  db.prepare(
    `
    INSERT INTO meals
      (title, summary, instructions, creator, creator_email, image, slug)
    VALUES (
      @title,
      @summary,
      @instructions,
      @creator,
      @creator_email,
      @image,
      @slug
    )
  `
  ).run(meal);
}
```

> 파일을 실수로 덮어쓰는 것을 방지하려면 파일 이름이 동일한 이름을 가지지 않게  
> 각 파일 이름에 일부 랜덤 또는 고유한 요소를 추가하는 것이 좋다.

- `meal.image = '/images/${fileName}'`: public 폴더는 서버의 root 단계에 있는 것과 동일하게 동작하므로 path segment에 public을 넣지 않아야 이미지 요청이 정상 작동한다.
- `prepare()`: statement를 준비하는 메서드
  - `@field`: better-sqlite3에서 제공하는 문법. 필드의 이름으로 특정 필드를 연결한다. 위의 필드 순서와 동일해야 함에 주의. `run()` 메서드에 인수로 전달한 객체에서 속성 이름을 찾아서 그 값을 추출하고 해당 필드에 저장한다.

SQL이 준비되었다면 Server Action에서 해당 함수를 호출할 수 있다.

## Slug

일반적으로 URL이나 파일 경로 등에 사용되는 문자열을 만들기 위한 텍스트 변환 기술  
주로 제목이나 이름과 같은 텍스트를 URL에 포함하기 위해 사용하며 공백이나 특수 문자를 제거하고  
대소문자를 일관되게 처리하여 URL을 깔끔하고 읽기 쉽게 만든다.

예를 들어, `"Hell World!"`라는 제목을 Slug로 변환하면 `"hell-world"`가 될 수 있다.  
이렇게 바뀐 Slug는 URL에 `xxx.com/article/hell-world`처럼 사용된다.

JavaScript에서는 `slugify` 같은 패키지를 사용해서 쉽게 변환할 수 있다.

Install:

```bash
npm install slugify
```

Using:

```javascript
meal.slug = slugify(meal.title, { lower: true });
```

- `slugify()`: slug 생성 함수
  - 두번째 인수 `{}`: 설정 객체
    - `lower`: `true`면 모든 문자를 소문자로 설정

## XSS(Cross Site Scripting)

사용자의 HTML 입력값을 받아서 처리할 때 항상 주의해야 할 공격 방법  
JavaScript에서 `xss` 패키지로 쉽게 살균할 수 있다.

Install:

```bash
npm install xss
```

Using:

```javascript
meal.instructions = xss(meal.instructions);
```

## File System API

[`node:fs`](https://nodejs.org/api/fs.html#file-system) 모듈은 표준 POSIX 함수를 모방하여 파일 시스템과 상호 작용할 수 있도록 한다.

```javascript
import fs from "node:fs";

const stream = fs.createWriteStream(`public/images/${fileName}`);
const bufferedImage = await meal.image.arrayBuffer();
stream.write(Buffer.from(bufferedImage), (error) => {
  if (error) {
    throw new Error("Saving image failed!");
  }
});
```

- `createWriteStream()`: 파일에 데이터를 쓸 수 있도록 하는 `WriteStream`을 생성. 파일을 쓸 path를 인수로 받고, stream 객체를 return한다. path에 반드시 파일 이름을 포함한 경로를 작성한다.
  - `write()`: 파일 쓰기 메서드. 첫 번째 인수로 저장할 파일인 `Buffer` 타입의 chunk가 필요하다. 두 번째 인수로 쓰기를 마치면 실행할 함수가 필요하다. 이 함수는 `error` 인수를 받는데 정상 완료라면 `null`이 들어있고, 에러가 발생했다면 에러 정보를 가지고 있다.
- `arrayBuffer()`: 이미지 객체에 정의된 메서드. `Promise`로 래핑된 `ArrayBuffer` 타입을 리턴하므로 `await`을 사용해야 한다.
- `Buffer.from()`: `ArrayBuffer` 타입을 `Buffer` 타입으로 변환하는 메서드

## Loading

`loading` 페이지를 추가하여 로딩 페이지를 추가할 수 있다.  
`layout`처럼 지정된 이름이다.

같은 위치 혹은 중첩된 `page`가 데이터를 불러올 때 활성화되며 데이터를 다 가져올 때까지 해당 페이지를 대체한다.

`loading` 페이지에 데이터와 상관없이 보여줄 헤더 혹은 그 이외의 컨텐츠를 직접 추가해도 문제는 없다.  
다만, 로딩 페이지가 적용되는 중첩된 다른 페이지에서 해당 컨텐츠를 표시하고 싶지 않다면 문제가 된다.

`loading` 페이지는 React의 `<Suspense>`로 래핑된다. 이것을 수작업으로 할 수 있다.
로딩을 원하는 페이지에 컴포넌트를 추가하고 그 컴포넌트가 데이터를 불러오게 한다.  
데이터 가져오기를 분리된 컴포넌트로 옮기고 리액트 내장 컴포넌트(`<Suspense>`)로 래핑할 수 있다.

`<Suspense>`는 react 내장 컴포넌트로 일부 데이터 또는 리소스가 불러와질 때까지 로딩 상태를 처리하고 대체 컨텐츠를 표시한다. Next.js는 이러한 리액트의 컨셉을 포용한다.
`fallback` 속성으로 로딩 컨텐츠를 명시하여 수작업으로 할 수 있다.  
이렇게하면 `<Meals />`부분만 로딩 컨텐츠를 표시한다고 리액트에 알리고 해당 페이지만의 컨텐츠(헤더 등)을 표시하면서 데이터를 기다릴 수 있다.

```javascript
import { Suspense } from 'react'

async function Meals() {
  const meals = await getMeals();
  return <MealsGrid meals={meals} />;
}
...
<Suspense fallback={<p className={classes.loading}>Fetching meals...</p>}>
  <Meals />
</Suspense>
```

## Caching

```bash
npm run build
npm start
```

- `npm run build`: Next.js 앱이 배포 환경에서 동작할 수 있게 준비. 기본적으로 서버에 배포할 수 있는 프로젝트를 만들어 준다.
- `npm start`: 최적화된 코드의 배포 서버를 실행

Next.js는 백그라운드에서 사용자가 접속한 모든 페이지의 데이터까지 캐싱한다.  
그래서 처음 데이터를 불러올 때 오래걸렸던 페이지도 2번째 방문부터는 빠르게 보여줄 수 있다.

이러한 캐싱 때문에 개발 환경에서 경험할 수 없었던 배포 환경의 문제점이 존재한다.
서버를 실행하고 데이터를 입력하면 방금 저장한 데이터를 볼 수 없다.  
Next.js는 배포 환경을 위해 앱을 준비할 때, 동작할 때 거치는 추가 단계가 있다.  
build process에서 앱에서 Pre-render(사전 렌더)될 수 있는 모든 페이지를 사전 렌더링하고 기본적으로 동적 웹페이지가 아니게 된다.  
즉, 모든 데이터를 불러오고 렌더링하는 것이다. 그래서 웹 사이트의 가장 첫 방문자도 렌더링을 기다릴 필요없이 바로 완성된 페이지를 볼 수 있다. 그 다음 사전 렌더링된 페이지를 캐싱하여 모든 사용자에게 제공한다.  
이 방식의 단점은 빌드 프로세스 이후에 등록된 데이터를 다시 가져오지 않는 것이다. 그냥 사전 렌더링된 페이지를 이용한다.

### Triggering Cache Revalidations

**유효성 재검사 트리거**

새로운 데이터를 등록할 때마다 Next.js에 캐시의 전체나 일부를 비우라고 해야한다.  
내장된 메서드를 사용하면 되며 Server Action에서 데이터를 저장(`saveMeal`)하고 리다이렉트(`redirect()`)하기 전에 사용한다.
revalidate(유효성 재검사)의 의미는 해당 페이지에 연관된 캐시를 비우는 것을 의미한다.
`'next/cache'`에서 import한다.

[API Reference](https://nextjs.org/docs/app/api-reference/functions/revalidatePath)

```javascript
import { revalidatePath } from "next/cache";

await saveMeal(meal);
revalidatePath("/meals");
redirect("/meals");
```

- `revalidatePath()`: Next.js가 특정 path에 속하는 캐시의 유효성 재검사를 하게 한다. 기본값으로 해당 path만 적용되고 중첩된 path는 적용하지 않는다.
  - `path`: 첫 번째 인수. 유효성 재검사할 path
  - `type`: 두 번째 인수. 기본 값은 `page`이고 이 path의 이 페이지만 재검사한다는 뜻이다. `layout`으로 설정하면 중첩된 모든 페이지를 재검사한다.
- `revalidatePath('/', 'layout')`: 웹 사이트의 모든 페이지를 유효성 재검사

### Local File System에 파일 저장 금지

바로 위에서 `revalidatePath()`으로 유효성 재검사를 실행하여 실시간으로 데이터 불러오기에 성공했다.  
이미지만 제외하고...

public 폴더안의 images 폴더에 저장하고 있기 때문에 이미지가 보이지 않는 것이다.  
개발 환경에서는 public 접근할 수 있지만 배포 환경은 `.next` 폴더에 복사되고  
이 `.next` 폴더 안에 캐싱된 페이지 등이 모두 들어있고 배포 환경은 `.next` 폴더가 사용된다.  
그런데 새로운 이미지를 public 폴더에 저장하면 배포 서버는 해당 폴더에 관여하지 않기 때문에 request time(or runtime)에 이미지를 불러올 수 없다.

Next.js(또는 React) 프로젝트에서 public 폴더는 source이지 definition이 아니기 때문이다.  
즉, 클라이언트에게 제공할 원본(source)이어야 하지 클라이언트가 접근하는 목적지여서는 안된다.

이러한 동작은 [공식 문서](https://nextjs.org/docs/pages/building-your-application/optimizing/static-assets)에 설명되어 있고 런타임에 생성된 모든 파일은 AWS S3와 같은 파일 저장 서비스를 이용하는 것을 권장하고 있다.

## Error Handling

`error` 페이지를 추가할 수 있다. 이 역시 중첩 가능하고 원하는 경로에만 부분적으로 적용할 수 있다.
발생한 에러의 자세한 정보는 Next.js가 전달하는 `error` prop을 이용한다.  
이 prop은 엔드유저에게 노출되지 않는다.

`error` 컴포넌트는 클라이언트 컴포넌트이어야 한다. Next.js는 기본적으로 클라이언트 측에서  
발생하는 오류를 포함한 해당 컴포넌트의 모든 오류를 잡을 수 있도록 보장하기 때문이다.  
즉, 페이지가 서버에서 렌더링된 후에 수행한다.

```javascript
"use client";

export default function Error({ error }) {
  return (
    <main className="error">
      <h1>An error occurred!</h1>
      <p>Failed to fetch meal data. Please try again later.</p>
    </main>
  );
}
```

## Not Found

`not-found` 페이지를 추가하여 사용자가 존재하지 않는 URL을 입력했을 때(`404`) 대처할 수 있다.  
이 또한 원하는 부분만 중첩하여 적용할 수 있다.

```javascript
export default function NotFound() {
  return (
    <main className="not-found">
      <h1>Not found</h1>
      <p>Unfortunately, we could not find the requested page or resource.</p>
    </main>
  );
}
```

사용자가 존재하지 않는 데이터(meal, community 등)에 접근하려할 때 `undefined`이므로 에러 페이지가 렌더링된다.  
하지만 이것은 기술적인 측면에서 에러가 아니라 요청한 메뉴를 찾지못한 것 뿐이므로 Not Found를 보여주는 것이 합당하다.  
`next/navigation`에서 `notFound` 함수를 import하여 호출하면 해당 컴포넌트의 실행을 멈추고 가장 가까운 `not-found`나 `error` 페이지를 보여준다.  
`not-found` 파일을 중첩하여 특정 메뉴에 최적화된 화면을 보여줄 수 있다.

```javascript
import { notFound } from "next/navigation";

if (!meal) {
  notFound();
}
```

## Dynamic routing

url에 인코딩된 slug(Dynamic parameters)가 필요하다면 `params` props를 사용하여 해당 경로에 대해 구성된 동적 경로 세그먼트가 키-값 쌍으로 저장된 객체에 접근할 수 있다.

```javascript
import { getMeal } from "@/lib/meals";

export default function Page({ params }) {
  const meal = getMeal(params.mealSlug);
  ...
  <h1>{meal.title}</h1>
}
```

## HTML Output

리액트에서 제공하는 `dangerouslySetInnerHTML` 속성으로 Element에 HTML 코드를 출력할 수 있다.  
컨텐츠를 HTML로 출력하면 Cross Site Scripting(XSS) 공격에 노출되기 때문에 주의해야 한다.

이 속성은 객체를 값으로 가져야 하고 이 객체가 가진 `__html` 속성에 실제 화면에 표시할 HTML 코드를 작성한다.  
만약 가져온 HTML 코드에 줄바꿈이 적용되어 있지 않다면 `replace()`를 사용해서 줄바꿈 문자(`\n`)를 `<br>`로 치환한다.

```javascript
// replace()를 사용하여 줄바꿈 문자(\n)를 <br>로 변경
meal.instructions = meal.instructions.replace(/\n/g, '<br>')
  ...
<p
  className={classes.instructions}
  dangerouslySetInnerHTML={{
    // __html: '...',
    __html: meal.instructions,
  }}
></p>
```

## Custom Image Picker

image picker는 사용자가 form에 추가할 사진을 고르게 하고 form을 접수할 때 이미지를 업로드하는 역할을 한다.  
복잡하기 때문에 별도의 컴포넌트로 구성하는 것이 좋다.

```javascript
"use client";
export default function ImagePicker({ label, name }) {
  const imageInput = useRef();
  const [pickedImage, setPickedImage] = useState();

  function handlePickClick() {
    imageInput.current.click();
  }

  function handleImageChange(e) {
    const file = e.target.files[0];

    if (!file) {
      setPickedImage(null);
      return;
    }

    const fileReader = new FileReader();
    fileReader.onload = () => {
      setPickedImage(fileReader.result);
    };
    fileReader.readAsDataURL(file);
  }

  return (
    <div className={classes.picker}>
      <label htmlFor={name}>{label}</label>
      <div className={classes.controls}>
        <div className={classes.preview}>
          {!pickedImage && <p>No image picked yet.</p>}
          {pickedImage && (
            <Image
              src={pickedImage}
              alt="The image selected by the user."
              fill
            />
          )}
        </div>
        <input
          className={classes.input}
          type="file"
          id={name}
          accept="image/png, image/jpeg"
          name={name}
          ref={imageInput}
          onChange={handleImageChange}
          required
        />
        <button
          className={classes.button}
          type="button"
          onClick={handlePickClick}
        >
          Pick an Image
        </button>
      </div>
    </div>
  );
}
```

- `className`: `<input>` 태그를 `display: none`으로 설정하는 CSS가 작성되어 있음
- `htmlFor`: `<label>` 태그를 `<input>` 태그에 연결시키기 위한 `<input>` 태그의 id
- `type="file"`: 파일을 선택하기 위한 `<input>`의 타입
  - `e.target.files`: `file` type의 `<input>`에 자동 생성되는 선택된 모든 파일의 배열
  - `multiple`: 사용자가 여러 개의 파일을 선택할 수 있게 하는 속성
- `type="button"`: 기본적으로 form을 제출해버리는 `<button>` 태그의 동작을 막기 위한 속성
- `accept`: `<input>`에서 접수할 수 있는 파일의 형식 지정
- `name`: 업로드한 이미지를 지정하는 작업에 필요
- `onClick`: 클릭 이벤트를 핸들링하기 위한 속성. 이벤트 핸들러는 클라이언트 측에서만 사용
- `ref`: `<input>`에 클릭 이벤트를 전달하기 위해 사용한 React built in 속성
- `imageInput`: HTML Element를 연결하기 위한 `'react'`의 `useRef()` 훅으로 생성한 `ref`
  - `.current`: 실제로 연결된 element와 object에 접근하기 위해 사용
  - `.click()`: 클릭 메서드 작동
- `pickedImage`: 선택한 이미지를 preview하기 위한 state
- `onChange`: 해당 element의 이벤트에 변화가 생길 때마다 작동하는 이벤트 핸들러
- [`FileReader`](https://developer.mozilla.org/ko/docs/Web/API/FileReader): 이미지 element의 입력값으로 사용되는(`src`로 쓸 수 있는) Data URL을 생성하기 위한 JavaScript built in 클래스
  - `readAsDataURL()`: Promise, read file 등을 포함하여 아무것도 반환하지 않고 callback도 없다. 오직 읽기 동작을 수행한다.
  - `onload`: `FileReader` 객체의 속성. 값을 지정하여 Data URL을 얻을 수 있다. [`load`](https://developer.mozilla.org/ko/docs/Web/API/Window/load_event)의 이벤트 핸들러로, 읽기 동작이 성공적으로 수행될 때마다 발생한다.
  - `result`: `FileReader` 객체의 속성. Data URL이 담겨있다.
  - 실행 순서: `readAsDataURL()` 메서드가 완료되면 `onload`에 저장된 함수가 `FileReader`에 의해 실행된다.

## Server Action

`form`의 submit 제어는 기존 리액트처럼 `onSubmit` 속성에 함수를 정의하여 `form`이 제출될 때 실행되게 할 수 있다.  
그 함수에서 브라우저 기본 동작을 막고 직접 모든 데이터를 수집하여 백엔드로 보낼 것이다.  
그러나 Next.js 프로젝트는 이미 백엔드와 프론트엔드를 모두 가지고 있으므로 이렇게할 필요가 없다.  
Server Action은 바닐라 리액트에도 존재하지만 서버 컴포넌트와 비슷하게 제대로 작동하지 않는다.  
Next.js 같은 프레임워크로 기능의 제한을 풀어주어야 한다.

`form`이 있는 컴포넌트에 함수를 만들고 특별한 지시어 `'use server'`과 `async` 키워드를 추가한다.  
함수 body에 `'use server'`를 선언하면 서버에서만 작동하는 것을 보장하는 Server Action을 생성한다.  
컴포넌트는 기본적으로 서버 컴포넌트인 것과 다르게 함수는 Server Action임을 명시해주어야 한다.
그리고 `form`의 `action` 속성 값에 해당 함수를 설정한다.

Server Action은 해당 컴포넌트가 서버 컴포넌트일 때만 사용할 수 있다.  
따라서, 클라이언트 컴포넌트에서 사용해야 하거나 서버측의 `form` 제출 제어 로직을 JSX 코드와 분리하고 싶을 수도 있다.  
이때는 Server Action을 다른 파일에 저장하고 해당 파일의 최상단에 `'use server'`를 작성하면 된다.  
그러면 해당 파일에서 정의하는 모든 함수가 Server Action이 된다.

```javascript
asycn function shareMeal() {
  "use server";
  const meal = {
    title: formData.get('title')
  }

  await saveMeal(meal)
  redirect('/meals')
}

<form action={shareMeal}></form>
```

- `action`: 일반적으로 요청을 보낼 path를 설정하는 속성(브라우저에 내장된 `form` 제어 기능의 관점). Next.js에서는 이 `form`이 제출되면 요청을 생성하여 웹사이트를 제공하는 Next.js 서버로 보낸다. 그리고 서버에서 Server Action 함수가 실행된다.
- `formData`: `form`의 `input` 태그들로 모인 데이터가 담긴 객체. JavaScript의 `FormData` Class이다.
  - `get()`: 특정 `input` 필드에 입력된 데이터에 접근하는 메서드. 해당 필드의 `name`으로 구분한다.
- `redirect()`: `'next/navigation'`에서 import한 함수. 사용자를 다른 페이지로 리다이렉션한다. 리다이렉션할 path를 인수로 받는다.

### Server side input validation

사용자가 제출한 입력값이 올바른지 Server side에서 검사해야 한다. 규칙은 더 복잡할 수도 있고 서드 파티 패키지를 사용할 수도 있다.  
많은 입력값에 같은 유효성 검사를 해야한다면 helper 함수를 만들어서 재사용하는 것이 좋다.

```javascript
function isInvalidText(text) {
  return !text || text.trim() === "";
}

if (
  isInvalidText(meal.title) ||
  isInvalidText(meal.summary) ||
  isInvalidText(meal.instructions) ||
  isInvalidText(meal.creator) ||
  isInvalidText(meal.creator_email) ||
  !meal.creator_email.includes("@") ||
  !meal.image ||
  meal.image.size === 0
) {
  throw new Error("Invalid input.");
}
```

- `trim()`: 문자열 앞, 뒤의 공백 제거
- `includes()`: 특정 문자열이 존재하는지 체크

### Server Action Response

유효성 검사를 더 좋은 방식으로 바꾸기 위해 리다이렉트나 에러 발생도 가능하지만 `response` 객체를 반환할 수도 있다.  
반환하는 객체는 정해진 형식은 없지만 직렬화 가능한 객체이어야만 한다. 객체에 메서드를 정의하면 안된다는 의미다.  
왜냐하면 클라이언트로 전달되는 동안 손실 가능성이 있기 때문이다. 문자열이나 숫자, 중첩 객체, 중첩 배열 등의 단순 값들은 잘 동작한다.

```javascript
if (
  ...
  meal.image.size === 0
) {
  return {
    message: "Invalid input."
  }
}
```

Server Action을 사용한 컴포넌트에서 `response`를 사용하기 위해 `react`의 `useActionState` 훅을 이용한다.  
이 훅은 Server Actions를 통해 제출될 form을 사용하는 페이지나 컴포넌트의 상태를 관리한다.
클라이언트 컴포넌트에서 사용할 수 있는 훅이다. 이 역시 별도의 컴포넌트로 분리할 수 있다.

```javascript
import { useActionState } from "react";

export default function ShareMealPage() {
  const [state, formAction] = useActionState(shareMeal, { message: null });

  return (
    <form className={classes.form} action={formAction}>
      ...
      {state.message && <p>{state.message}</p>}
    </form>
  );
}
```

- `useActionState()`: form이 제출될 때 동작할 실제 Server Action과 컴포넌트의 초기 state(server action이 동작하기 전이나 response가 돌아오기 전에 `useActionState`가 반환할 초기 값을 의미) 두 개의 인수를 받는다.  
  두 개의 요소가 있는 배열을 반환한다. 이 컴포넌트의 현재 상태(혹은 현재 response)와 `formAction`이다.
  - `state`: 두 번째 인수인 초기값이거나 Server Action(`shareMeal`)으로부터 받은 응답이 된다.
  - `formAction`: form의 `action` 속성에 값으로 설정하면 `useActionState` 훅이 접근해서 state를 관리할 수 있다.

Server Action(`shareMeal`)도 수정이 필요하다. 왜냐하면 `useActionState`에 인수로 넘길 때에는 `useActionState`가 form을 제출하고 Server Action을 실행시키기 위해 두 가지 인수를 넘기기 때문이다.

```javascript
export async function shareMeal(prevState, formData) {
  ...
}
```

- `shareMeal(prevState, formData)`: `useActionState`의 인수로 넘겨진 Server Action은 이전의 상태와 제출된 `FormData` 두개의 인수를 받아야 한다. 이전의 상태는 사용하지 않아도 받아야만 한다. 왜냐하면 두 번째 인수가 `FormData`로 설정되어 있기 때문이다.

## `form` 제출 상태 관리

사용자 경험 개선을 위해 데이터가 제출되는 동안 정상 동작중임을 보여주는 피드백이 있으면 좋다.  
리액트에서 제공하지만 Next.js에서 제대로 사용할 수 있는 기능인 `useFormStatus` 훅으로 구현할 수 있다.  
`react-dom`에서 import하며 클라이언트 컴포넌트에서 사용할 수 있다.

status를 받길 원하는 `form` 안에 선언해야 해당 `form`의 status를 받을 수 있다.  
즉, `form` 안에 별도의 컴포넌트를 넣고 해당 컴포넌트에서 훅을 사용해야 한다.

```javascript
"use client";
import { useFormStatus } from "react-dom";

export default function MealsFormSubmit() {
  const { pending } = useFormStatus();

  return (
    <button disabled={pending}>
      {pending ? "Submitting..." : "Share Meal"}
    </button>
  );
}
```

- `useFormStatus()`: `status` 객체를 반환
- `status`: 다양한 속성을 갖고 있는 객체
  - `pending`: 요청이 진행중이면 `true` 아니면 `false` 값을 가지는 속성
- `disabled`: 버튼의 활성화 상태를 제어하는 속성. `true`이면 비활성화, `false`이면 활성화

## Parallel Routes

별도의 route를 가지는 여러 개의 컨텐츠를 동일한 페이지에서 렌더링하는 것  
병렬 라우트를 추가하려는 경로(폴더)에 레이아웃을 추가해야 한다. 또한, 병렬 라우트마다 하나의 하위 폴더를 추가한다.  
이때 병렬 라우트의 폴더 이름은 `@`으로 시작한다.

```bash
archive
    ├─@archive
    ├─@latest
    └─layout.js
```

Next.js는 인접한 경로에 있는 `layout` 컴포넌트에 병렬 라우트를 prop으로 전달한다.  
이제 `layout` 컴포넌트는 `children`뿐만 아니라 위에서 만든 병렬 라우트도 prop으로 받는다.  
병렬 라우트 prop의 이름은 해당 폴더의 `@` 뒤의 이름과 동일하다.

```javascript
export default function ArchiveLayout({ archive, latest }) {
  return (
    <div>
      <h1></h1>
      <section id="archive-filter">{archive}</section>
      <section id="archive-latest">{latest}</section>
    </div>
  );
}
```

## Build-in Components

Next.js의 빌트인 컴포넌트의 자세한 정보

### `<Link>`

```javascript
import Link from "next/link";

<Link href="/about">About Us</Link>;
```

> Good to know:
> `className` 또는 `target="_blank"`와 같은 `<a>` 태그의 속성은 `<Link>`에 props로 추가할 수 있으며 내부 `<a>` 요소로 전달된다.

> <details markdown="1">
> <summary>Deep Dive : Link 컴포넌트 (React VS Next.js)</summary>
>
> 1. 라이브러리
>
> - React : `react-router-dom`
> - Next.js : `next/link`
>
> 2. 경로 설정
>
> - React : `<Link to="/about" />`
> - Next.js : `<Link href="/about">About Us</Link>`
>
> 3. 페이지 로드 방식
>
> - React : 페이지 전체를 로드하지 않고 내부적으로 필요한 컴포넌트 리렌더
> - Next.js : 페이지 전환 시 자동으로 해당 페이지를 미리 로드하는 Prefetch 기능으로 빠른 로딩 가능
>
> [Web: Next.js Link와 Prefetch 과정 파헤쳐보기](https://medium.com/hcleedev/web-next-js-link와-prefetch-과정-파헤쳐보기-44e22ace13e7)
>
> </details>

#### Props

| Prop     | Example             | Type             | Required |
| :------- | :------------------ | :--------------- | :------- |
| href     | `href="/dashboard"` | String or Object | Yes      |
| replace  | `replace={false}`   | Boolean          | -        |
| scroll   | `scroll={false}`    | Boolean          | -        |
| prefetch | `prefetch={false}`  | Boolean or null  | -        |

##### `href` (required)

탐색할 path 또는 URL

객체를 받을 수도 있다.

```javascript
// Navigate to /about?name=test
<Link
  href={{
    pathname: "/about",
    query: { name: "test" },
  }}
>
  About
</Link>
```

##### `replace`

기본값은 `false`  
`true`일 때, 브라우저 기록 스택([browser’s history](https://developer.mozilla.org/docs/Web/API/History_API))에 새 URL을 추가하는 대신 `next/link`가 현재 기록 상태를 대체한다.

```javascript
// app/page.js

import Link from "next/link";

export default function Page() {
  return (
    <Link href="/dashboard" replace>
      Dashboard
    </Link>
  );
}
```

##### `scroll`

기본값은 `true`
`<Link>`의 기본 동작은 새 라우트의 맨 위로 스크롤하거나, 앞 뒤 탐색을 위해 스크롤 위치를 유지한다.  
`false`일 때, 탐색 후에 `next/link`의 위치가 상단으로 스크롤되지 않는다.

```javascript
import Link from "next/link";

export default function Page() {
  return (
    <Link href="/dashboard" scroll={false}>
      Dashboard
    </Link>
  );
}
```

> Good to know:
> Next.js는 탐색(navigation)할 때 뷰포트(viewport)에 페이지가 표시되지 않으면(not visible) 페이지로 스크롤한다.

##### `prefetch`

Prefetching은 `<Link />` 컴포넌트가 사용자의 뷰포트에 들어갈 때(초기 또는 스크롤을 통해) 발생한다.  
Next.js는 linked route(`href`로 표시됨) 및 해당 데이터를 백그라운드에서 prefetch하여 client-side navigations의 성능을 향상시킨다. Prefetching은 프로덕션 환경에서만 활성화된다.

- null (default): Prefetch 동작은 라우트가 정적인지 동적인지에 따라 달라진다. 정적인 라우트의 경우 전체 경로가 prefetch된다(모든 데이터 포함). 동적인 라우트의 경우 `loading.js` 경계가 있는 가장 가까운 세그먼트까지의 부분 라우트(partial route)가 prefetch된다.
- true: 정적 및 동적 라우트 모두에 대해 전체 라우트가 prefetch됨
- false: 뷰포트에 진입하거나 hover할 때 prefetch가 전혀 발생하지 않음

```javascript
import Link from "next/link";

export default function Page() {
  return (
    <Link href="/dashboard" prefetch={false}>
      Dashboard
    </Link>
  );
}
```

#### Examples

##### Linking to Dynamic Routes

동적 라우트의 경우, link's path를 만들기 위해 템플릿 리터럴(template literals)를 사용하는 것이 편리하다.  
예를 들어, 동적 라우트 `app/blog/[slug]/page.js`에 대한 링크 목록을 생성할 수 있다.

```javascript
// app/blog/page.js

import Link from "next/link";

function Page({ posts }) {
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.id}>
          <Link href={`/blog/${post.slug}`}>{post.title}</Link>
        </li>
      ))}
    </ul>
  );
}
```

##### If the child is a custom component that wraps an `<a>` tag

만약 Link의 자식이 `<a>` 태그를 감싸는 사용자정의 컴포넌트라면, Link에 `passHref`를 추가해야 한다.  
이는 [styled-components](https://styled-components.com/)와 같은 라이브러리를 사용하는 경우에 필요하다.  
이렇게 하지 않으면 `<a>` 태그에 `href` 속성이 없어 사이트의 접근성이 저하되고 SEO에 영향을 줄 수 있다.  
`ESLint`를 사용하는 경우, `passHref`의 올바른 사용을 보장하기 위한 내장 규칙인 `next/link-passhref`가 있다.

```javascript
import Link from "next/link";
import styled from "styled-components";

// This creates a custom component that wraps an <a> tag
const RedLink = styled.a`
  color: red;
`;

function NavLink({ href, name }) {
  return (
    <Link href={href} passHref legacyBehavior>
      <RedLink>{name}</RedLink>
    </Link>
  );
}

export default NavLink;
```

- 만약 [emotion](https://emotion.sh/)의 JSX pragma 기능(@jsx jsx)을 사용하는 경우, 직접 `<a>` 태그를 사용하더라도 `passHref`를 사용해야 한다.
- 컴포넌트는 올바른 네비게이션을 트리거하기 위해 `onClick` 속성을 지원해야 한다.

### `<Image>`

Next.js에서 사용하는 Built-in image element이고, 기본 `<img>` 요소를 대체한다.  
최적화된 방법으로 이미지를 출력할 수 있다. 예를 들어 페이지에서 실제로 보이는 경우에만 표시되도록 추가적인 구성없이 기본적으로 lazy loading으로 구현한다.
또한, 대응적인 이미지를 설정하는 프로세스 등을 단순화한다.

`next/image`에서 import하며, `<img>`와는 다르게 `src` 속성에 값만 받는게 아니라 전체 객체를 받아야 한다.  
왜냐하면 Next.js에 의해 생성된 이미지 객체(`logoImg`)는 최적화된 방법으로 `<Image>` 컴포넌트를 띄울 수 있도록 하는 정보를 포함하기 때문이다.  
예를 들어, 자동으로 이미지의 사이즈를 감지하거나, 사용중인 브라우저에 최적화된 포맷을 판단하는 등의 정보이다.

`<Image>` 컴포넌트로 렌더링된 HTML을 보면 몇 가지 속성을 가지고 있다.

- `loading=lazy` : 이미지가 지연 로딩되도록 한다. 즉, 실제로 보이는 경우에만 로딩된다.
- `width`, `height` : 자동으로 너비와 높이를 추론했다. 원한다면 덮어쓰기 가능하다.
- `srcset` : 뷰포트와 웹사이트를 방문하는 기기에 따라 크기가 조정된 이미지가 로딩되는 것을 보장한다. 또한, 사용중인 브라우저에 알맞는 파일 포맷으로 이미지를 서브(serve)한다.

```javascript
import Image from 'next/image'

import logoImg from '@/assets/logo.png'

// img 태그와의 차이
<img src={logoImg.src} alt="..." />
<Image src={logoImg} alt="..." priority fill />
```

`priority` 속성은 페이지가 로딩될 때 항상 보이는 이미지인 경우 추가한다.  
이 경우에 지연 로딩은 효과가 없고, 불필요한 컨텐츠 변경이나 깜빡임이 없도록 하기 위해 가능한 빠르게 로딩해야 한다.  
해당 속성을 추가한 `<Image>` 컴포넌트는 우선적으로 로딩된다.
예를 들어 third party 웹사이트 등으로부터 이미지를 로딩한다면 해당 속성을 추가하는 것을 권장한다.

`fill` 속성은 Next.js에 해당 컴포넌트의 공간을 부모 컴포넌트에 의해 정의된 이미지로 채워야 함을 알려준다.  
`assets` 폴더처럼 로컬 파일 시스템에서 가져온 파일은 빌드 타임에 크기를 미리 알고 자동으로 처리하지만,  
DB에서 로드한 이미지, 외부 API에서 가져온 이미지처럼 런타임에 가져오기 때문에 크기를 미리 알 수 없는 경우 최고의 대안이다.
외부 API나 DB에서 가져오더라도, 크기를 알고 있다면 `width`, `height`를 명시하는 방법을 사용해도 된다.  
그러나 사용자가 업로드하는 대부분의 이미지는 크기를 예상할 수 없으므로 `fill`을 사용하는 것을 권장한다.

#### Props

| Prop                | Example                                  | Type            | Required   |
| :------------------ | :--------------------------------------- | :-------------- | :--------- |
| `src`               | `src="/profile.png"`                     | String          | Required   |
| `width`             | `width={500}`                            | Integer (px)    | Required   |
| `height`            | `height={500}`                           | Integer (px)    | Required   |
| `alt`               | `alt="Picture of the author"`            | String          | Required   |
| `loader`            | `loader={imageLoader}`                   | Function        |            |
| `fill`              | `fill={true}`                            | Boolean         |            |
| `sizes`             | `sizes="(max-width: 768px) 100vw, 33vw"` | String          |            |
| `quality`           | `quality={80}`                           | Integer (1-100) |            |
| `priority`          | `priority={true}`                        | Boolean         |            |
| `placeholder`       | `placeholder="blur"`                     | String          |            |
| `style`             | `style={{objectFit: "contain"}}`         | Object          |            |
| `onLoadingComplete` | `onLoadingComplete={img => done())}`     | Function        | Deprecated |
| `onLoad`            | `onLoad={event => done())}`              | Function        |            |
| `onError`           | `onError(event => fail()}`               | Function        |            |
| `loading`           | `loading="lazy"`                         | String          |            |
| `blurDateURL`       | `blurDataURL="data:image/jpeg..."`       | String          |            |

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

함수 컴포넌트 안에서 내부 함수(예: 이벤트 핸들러)를 만들 때, 컴포넌트가 렌더링될 때마다 함수가 다시 생성된다. 함수가 props로 전달되거나(또는 컨텍스트를 통해 전달되는 경우) 자식 컴포넌트(밑의 예제에서 `Button`인 경우)로 전달되면 해당 자식도 다시 렌더링된다.

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

[rule: prop-types` rule](https://github.com/jsx-eslint/eslint-plugin-react/blob/master/docs/rules/prop-types.md)

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

### jsx-a11y/label-has-associated-control

JSX 요소의 접근성 강화를 위한 ESLint 규칙으로 `form`의 `label` element가 어떤 form control와 연결되어 있는지 확인한다.  
기본 설정으로는 `htmlFor` 속성으로 연결해줘도 에러가 발생해서 규칙을 수정했다.

```json
"jsx-a11y/label-has-associated-control": [ 2, {
  "some": [ "nesting", "id" ]
}],
```

- `some: []`: 규칙이 하나 이상 만족되어야 함. 배열에는 규칙이 어떻게 적용될지 정의. 여기서는 두 가지 검사 방법을 사용함
  - `nesting`: `label` 요소가 form control을 직접 감싸고 있는지 확인
  - `id`: `label` 요소가 form control과 `htmlFor`, `id` 속성을 통해 연결되어 있는지 확인

## Troubleshooting

### 뒤로가기하면 'use client' 오류가 나타나는 문제

ssr 시에는 데이터가 차서 들어오지만, csr 시(뒤로가기, Link 클릭) 등에는 일시적으로 데이터가 없을 때가 있다.  
아무것도 없는 로딩 페이지를 보여줘서 해결했다.

### You provided a `value` prop to a form field without an `onChange` handler ...

에러의 원인은 간단하게 말해서 `input` 태그에 값의 변화를 감지하는 `onChange` 핸들러가 존재하지 않기 때문이다.

해결 방법:

- `onChange` 핸들러를 사용
- `defaultValue` 속성을 사용
- `readOnly` 속성을 사용
