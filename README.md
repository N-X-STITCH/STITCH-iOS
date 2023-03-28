# STITCH 🏋️

![image](https://user-images.githubusercontent.com/39167842/227401910-b03b722b-f8c1-42b6-8acf-e634e5b15c08.png)

STITCH는 스포츠 메이트 매칭 플랫폼 애플리케이션 입니다.

## 배포 링크

> STITCH를 다운로드할 수 있는 링크입니다.

<a href="https://apps.apple.com/us/app/stitch/id6446614318">
  <img width="200" src="https://user-images.githubusercontent.com/76734067/207779701-cd44d8b6-d3eb-473d-86f6-50fc0f439374.png">
</a>

## 팀 소개

|Planner 비니(손수빈)|Designer 개리(홍준표)|Server 홀튼(김형석)|Android 피오(박승규)|iOS 탈리(하늘이)|
|:-:|:-:|:-:|:-:|:-:|
|@비니|@개리|[@kim-hyeungsuk](https://github.com/kim-hyeungsuk)|[@seunggyu97](https://github.com/seunggyu97)|[@NEULiee](https://github.com/NEULiee)

## 기능 & 동작화면

|<img src="https://user-images.githubusercontent.com/39167842/228167106-6af8bffb-2854-45e8-b4c7-a5e7261d8701.png" width=200>|<img src="https://user-images.githubusercontent.com/39167842/228167265-b07230eb-d4c2-4fd7-bdc3-94303b449887.png" width=200>|<img src="https://user-images.githubusercontent.com/39167842/228167409-dddd4479-3360-480c-9191-c4db88ac8506.png" width=200>|<img src="https://user-images.githubusercontent.com/39167842/228167502-c84280a3-e609-4d56-8adb-f8738de1c167.png" width=200>|
|:-:|:-:|:-:|:-:|
|`로그인 화면`|`동네 검색 화면`|`홈화면`|`카테고리 화면`|
|<img src="https://user-images.githubusercontent.com/39167842/228167699-cdb9a687-5c89-4ade-af51-def85526d007.png" width=200>|<img src="https://user-images.githubusercontent.com/39167842/228167813-ca233637-6c94-4681-ab90-f287e5c57568.png" width=200>|<img src="https://user-images.githubusercontent.com/39167842/228168009-e6163604-c181-41ab-ac11-29a440e445ca.png" width=200>|<img src="https://user-images.githubusercontent.com/39167842/228168071-f60ec30f-9d7b-432b-8084-abe10e408180.png" width=200>|
|`매치 개설 화면`|`장소 선택 화면`|`매치 상세 화면`|`마이페이지`|

## 프로젝트 구조

<img width="1104" alt="image" src="https://user-images.githubusercontent.com/39167842/228172474-b17526c5-e4cd-40d5-b25f-8e51be25de88.png">

- 역할 분리와 코드 재사용을 위해 MVVM-C, Clean Architecture 구조를 활용했습니다.

## 기술 스택

### RxSwift
- 비동기 처리를 위해 RxSwift를 사용했습니다.

### NaverMaps
- 국내 지도를 상세하게 보여줄 수 있고 안드로이드와 동일한 화면을 제공하기 위해 MapKit 보다 네이버 맵을 사용해 지도 View를 구성했습니다.

### CoreLocation
- 지도를 움직이며 좌표를 장소로 변환할 때 NaverMaps의 API 호출 횟수를 줄이기 위해 CoreLocation의 GeoCoding을 활용했습니다.
- RxSwift를 활용하기 위해 DelegateProxy를 구현해 사용했습니다.
