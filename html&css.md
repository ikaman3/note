# html & css

구와악

## CSS

### `white-space`

p 태그는 `white-space` 속성의 기본값이 `normal`으로 되어 있어 개행이 무시된다.  

```
1... 2... 3...
```

해당 속성을 `pre-wrap`으로 변경하여 개행을 표시할 수 있다.

```css
p {
    white-space: pre-wrap
}
```

> [MDN Link](https://developer.mozilla.org/ko/docs/Web/CSS/white-space)