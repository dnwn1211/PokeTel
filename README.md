# PokeTel 연락처 관리 앱

PokeTel은 연락처를 관리할 수 있는 간단한 iOS 앱입니다. 이 앱은 연락처 목록을 표시하고, 연락처를 추가 및 편집할 수 있는 기능을 제공합니다. 또한, Pokémon API를 사용하여 랜덤 프로필 이미지를 생성합니다. 본 앱은 **MVVM (Model-View-ViewModel)** 아키텍처를 사용하여 구현되었습니다.

## 기능

- 연락처 목록 보기
- 연락처 추가 및 편집
- 연락처의 이름과 전화번호를 가로로 나열
- 프로필 이미지로 Pokémon 이미지 랜덤 생성
- 연락처 목록 정렬 (이름 순)
- 연락처 상세 정보 보기 및 수정

## 기술 스택

- Swift
- UIKit
- MVVM 아키텍처
- JSON Parsing
- URLSession (API 호출)
- Auto Layout
- UITableView, UIStackView

## MVVM 아키텍처

이 앱은 **MVVM (Model-View-ViewModel)** 아키텍처를 기반으로 구현되었습니다.

- **Model**: 데이터 구조를 정의하며, 연락처 정보를 관리하는 클래스입니다. `Contact` 모델은 이름, 전화번호, 프로필 이미지 등을 저장합니다.
- **View**: 사용자 인터페이스(UI)를 담당하는 부분입니다. `MainViewController`, `PhoneBookViewController`, `TableViewCell`은 UI를 구성하고, ViewModel과 상호작용하여 데이터를 표시합니다.
- **ViewModel**: View와 Model 사이에서 데이터 처리를 담당하는 부분입니다. `ContactListViewModel`은 연락처 목록을 관리하고, 데이터를 처리한 후 View에 전달합니다. `PhoneBookViewModel`은 연락처 추가 및 편집을 위한 로직을 포함합니다.
