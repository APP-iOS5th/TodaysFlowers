# Today's Flowers (오늘의 꽃)
앱스쿨 두번째 단기 프로젝트, 오늘의 꽃 시작합니다.

## Stacks 👨‍💻
### Architecture

<div align="center">
    <img src="./Resources/expanded-mvvm.png" width=512 />
</div>

기존의 MVVM에서 Clean Architecture 개념 일부분을 빌려와서 작성한 아키텍처 패턴 입니다. 각 화면들은 각자의 view model을 가지고 각 view model은
화면들의 use case를 가지고 있습니다. 가령, Home View의 use case는 첫 앱이 구동되고, 서버(혹은 로컬)에서 꽃 객체들을 가져와서 보여주는 것 입니다.
또 Detail View는 특정 id를 통해 꽃 객체의 상세 정보를 보여주는 것이 use case 입니다. 모든 로직이 분리되어 있기에, 손쉬운 확장을 기대할 수 있습니다.

### Core

<div align="center">
    <img src="./Resources/fig1 combine.png" width=512 />
</div>

MVVM의 View와 ViewModel의 바인드와 각 의존성들 사이의 비동기 처리를 위해 Combine을 사용합니다. 

<div align="center">
    <img src="./Resources/fig2 vision.png" width=512 />
</div>

이미지 검색, 이미지 Lifting, 그리고 이미지 필터를 위해 Vision을 사용합니다.

## Features 🎱

<div style="display: flex; align-items: center; margin: 20px 0;">
  <div style="flex: 0 0 200px; margin-right: 20px;">
    <img src="./Resources/gif/detail.GIF" style="width: 100%; height: auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
  </div>
  <div style="flex: 1; font-size: 16px; line-height: 1.6;">
    <p>상세화면에서는 Id를 기반으로 해당 꽃의 정보를 얻어 사용자에게 보여줄 수 있습니다.</p>
    <p>TBA</p>
  </div>
</div>
<br />
<br />
<div style="display: flex; align-items: center; margin: 20px 0;">
  <div style="flex: 1; font-size: 16px; line-height: 1.6; padding-right: 20px; text-align: right">
    <p>iOS 17+ 이상에서는 VisionKit을 통해 이미지를 하이라이트하고 배경을 제거한 이미지를 얻을 수 있습니다.</p>
    <p>TBA</p>
  </div>
  <div style="flex: 0 0 200px;">
    <img src="./Resources/gif/imageLifting.GIF" style="width: 100%; height: auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
  </div>
</div>
<br />
<br />
<div style="display: flex; align-items: center; margin: 20px 0;">
  <div style="flex: 0 0 200px; margin-right: 20px;">
    <img src="./Resources/gif/imageEdting.GIF" style="width: 100%; height: auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
  </div>
  <div style="flex: 1; font-size: 16px; line-height: 1.6;">
    <p>iOS 17+ 이상에서는 Vision에도 새로운 기능이 추가되어 있습니다.
    VNGenerateForegroundInstanceMaskRequest을 사용하면 foreground 이미지와 background 이미지를 분리할 수 있습니다.
    </p>
    <p>TBA</p>
  </div>
</div>
<br />
<br />
<div style="display: flex; align-items: center; margin: 20px 0;">
  <div style="flex: 1; font-size: 16px; line-height: 1.6; padding-right: 20px; text-align: right">
    <p>CreateML을 사용하면 Swift로 머신러닝 모델을 훈련하고 생성할 수 있습니다. CoreML과 Vision을 사용하면 훈련된 모델을 통해 이미지로 부터 꽃의 이름을 알아낼 수 있습니다. 그것을 기반으로 검색을 진행합니다.</p>
    <p>TBA</p>
  </div>
  <div style="flex: 0 0 200px;">
    <img src="./Resources/gif/imageSearch.GIF" style="width: 100%; height: auto; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
  </div>
</div>

<!-- Home Feature: Collection View -->

<!-- Detail Feature: Animation, ImageLifting, PageControl -->

<!-- Search Feature: Segment -->

<!-- Data Feature: Data Handling -->


## Futrue Directions 🗒️
- [x] 검색확장
- 화면 인터랙션
    - [x] 화면 전환 애니메이션
- CoreML 사용
    - [x] VisionKit
    - [x] Vision

## Team 👥
|5.김진웅|5.안성근|5.이인호|5.황민경|
|:-:|:-:|:-:|:-:|
|<img src="https://avatars.githubusercontent.com/u/26710036?v=4" width=400 />|<img src="https://avatars.githubusercontent.com/u/72062051?v=4" width=400 />|<img src="https://avatars.githubusercontent.com/u/28581796?v=4" width=400 />|<img src="https://avatars.githubusercontent.com/u/164498740?v=4" width=400 />|
|INTJ<br>[@jinwoong](https://github.com/jinwoong16)|INTP<br>[@mo-si-dev](https://github.com/mo-si-dev)|INFJ<br>[@womyo](https://github.com/womyo)|INFP<br>[@mghhwang](https://github.com/mghhwang)|

