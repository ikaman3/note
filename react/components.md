# 컴포넌트

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

## export, import

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