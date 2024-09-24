# Typescript

## 타입 시스템

TS는 정적 타입 시스템을 제공합니다. 변수의 타입을 명시적으로 선언할 수 있습니다.

```typescript
// 변수 선언
let age: number = 25
let username: string = 'John Doe'
let isStudent: boolean = true

// 배열
let numbers: number[] = [1, 2, 3, 4, 5]

// 객체
let person: { name: string; age: number } = {
  name: 'Jane Doe',
  age: 30,
}

// 함수
function greet(name: string): string {
  return `Hello, ${name}!`
}
```

## 인터페이스와 타입

인터페이스와 타입 별칭을 사용하여 복잡한 타입을 정의할 수 있습니다.

```typescript
// 인터페이스
interface Person {
  name: string
  age: number
}

let person: Person = {
  name: 'Alice',
  age: 28,
}

// 타입 별칭
type Point = {
  x: number
  y: number
}

let point: Point = {
  x: 10,
  y: 20,
}
```

## 타입 정의

```typescript
import { ReactNode } from 'react'
import { Metadata } from 'next'

// 메타데이터 생성 함수 타입
export type GenerateMetadata = (props: {
  params: { [key: string]: string }
  searchParams: { [key: string]: string | string[] | undefined }
}) => Promise<Metadata> | Metadata

// 라우트 세그먼트 설정 타입
export type RouteSegmentConfig = {
  dynamic?: 'auto' | 'force-dynamic' | 'error' | 'force-static'
  revalidate?: 'force-cache' | number
  fetchCache?:
    | 'auto'
    | 'default-cache'
    | 'only-cache'
    | 'force-cache'
    | 'force-no-store'
  runtime?: 'nodejs' | 'edge'
  preferredRegion?: string | string[]
}

// 기본 페이지 props 타입 정의
// 추가 파라미터가 필요없는 경우 사용
export type BasePageProps = {
  children?: ReactNode
  searchParams?: { [key: string]: string | string[] | undefined }
  params?: { [key: string]: string }
}

// 추가 props를 위한 제네릭 타입
export type PageProps<T = {}> = BasePageProps & T

// 레이아웃 props 타입 정의
export type LayoutProps = {
  children: ReactNode
}

// 기능별 컴포넌트 props 타입 정의
// 필요한 prop을 제네릭으로 추가하여 사용 가능
// <T = {}>: 이 부분은 제네릭 타입 매개변수를 정의합니다.
// = {}: 기본값으로 빈 객체를 설정합니다. 즉, 추가 props가 지정되지 않으면 빈 객체가 사용됩니다.
export type CreatePageProps<T = {}> = PageProps<T>
export type ViewPageProps<T = {}> = PageProps<T>
export type UpdatePageProps<T = {}> = PageProps<T>
export type ListPageProps<T = {}> = PageProps<T>
```

예시:

```typescript
// 추가 props 없는 경우
const UsersListPage = ({ searchParams, params }: ListPageProps) => {...}

// 추가 props 있는 경우: 상세조회
type UserDetailProps = ViewPageProps<{
  user: {
    id: string;
    name: string;
    email: string;
  };
}>;

const UserDetailPage = ({ searchParams, params, user }: UserDetailProps) => {...}

// 추가 props 있는 경우: 등록
type CreateUserProps = CreatePageProps<{
  onSubmit: (userData: { name: string; email: string }) => void;
}>;

const CreateUserPage = ({ searchParams, params, onSubmit }: CreateUserProps) => {...}

// 레이아웃
const RootLayout = ({ children }: LayoutProps) => {...}

// 메타데이터
export const generateMetadata = async ({ params, searchParams }: GenerateMetadata) => {
  return {
    title: 'User List',
    description: 'List of all users',
  };
};
```

### type과 interface의 차이점

1. 확장성:
   - interface는 extends 키워드를 사용해 확장할 수 있습니다.
   - type은 & 연산자를 사용해 교차 타입으로 확장과 유사한 기능을 구현할 수 있습니다.
2. 선언 병합:
   - interface는 동일한 이름으로 여러 번 선언하면 자동으로 병합됩니다.
   - type은 재선언할 수 없습니다.
3. 표현력:
   - type은 유니온, 교차 타입, 조건부 타입 등 더 다양한 타입을 표현할 수 있습니다.
   - interface는 객체 형태의 타입만 정의할 수 있습니다.
4. 암시적 인덱스 시그니처:
   - type은 `Record<PropertyKey, unknown>`의 암시적 인덱스 시그니처를 가집니다.

일반적으로 객체 타입을 정의할 때는 type과 interface 모두 사용 가능하지만,  
유니온이나 교차 타입 등 복잡한 타입이 필요한 경우 type을 사용해야 합니다.  
객체 상속 구조를 표현할 때는 interface가 더 적합할 수 있습니다.
개인적인 선호도에 따라 선택할 수 있지만, type의 유연성과 예측 가능성 때문에 기본적으로 type을 사용하고 필요한 경우에만 interface를 사용하는 것이 권장됩니다

### 암시적 인덱스 시그니처

암시적 인덱스 시그니처는 TypeScript에서 객체의 속성에 접근할 때 타입을 명시적으로 선언하지 않아도 되는 경우를 의미합니다. 이는 주로 객체의 키와 값을 동적으로 처리할 때 유용합니다. 인덱스 시그니처는 객체가 여러 키를 가질 수 있으며, 이 키와 매칭되는 값을 가지는 경우 사용됩니다.
인덱스 시그니처의 기본 형태
인덱스 시그니처는 다음과 같은 형태로 정의됩니다:

```typescript
type Example = {
  [key: string]: number
}
```

위의 예제에서 Example 타입은 문자열 키를 가지며, 각 키에 대응하는 값은 숫자 타입입니다. 이는 객체의 모든 키-값 쌍이 특정 타입을 따르도록 보장합니다.
예제
다음은 인덱스 시그니처를 사용하여 객체의 모든 값을 합산하는 함수의 예제입니다:

```typescript
function totalPay(payment: { [key: string]: number }): number {
  let total = 0
  for (const key in payment) {
    total += payment[key]
  }
  return total
}

const salaries = {
  salary: 2000,
  bonus: 500,
  incentive: 300,
}

console.log(totalPay(salaries)) // 2800
```

위 함수 totalPay는 키가 문자열이고 값이 숫자인 객체를 인자로 받습니다. 이 함수는 객체의 모든 값을 합산하여 반환합니다.
인덱스 시그니처의 유용성
인덱스 시그니처는 다음과 같은 상황에서 유용합니다

동적 속성 접근: 객체의 키가 동적으로 결정되는 경우.  
유연한 타입 정의: 객체의 속성이 미리 정의되지 않고 런타임에 결정되는 경우.  
타입 안전성: 객체의 모든 키-값 쌍이 특정 타입을 따르도록 보장하여 타입 안전성을 높입니다.

예제: 유니온 타입과 함께 사용  
인덱스 시그니처는 유니온 타입과 함께 사용할 수도 있습니다:

```typescript
type StringOrNumber = string | number

interface Example {
  [key: string]: StringOrNumber
}

const example: Example = {
  name: 'Alice',
  age: 30,
  isStudent: false, // 오류: boolean 타입은 허용되지 않음
}
```

위 예제에서 Example 인터페이스는 문자열 키를 가지며, 각 키에 대응하는 값은 문자열 또는 숫자 타입이어야 합니다. boolean 타입의 값은 허용되지 않으므로 오류가 발생합니다.
결론
암시적 인덱스 시그니처는 TypeScript에서 객체의 키와 값을 동적으로 처리할 때 매우 유용한 기능입니다. 이를 통해 객체의 타입 안전성을 유지하면서도 유연한 타입 정의가 가능합니다. 인덱스 시그니처를 적절히 활용하면 더 안전하고 유지보수하기 쉬운 코드를 작성할 수 있습니다.

## 제네릭

제네릭을 사용하면 다양한 타입을 처리할 수 있는 함수를 작성할 수 있습니다.

```typescript
function identity<T>(arg: T): T {
  return arg
}

let output1 = identity<string>('Hello')
let output2 = identity<number>(42)
```

## 유니온 타입과 인터섹션 타입

유니온 타입은 여러 타입 중 하나를 가질 수 있는 변수를 정의합니다.

```typescript
let value: string | number
value = 'Hello'
value = 42
```

인터섹션 타입은 여러 타입을 결합합니다.

```typescript
interface A {
  a: string
}

interface B {
  b: number
}

type C = A & B

let obj: C = {
  a: 'Hello',
  b: 42,
}
```

## 커스텀 훅에 TS 적용

```typescript
import { useState } from 'react'

function useCounter(initialValue: number) {
  const [count, setCount] = useState<number>(initialValue)

  const increment = () => setCount(count + 1)
  const decrement = () => setCount(count - 1)

  return { count, increment, decrement }
}

export default useCounter
```

```typescript
// hooks/useLocalStorage.ts
import { useState, useEffect } from 'react'

function useLocalStorage<T>(
  key: string,
  initialValue: T,
): [T, (value: T) => void] {
  const [storedValue, setStoredValue] = useState<T>(initialValue)

  useEffect(() => {
    const item = window.localStorage.getItem(key)
    if (item) {
      setStoredValue(JSON.parse(item))
    }
  }, [key])

  const setValue = (value: T) => {
    setStoredValue(value)
    window.localStorage.setItem(key, JSON.stringify(value))
  }

  return [storedValue, setValue]
}

export default useLocalStorage
```

## form 처리

```typescript
// components/ContactForm.tsx
import { FC, useState, FormEvent } from 'react'

interface FormData {
  name: string
  email: string
  message: string
}

const ContactForm: FC = () => {
  const [formData, setFormData] = useState<FormData>({
    name: '',
    email: '',
    message: '',
  })

  const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    console.log('Form submitted:', formData)
    // 여기서 폼 데이터를 처리합니다 (예: API 요청 등)
  }

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => {
    const { name, value } = e.target
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }))
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        name="name"
        value={formData.name}
        onChange={handleChange}
        placeholder="Name"
      />
      <input
        type="email"
        name="email"
        value={formData.email}
        onChange={handleChange}
        placeholder="Email"
      />
      <textarea
        name="message"
        value={formData.message}
        onChange={handleChange}
        placeholder="Message"
      />
      <button type="submit">Send</button>
    </form>
  )
}

export default ContactForm
```

## API 호출 결과 타입 정의

```typescript
import axios from 'axios'

interface User {
  id: number
  name: string
  email: string
}

async function fetchUsers(): Promise<User[]> {
  const response = await axios.get<User[]>('https://api.example.com/users')
  return response.data
}
```

## 페이지 컴포넌트 타입 지정

App Router에서 페이지 컴포넌트는 일반적으로 다음과 같이 타입을 지정합니다:

// app/page.tsx

```typescript
import { Metadata } from 'next'

type Props = {
  params: { id: string }
  searchParams: { [key: string]: string | string[] | undefined }
}

export const metadata: Metadata = {
  title: 'My Page',
}

const Page = ({ params, searchParams }: Props) => {
  return <h1>My Page</h1>
}

export default Page
```

### Props 타입: 제네릭 VS 파라미터

1. 문법적 차이

`const Component: React.FC<Props> = ({ prop1, prop2 }) => { ... }`
`const Component = ({ prop1, prop2 }: Props) => { ... }`

2. 타입 추론

- 제네릭: React.FC를 통해 컴포넌트 함수의 반환 타입을 자동으로 React.ReactElement로 추론합니다.
- 파라미터 선언: 반환 타입을 명시적으로 지정해야 할 수 있습니다.

3. children prop:

- React.FC를 사용하면 children prop이 자동으로 포함됩니다.
- 파라미터 선언 방식에서는 children을 명시적으로 선언해야 합니다.

4. 유연성:

- 파라미터 선언 방식이 더 유연합니다. 예를 들어, 함수 오버로딩이 가능합니다.
- 제네릭 방식은 React.FC의 제약 사항을 따라야 합니다.

5. 명시성:

- 파라미터 선언 방식이 props의 구조를 더 명확하게 보여줍니다.
- 제네릭 방식은 props 타입을 별도로 정의해야 합니다.

6. 커스텀 속성 추가:

- 파라미터 선언 방식에서는 컴포넌트 함수에 쉽게 커스텀 속성을 추가할 수 있습니다.
- React.FC를 사용하면 커스텀 속성 추가가 제한될 수 있습니다.

## API 라우트 타입 지정

API 라우트에서는 NextRequest와 NextResponse를 사용하여 타입을 지정합니다:

```typescript
// app/api/hello/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const id = searchParams.get('id')
  return NextResponse.json({ id })
}

export async function POST(request: NextRequest) {
  const body = await request.json()
  return NextResponse.json({ receivedData: body })
}
```

```typescript
// app/page.tsx
import { FC } from 'react'

interface PageProps {
  params: { id: string }
}

const Page: FC<PageProps> = ({ params }) => {
  return <div>Page ID: {params.id}</div>
}

export default Page
```

### 파일 내부에 정의하는 경우:

장점:  
해당 페이지에 특화된 타입을 쉽게 정의할 수 있습니다.  
파일 간 의존성이 줄어듭니다.  
각 페이지의 타입을 빠르게 확인할 수 있습니다.  
단점:  
여러 페이지에서 비슷한 타입을 반복해서 정의할 수 있습니다.

### 외부에서 export하는 경우:

장점:  
코드 재사용성이 높아집니다.  
타입 정의를 중앙에서 관리할 수 있어 일관성 유지가 쉽습니다.  
여러 페이지에서 공통으로 사용되는 타입을 쉽게 업데이트할 수 있습니다.  
단점:  
파일 간 의존성이 증가할 수 있습니다.  
매우 특정한 페이지 타입의 경우 공통 타입을 확장해야 할 수 있습니다.  
일반적으로 권장되는 접근 방식:

### 공통 타입 정의:

자주 사용되는 기본적인 페이지 props 타입은 외부 파일에서 정의하고 export합니다.

// types/page.ts

```typescript
export type BasePageProps = {
  params: { [key: string]: string }
  searchParams: { [key: string]: string | string[] | undefined }
}
```

### 페이지별 특정 타입:

각 페이지에 특화된 추가적인 타입은 해당 페이지 파일 내에서 정의합니다.  
// app/users/[id]/page.tsx

```typescript
import { BasePageProps } from '@/types/page'

type UserPageProps = BasePageProps & {
  params: {
    id: string
  }
}

export default function UserPage({ params, searchParams }: UserPageProps) {
  // ...
}
```

이 접근 방식의 장점:  
공통 타입을 재사용할 수 있습니다.  
각 페이지에 특화된 타입을 유연하게 정의할 수 있습니다.  
코드의 일관성과 유지보수성이 향상됩니다. 결론적으로, 기본적인 페이지 props 타입은 외부에서 정의하고 export하되, 페이지별로 특화된 추가 타입은 해당 페이지 파일 내에서 정의하는 것이 좋은 균형점이 될 수 있습니다.  
이 방식을 통해 재사용성과 유연성을 모두 확보할 수 있습니다.

## 컴포넌트 Props 타입 지정

재사용 가능한 컴포넌트의 props에 타입을 지정합니다:
typescript
// components/Button.tsx

```typescript
import React from 'react'

type ButtonProps = {
  onClick: () => void
  children: React.ReactNode
  disabled?: boolean
}

export const Button: React.FC<ButtonProps> = ({
  onClick,
  children,
  disabled,
}) => {
  return (
    <button onClick={onClick} disabled={disabled}>
      {children}
    </button>
  )
}
```

## 상태 관리 타입 지정

상태 관리 라이브러리(예: Redux)를 사용할 때 타입을 지정합니다:
typescript
// store/userSlice.ts

```typescript
import { createSlice, PayloadAction } from '@reduxjs/toolkit'

type User = {
  id: string
  name: string
}

type UserState = {
  currentUser: User | null
  isLoading: boolean
}

const initialState: UserState = {
  currentUser: null,
  isLoading: false,
}

const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUser: (state, action: PayloadAction<User>) => {
      state.currentUser = action.payload
    },
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.isLoading = action.payload
    },
  },
})
```

## API 응답 타입 지정

외부 API 호출 시 응답 데이터의 타입을 지정합니다:
typescript
// types/api.ts

```typescript
export type Post = {
  id: number
  title: string
  body: string
}

// utils/api.ts
import { Post } from '../types/api'

export async function fetchPosts(): Promise<Post[]> {
  const response = await fetch('https://jsonplaceholder.typicode.com/posts')
  if (!response.ok) throw new Error('Failed to fetch posts')
  return response.json()
}
```

## 환경 변수 타입 지정

환경 변수의 타입을 지정하여 안전하게 사용합니다:
typescript
// env.d.ts

```typescript
declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NEXT_PUBLIC_API_URL: string
      DATABASE_URL: string
    }
  }
}

export {}
```

이렇게 타입을 지정하면, 프로세스 환경 변수를 사용할 때 자동 완성과 타입 체크가 가능해집니다.  
이러한 방식으로 TypeScript를 활용하면 코드의 안정성을 높이고, 개발 시 발생할 수 있는 많은 오류를 사전에 방지할 수 있습니다. 또한 IDE의 자동 완성 기능을 최대한 활용할 수 있어 개발 생산성도 향상됩니다.
