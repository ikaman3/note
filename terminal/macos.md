# MacOS Shell Script

# Log
> 지난 24시간 동안의 sshd 프로세스 로그를 표시한다
> - predicate : 뒤에 오는 문자열로 로그의 범위를 제한
> - last : 마지막으로부터(h, m, d 등 사용가능)
```
log show --predicate "process == 'sshd'" --last 24h
```

