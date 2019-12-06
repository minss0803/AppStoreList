# AppStoreList

## 개발 환경
- minVersion : iOS 10
- targetVersion : iOS 13
- Swift 5
- Xcode 11
- CocoaPods

## 실행 방법
```
1. git clone https://github.com/minss0803/AppStoreList.git
2. pod install
3. open HandMade.xcworkspace
4. Run the application
```

## 구현 방법
- RxSwift 및 그 외 Dependency를 사용했습니다.
- MVVM 패턴으로 구현하였습니다.

## 외부 라이브러리
### RxSwift + Dependencies
- RxSwift
- RxCocoa
- RxOptional
- RxGesture
- RxAppState

### Image + Animation + UI
- Kingfisher : 이미지캐시 로딩 라이브러리
- SnapKit : `오토레이아웃`을 코드로 구현하는데 사용
- Toaster : `토스트 메시지`를 띄우기 위해 사용
- Cosmos : `별점` 을 그리는 데 사용

### Other Swift Utilities
- Then

