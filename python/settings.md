# Python Development Environment
Python으로 개발을 하면서 설정했던 개발 환경을 기록해두는 문서

# Python Virtual Environment

## 가상환경 만들기  

```
python -m venv <venv_name>
```  

## 가상환경 적용  

```
source <venv_dir>/bin/activate
```  

## Python 가상환경 해제  

작업 위치에 상관 없음  
```
deactivate
```  

## 생성한 가상환경의 인터프리터를 VSCode에서 사용하는 방법  

VSCode의 설정 ( Command + , ) (setting.json) 에서 'Python: Default Interpreter Path'를 가상환경의 python interpreter로 설정한다.  
1. ${workspaceFolder}/python_venv/<project_name>/bin/python3.12 입력 
    - 상황에 맞게 적절히 경로를 설정한다.  
2. cmd + shift + p —> python : select interpreter에서 방금 설정한 인터프리터를 선택한다.  

[reference](https://blog.devwon.site/python/2021/08/01/Vscode-venv-python-interpreter/)

# Error
## ImportError: attempted relative import with no known parent package
모듈을 제대로 인식하지 못하는 문제   
- 디렉토리를 추가하여 해결함  
- db 관련된 파일을 database 폴더 안에 넣고 database 폴더 안에 있는 파일을 가져옴  

[reference](https://iq-inc.com/importerror-attempted-relative-import/)(Option 2: Just Make an Actual Package)

## konlpy 설치 에러
konlpy 모듈 설치를 하지 못하는 에러
- Jpype1를 수동으로 설치하여 해결한다.  
- python 3.11 이하 버전에서 가능하다 
