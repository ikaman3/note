# MacOS
> 내 MacOS에서만 사용하는 스크립트 및 패키지와 그 사용법을 정리한 문서

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
> mkv to mp4
```
# 현재 디렉토리의 모든 MP4 파일을 반복하여 처리합니다.
for file in *.mp4; do
    if [ -f "$file" ]; then
        # 파일명에서 확장자 제거
        filename="${file:r}"
        extension="${file:e}"

        # hvc1 코덱으로 변환된 파일명 생성
        new_filename="${filename}_hvc1.${extension}"

        # ffmpeg를 사용하여 파일을 hvc1 코덱으로 변환
        ffmpeg -i "$file" -c:v libx265 -c:a copy -tag:v hvc1 "$new_filename"

        echo "파일 '$file'을(를) '$new_filename'으로 변환했습니다."
    fi
done
```
> 강의 및 저장해두고 싶은 영상을 적절한 화질과 용량으로 인코딩하는 스크립트
```
#!/bin/zsh

targetPath=~/Movies/encoded
desktopPath=~/Desktop

# 중간에 강제로 종료할 경우 "0" 파일이 남는데 그거 지우는 함수
rm0File() {
	if [ $(find ~ -maxdepth 1 -name "0") ]
	then
		rm ~/0
	fi
}

# 파일이 존재하는지 확인 후 작업 여부 결정
find $desktopPath -maxdepth 1 -name "*.mp4" -o -name "*.mov"
if [ -e "${desktopPath}/*.mp4" -o "${desktopPath}/*.mov" ]
then
	fileCount=$(find $desktopPath -maxdepth 1 -name "*.mp4" -o -name "*.mov" | wc -l | tr -d \ )
	echo "총 파일 개수: ${fileCount}"
	# -n: Built-in echo와 /bin/echo 명령어가 달라서 생기는 문제 같다.
	printf "작업을 진행합니까? (y/n)> "
	read YorN 
	# 변수값이 비어버릴 경우 문법에 의해 조건식이 성립될 수 없어 "[: too many arguments" 에러가 발생, 변수를 ""로 묶을 것
	if [ "$YorN" = "n" -o "$YorN" = "N" ]
	then
		echo "작업을 종료했습니다."
		exit 0
	fi

	# 파일 개수만큼 인코딩 반복
	videoArray=$(find $desktopPath -maxdepth 1 -name "*.mp4" -o -name "*.mov")
	count=0 # 작업 횟수 확인용 변수
	for filename in $videoArray
	do
		title=$(echo $filename | cut -d "/" -f 5 | cut -d "." -f 1)
		
		let count++
		ffmpeg -i "${filename}" -s 1920x1080 -c:v libx265 -tag:v hvc1 "${targetPath}/${title}.mp4" \
		&& mv "${filename}" ~/.Trash/
	done
	echo "총 작업 횟수: $count"
	echo "작업 종료."
	rm0File
	exit 0
else
	echo "작업할 파일 없음!!!"
	rm0File
	exit 0
fi
```