# FIVE GUYS - 다국어 메뉴판 OCR · 번역 · 설명 서비스

<img src="docs/images/팀로고.png" width="600" />


> **"사진 한 장, 바로 이해되는 메뉴"**  
> OCR 기반 다국어 메뉴판 번역 및 메뉴 설명 제공 서비스

---

## 0. 프로젝트 소개

해외 여행을 가면,
- 메뉴판이 전부 외국어라서 **무슨 음식인지 모르겠는 문제**
- 알레르기, 매운 정도, 재료를 **확인하기 어려운 문제**가 있어요.

**FIVE GUYS**는  
📷 메뉴판 사진 한 장만 올리면 →  
🔎 OCR로 글자를 읽고 →  
🌐 선택한 언어로 번역하고 →  
🍽 음식 설명·알레르기 정보까지 같이 보여주는  
웹 서비스입니다.

---

## 1. 팀 정보

---
| 항목 | 내용 |
|------|------|
| 팀명 | **FIVE GUYS** |
| 역할 | OCR 기반 다국어 메뉴판 번역 및 메뉴 설명 서비스 개발 |
| 팀장 | 송영철 |
| 팀원 | 정연, 서인성, 이용일, 형남호 |
| 프로젝트 기간 | 2025.10 ~ 2025.11 (MVP) |
---
<img src="docs/images/팀원.png" width="600" />











## 2. 주요 기능

### 2-1. 메뉴판 번역

- 메뉴판 이미지를 업로드하면 미리보기로 확인
- **Naver Clova OCR**로 메뉴 텍스트 인식
- 인식된 텍스트와 좌표(X1, Y1, X2, Y2) 저장
- 원하는 언어(한국어, 영어, 일본어, 중국어 등)로 번역
- 각 메뉴에 대해
  - 메뉴 이름
  - 번역된 이름/설명
  - 알레르기 · 성분 정보(선택)
  를 한 화면에 보여줌

### 2-2. 마이페이지

- 내 프로필 조회 (아이디, 이름, 이메일, 선호 언어 등)
- 비밀번호 변경
- 회원 탈퇴
- **즐겨찾기 메뉴판 이미지** 업로드 및 관리
- 나의 번역 기록 조회(히스토리)

### 2-3. 관리자 페이지

- 회원 검색
  - 이름 또는 ID로 회원 검색
- 회원 전체 목록 조회
- 회원 정보 관리(권한/상태 수정 등)

### 2-4. 공통 UX

- 상단 메뉴에서
  - 메인
  - 이미지 업로드 / 번역
  - 결과 보기
  - 로그인 / 로그아웃 / 마이페이지
  로 쉽게 이동 가능
- 게스트 모드
  - 로그인 하지 않아도 메뉴판 번역 기능 일부 체험 가능

---

## 3. 기술 스택

### 3-1. 전체 기술 개요

| 구분 | 사용 기술 |
|------|-----------|
| **기본 사용언어** | `Python`, `Java`, `JavaScript` |
| **Frontend 사용언어** | `HTML`, `CSS`, `JSP` |
| **Backend 프레임워크** | `FastAPI (Python)`, `JSP & Servlets`, `Apache Tomcat` |
| **개발도구** | `Eclipse`, `Google Colab` |
| **협업도구** | `GitHub` |
| **데이터베이스 / ORM** | `Oracle 11g`, `MyBatis` |
| **디자인** | `Figma` |
| **AI · OCR · API** | `Naver Clova OCR`, `Google Gemini`, `Kakao Map API` |

### 3-2. 역할 정리

- **Frontend (JSP / HTML / CSS / JS)**
  - 로그인 / 회원가입 / 비밀번호 찾기
  - 메뉴판 이미지 업로드 화면
  - 번역 결과 화면
  - 마이페이지, 관리자 화면

- **Backend (Java / Python)**
  - Java + JSP/Servlet + Tomcat 웹 서버
  - Python FastAPI 서버에서
    - Clova OCR 호출
    - Gemini 번역 호출
    - Kakao Map API 등 외부 API 연동

- **Database (Oracle 11g + MyBatis)**
  - 회원 정보
  - 이미지 정보
  - 번역 결과
  - 즐겨찾기/히스토리 정보 저장

---

## 4. 시스템 아키텍처

1. 사용자가 웹 브라우저에서 메뉴판 이미지를 업로드
2. Java/JSP 서버(Tomcat)가 요청을 받아 처리
3. 필요한 경우 Python FastAPI 서버로 API 요청 전달
4. FastAPI 서버에서
   - Clova OCR을 호출해 텍스트 추출
   - Gemini로 다국어 번역 및 메뉴 설명 생성
5. 처리된 결과를 Oracle DB에 저장
6. JSP 화면에서 번역 결과, 알레르기 정보, 즐겨찾기 등을 렌더링하여 사용자에게 보여줌

 
<img src="docs/images/아키텍쳐.png" width="600" />

---

## 5. 데이터베이스 설계

### 5-1. 주요 테이블

- `T_MEMBER` : 회원 정보
  - MEMBER_ID, PW, NAME, EMAIL, ROLE, PREFER_LANG, JOIN_DATE 등
- `T_IMAGE` : 업로드된 메뉴판 이미지 정보
  - IMG_ID, MEMBER_ID, FILE_NAME, UPLOAD_DATE 등
- `T_TRANSLATION` : 번역 결과
  - TRANS_ID, IMG_ID, X1, Y1, X2, Y2, MENU_NAME, TRANS_TEXT, MENU_DESC 등
- `IMAGE_STORAGE` : 이미지 원본 저장용 테이블(또는 파일 경로 관리)

<img src="docs/images/테이블.png" width="600" />

---

## 6. 주요 화면 구성

> 실제 프로젝트에서 사용한 화면 캡처 이미지를 docs/images 폴더 등에 넣고 아래 경로를 맞춰주세요.

### 1. 메인 화면
   - 서비스 소개
   - 메뉴판 번역으로 이동 버튼

### 2. 로그인 / 회원가입 / 비밀번호 찾기
   - 기본적인 회원 관리
   - 매크로 방지 기능 포함(비밀번호 찾기)
<img src="docs/images/로그인 화면.png" width="600" />
<img src="docs/images/회원가입 화면.png" width="600" />

### 3. 메뉴판 번역 화면
   - 이미지 업로드 영역
   - 번역 언어 선택
   - 번역 실행 버튼
<img src="docs/images/메인 화면.png" width="600" />

### 4. 번역 결과 화면
   - 원문 / 번역문 메뉴 목록
   - 메뉴 설명, 알레르기 정보 표시
   - 복사 / 다운로드(선택 기능) 등
<img src="docs/images/결과 화면1.png" width="600" />
<img src="docs/images/결과 화면2.png" width="600" />

### 5. 마이페이지
   - 프로필 확인 및 비밀번호 변경
   - 회원 탈퇴
   - 즐겨찾기 이미지 관리
<img src="docs/images/마이페이지 화면.png" width="600" />

### 6. 관리자 화면
   - 회원 검색 (ID / 이름)
   - 회원 전체 조회
<img src="docs/images/관리자 화면.png" width="600" />

### 7. 확장프로그램
<img src="docs/images/확장프로그램 1.png" width="600" />
<img src="docs/images/확장 프로그램2.png" width="600" />

---


