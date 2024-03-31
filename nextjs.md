# Next.js

Next.js의 정보를 기록해두는 문서

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

- Next.js에서 페이지는 단순한 리액트 함수다.
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

## App router

기존 NextJS는 `/pages` 폴더에 웹 사이트의 모든 페이지를 나타내는 Page Router를 사용했다.  
Next.js 13 버전부터 앱 라우터가 도입되었다.

app 폴더에서 페이지를 설정한다. 이 페이트는 전반적인 웹사이트에 넣고 싶은 페이지를 의미한다.  
`page.js`, `layout.js`라는 보호된 파일이 존재하는데,  
`page.js` 파일은 NextJS에게 해당 페이지를 렌더링해야 한다고 전한다.

`'localhost:3000/about'` 이라는 페이지를 만들고 싶다면,  
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

### Fullstack Framework

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

## layout

`layout.js`(.jsx, .ts) 파일은 page.js와 마찬가지로 특별한 종류의 파일이다.  
page.js 파일이 페이지의 내용을 정의한다면,  
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
route 전반에 걸쳐 지속되고 상태를 유지하는 레이아웃과 달리,  
템플릿은 탐색 시 각 하위 항목에 대해 새 인스턴스를 만든다.

이는 사용자가 템플릿을 공유하는 route 사이를 탐색할 때, 컴포넌트의 새 인스턴스가 마운트되고 DOM 요소가 다시 생성되며  
상태가 유지되지 않고 effects가 다시 동기화됨을 의미한다.  
이러한 특정 동작이 필요한 경우가 있을 수 있으며, 그 경우에 템플릿은 레이아웃보다 더 적합한 선택이다. 예를 들어:

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

메타데이터는 `layout.js` 또는 `page.js` 파일 안에서 [metadata object](https://nextjs.org/docs/app/api-reference/functions/generate-metadata#the-metadata-object)나 [`generateMetadata` function](https://nextjs.org/docs/app/api-reference/functions/generate-metadata#generatemetadata-function)를 exporting하여 정의할 수 있다.

```javascript
export const metadata = {
  title: "Next.js",
};

export default function Page() {
  return "...";
}
```

> Good to know:  
> 루트 레이아웃에는 수동으로 `<title>` 및 `<meta>`와 같은 `<head>` 태그를 추가해서는 안 된다.  
> 대신 Metadata API를 사용해야 한다. Metadata API는 스트리밍(streaming) 및 `<head>` 요소의 중복을 처리(de-duplicating)하는 등 고급 요구 사항을 자동으로 처리한다.

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
일반적인 css 코드이지만 css파일에 특정 이름을 지정하여 특정 컴포넌트로 스코핑된다.  
`.module.css`로 끝나는 css 파일을 추가하면, 그 파일로부터 객체를 불러올 수 있고  
기본 빌드 프로세스 및 개발 서버에 의해 자동으로 생성되며, 해당 파일에서 정의한 모든 css 클래스를 속성 이름으로 접근할 수 있다.

이때 이름은 css를 적용할 `js`, `jsx`, `ts` 파일의 이름과 같아야하고 `.module.css`로 끝나야 한다.
`globals.css`와는 약간 다른 방식으로 import하게 된다.

```javascript
import classes from "./page.module.css";

<Link className={classes.logo} href="/">
```

- import할 변수의 이름은 자유다. 관습적으로 `classes` 또는 `styles`를 사용한다.
- classes 변수는 객체이며, css 파일에 정의한 모든 클래스는 이 객체에서 속성으로 사용된다.
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

### Example

#### Linking to Dynamic Segments

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

#### Checking Active Links

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

#### Scrolling to an `id`

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

#### Disabling scroll restoration

Next.js App router의 기본 동작은 new route로 스크롤을 맨 위로 이동하거나 뒤로/앞으로 탐색 시 스크롤 위치를 유지하는 것이다.  
이 동작을 비활성화하려면 `<Link>` 컴포넌트에 `scroll={false}`를 전달하거나 `router.push()` 또는 `router.replace()`에 `scroll: false`를 전달할 수 있다.

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

## Build-in Components

Next.js의 빌트인 컴포넌트의 자세한 정보를 모아두는 섹션

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

## Next.js의 폴더 구조

Next.js 13에서 추가된 App router는 폴더내에 `page.js` 파일을 작성했을 때 해당 폴더의 이름으로 route 된다.

- 페이지들이 다른 폴더(페이지가 아닌)와 같은 depth에 위치하여 어떤 폴더가 페이지인지 구별하기 어려울 수 있다.
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
