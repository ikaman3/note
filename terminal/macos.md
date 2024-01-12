# MacOS
> MacOS에서만 사용하는 스크립트 및 패키지와 그 사용법을 정리한 문서

# Scripts
## Log
> 지난 24시간 동안의 sshd 프로세스 로그를 표시한다
> - predicate : 뒤에 오는 문자열로 로그의 범위를 제한
> - last : 마지막으로부터(h, m, d 등 사용가능)
```
log show --predicate "process == 'sshd'" --last 24h
```

# Packages
## ffmpeg
> 오픈 소스 다목적 멀티미디어 프레임워크로서, 오디오 및 비디오 처리, 변환, 스트리밍 등 다양한 멀티미디어 작업을 수행하는 데 사용

> 녹화한 영상을 적당한 화질로 용량을 줄이기 위해 인코딩 후 원본 영상은 휴지통으로 이동(rm 처럼 즉시 삭제가 아님)
> - -i : 입력 파일 지정
> - -s : 영상의 크기 지정
> - -c : 비디오 코덱 선택
>   > - copy : 원본 영상의 스펙을 그대로 유지
>   > - libx265 : H.265(HEVC) 비디오 코덱
> - -tag : 비디오 스트림의 태그 설정 
>   > - hvc1 : H.265 비디오를 위한 hvc1 
> - ".../${title}.mp4" : 출력 파일의 경로 및 이름 지정
```
ffmpeg -i "${filename}" -s 1920x1080 -c:v libx265 -tag:v hvc1 "${targetPath}/${title}.mp4" \
    && mv "${filename}" ~/.Trash/
```
> mp4 파일에 미리보기 실행을 위해 hvc1 태그만 붙이기  
```
ffmpeg -i "title.mp4" -c:v copy -c:a copy -tag:v hvc1 "title.mp4"
```
> 파일을 hvc1 코덱으로 변환
```
ffmpeg -i "$file" -c:v libx265 -c:a copy -tag:v hvc1 "$new_filename"
```
> gif 만들기  
```
ffmpeg -i "<INPUT_FILE>" -y "<OUTPUT_FILE>" -v warning  -filter_complex "[0:v] fps=15,split [1:v] [2:v]; [1:v] palettegen [p]; [2:v] fifo [3:v]; [3:v] [p] paletteuse" -loop 0
```