# Material UI
구글의 디자인 가이드라인을 따라 만든 오픈소스 스타일링 컴포넌트 라이브러리

## Grid

클라이언트 사이드 종속성: Grid 컴포넌트는 클라이언트 사이드 JavaScript에 의존하는 동적 기능을 포함하고 있습니다. 서버에서는 이러한 기능을 실행할 수 없습니다.
브라우저 API 사용: Grid 컴포넌트는 내부적으로 window 객체나 다른 브라우저 전용 API를 사용할 수 있습니다. 이러한 API는 서버 환경에서 사용할 수 없습니다.
동적 스타일 계산: Grid 시스템은 종종 뷰포트 크기에 따라 동적으로 스타일을 계산합니다. 서버에서는 이러한 계산을 수행할 수 없습니다.
'use client' 지시문 누락: Next.js 13 이상에서는 클라이언트 컴포넌트에 'use client' 지시문을 추가해야 합니다.

## TextField

TextField를 textarea로 설정하고 maxLength를 부여하는 방법은 다음과 같습니다:

1. TextField 컴포넌트를 사용하여 textarea를 생성합니다.
2. `multiline` 속성을 `true`로 설정하여 textarea 모드로 전환합니다.
3. `maxRows` 속성을 사용하여 최대 행 수를 지정할 수 있습니다.
4. `inputProps` 속성을 통해 `maxLength`를 설정합니다.

다음은 이를 구현한 코드 예시입니다:

```tsx
import { TextField } from '@mui/material';
import { ChangeEvent, useState } from 'react';

const TextAreaComponent = () => {
  const [value, setValue] = useState('');
  const maxLength = 100;

  const handleChange = (event: ChangeEvent<HTMLInputElement>) => {
    setValue(event.target.value.slice(0, maxLength));
  };

  return (
    <TextField
      multiline
      maxRows={4}
      value={value}
      onChange={handleChange}
      inputProps={{ maxLength: maxLength }}
      helperText={`${value.length}/${maxLength}`}
      fullWidth
    />
  );
};

export default TextAreaComponent;
```

이 코드는 다음과 같은 기능을 제공합니다:

1. TextField를 multiline 모드로 설정하여 textarea로 작동하게 합니다[1].
2. `maxRows={4}`를 통해 최대 4줄까지 표시되도록 설정합니다[1].
3. `inputProps={{ maxLength: maxLength }}`로 최대 글자 수를 100자로 제한합니다[1][4].
4. `onChange` 핸들러에서 `event.target.value.slice(0, maxLength)`를 사용하여 입력값이 최대 길이를 초과하지 않도록 합니다[1].
5. `helperText`를 사용하여 현재 입력된 글자 수와 최대 글자 수를 표시합니다[1].

이 방법을 사용하면 사용자가 최대 글자 수를 초과하여 입력할 수 없으며, 현재 입력된 글자 수를 실시간으로 확인할 수 있습니다. 또한 TypeScript를 사용하여 타입 안정성을 보장합니다.