//
//  FlowerStubs.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import UIKit

struct FlowerStubs {
    static let flowers: [Flower] = [
        .init(
            id: 45,
            name: "아잘레아",
            lang: "사랑의 기쁨",
            content: "아잘레아는 사계성 품종들이 많이 나와 있으며 특히 겨울철 실내 분화용으로 많이 이용하고 있다. 꽃색은 빨간 것들이 주종을 이루며, 최근에는 끝에 흰줄이 들어가 있는 복색도 나오고 보다 연한 핑크계통인 품종들도 많다.",
            type: "철쭉과에 속하는 식물은 지구상에서 극지방을 제외하고 널리 분포하여 전 세계적으로 약 100속 3000여종이 자생하고 있다. 여기서 철쭉속에 속하는 식물만 하더라도 대가족으로써 딸린 식구들이 약 800∼1000종이나 되는데 중국대륙에 자생하는 것들이 많으며 유럽에서 오래 전에 이들을 도입하어 분화용 원예품종으로 개발하여 전 세계적으로 공급하고 있다.",
            grow: "아잘레아는 삽목이 잘 되고 생육기간도 짧으며 병충해에도 강해 현재 국내 화목류 생산량 중에서 단연 우위를 차지하고 있다. 삽목으로 번식이 용이하고 반그늘에서 마르지 않게만 관리하면 된다.",
            usage: "아잘레아는 사계성 품종들이 많이 나와 있으며 특히 겨울철 실내 분화용으로 많이 이용하고 있다. 꽃색은 빨간 것들이 주종을 이루며, 최근에는 끝에 흰줄이 들어가 있는 복색도 나오고 있고, 보다 연한 핑크계통인 품종들도 많다.",
            imageData: [
                UIImage.assetToData("sample_flower1.jpeg"),
                UIImage.assetToData("sample_flower2.jpeg"),
                UIImage.assetToData("sample_flower3.jpeg"),
            ],
            date: Date.now
        ),
        .init(
            id: 15,
            name: "온시디움",
            lang: "순박한 마음",
            content: "온시디움은 꽃이 발랄한 소녀들을 연상시키기도 하고 나비를 보는 듯한 착각도 들어서 보는 이의 마음을 한결 밝고 즐겁게 해주는 착생란의 일종이다. 개체의 크기와 꽃의 색이나 모양이 상당히 다양하며, 특히 초코렛색 계통은 진한 향기가 난다.",
            type: "난초과에 속하며 아메리카 대륙 전체에 분포하지만 중남미의 해발 1500-1700m 고지대에서 집중적으로 자생한다. 세계적으로 약 750종이 분포하는데 수천종의 교배종도 있다. 나무에 착생하여 뿌리로 공기호흡을 한다.",
            grow: "씨앗으로 번식할 수도 있으나 실생묘들은 균일도가 낮기 때문에 조직배양묘를 이용하는 것이 보통이다. 햇빛을 좋아하지만 원산지에서는 큰 나무그늘에서 자라는 식물이니 만큼 한여름의 직사광선은 피하고 통풍이 잘되어야 한다.",
            usage: "꽃 모양이 좋고 개화기가 여름철로 대부분 난들이 출하되는 시기와 달라 키가 작고 향기가 나는 것들은 분화용으로 키가 크고 꽃이 많이 달리는 것들은 절화용으로 길러볼만한 식물이다.",
            imageData: [
                UIImage.assetToData("sample_flower4.jpeg"),
                UIImage.assetToData("sample_flower5.jpeg"),
                UIImage.assetToData("sample_flower6.jpeg"),
            ],
            date: Date.retrieveDateFromToday(by: 1)
        ),
        .init(
            id: 58,
            name: "깽깽이풀",
            lang: "안심하세요",
            content: "이름만 들으면 볼품없을 것 같지만 이른 봄 햇빛이 좀 드는 숲 따뜻한 곳에 무리지어 있는 모습을 보면 누구나 감탄할 정도로 아름답다. 키는 작지만 올망졸망 모여서 나고 가늘고 긴 꽃대에 보라색 꽃을 피우며 연잎처럼 생긴 잎을 가지고 있다.",
            type: "매자나무과 여러해살이풀로써 지구상에 딱 2종이 있는데, 그 중 하나가 우리나라에 나는 것이다. 제주와 남부도서지방을 제외한 전국의 숲 가장자리 그늘진 곳에 자생한다.",
            grow: "화단용은 바람이 잘 통하면서 반 그늘진 곳에 심는다. 분화용은 여름 고온기에 약 50%정도 차광이 필요하다. 포기나누기나 씨앗으로 번식하는데 씨앗은 뿌린 후 3년은 지나야 꽃을 볼 수 있다. 씨앗번식과 관련해서 재미난 것은 깽깽이풀 씨앗에 밀선이 있어서 여기에 들어있는 당분을 개미들이 영양원으로 사용한다. 개미는 생존을 위해 당분을 이용하고 깽깽이풀 역시 종피에 당이 벗겨지면서 쉽게 발아하게 되고, 또 개미가 이동한 만큼 자손을 멀리 퍼트릴 수 있게 되어 서로 공생관계에 있다.",
            usage: "꽃은 물론 잎 모양도 뛰어나 화단은 물론 분화용으로도 훌륭한 소재다. 특히 추위에 강해 거의 전국에서 월동한다. 자생지에서는 무척 귀하게 여겨져 환경부 지정 보호야생식물 27호이다. 뿌리는 약용으로 쓰이기도 한다.",
            imageData: [
                UIImage.assetToData("sample_flower2.jpeg"),
                UIImage.assetToData("sample_flower4.jpeg"),
                UIImage.assetToData("sample_flower6.jpeg"),
            ],
            date: Date.retrieveDateFromToday(by: 2)
        ),
        .init(
            id: 27,
            name: "구상나무",
            lang: "기개",
            content: "구상나무는 세계적으로 우리나라에만 나는 한국특산식물이다. 잎도 잘 떨어지지 않고 수형이 좋아 외국에서는 크리스마스트리로 가장 귀하게 여기는 나무이기도 하다. 한라산 윗세오름이나 덕유산 정상에 가보면 고사목들이 서 있는데 기품이 당당하다. 주목은 살아서 천년 죽어서 천년이라 했는데, 구상나무는 살아서 백년 죽어서 백년이라 한다.",
            type: "소나무과에 속하는 상록성 침엽수이다. 열매의 색깔에 따라 붉은구상나무, 검은구상나무, 푸른구상나무가 있으며 구상나무와 비슷한 것으로 분비나무와 젓나무가 있다. 한라산, 덕유산, 지리산 등지의 해발 1000m 이상에서 자생한다.",
            grow: "추위나 음지에도 강하고 맹아력도 좋아 전국 어디서든 잘 자란다. 반면에 공해에 약하고 생장은 좀 늦은 편이다. 너무 건조하지 않고 배수가 잘되는 토양이 좋고 반그늘, 양지 모두 좋지만 여름철 무더위는 조심해야 한다. 10월에 잘 익은 열매를 따서 바로 뿌리거나 땅에 묻어두었다 봄에 뿌린다.",
            usage: "수형이 곧고 피라미드 모양의 층을 이루며 자라는 습성이 있어 일반 가정의 정원수로는 물론 공원, 학교 등 조경용으로 흔히 이용된다. 봄에 나오는 연녹색의 신초나 가을에 맺는 원통형의 열매도 관상가치가 뛰어나다. 나무 결이 좋고 튼튼하여 가구재, 건축재로도 쓰인다. 우리가 관상용으로 품종을 개발해 외국으로 수출할 수 있는 가능성이 큰 식물이다.",
            imageData: [
                UIImage.assetToData("sample_flower5.jpeg"),
                UIImage.assetToData("sample_flower1.jpeg"),
                UIImage.assetToData("sample_flower3.jpeg"),
            ],
            date: Date.retrieveDateFromToday(by: -1)
        ),
        .init(
            id: 168,
            name: "아게라텀",
            lang: "신뢰",
            content: "아게라텀은 우리말로 멕시코엉겅퀴라고 불리기도 한다. 원산지는 멕시코나 페루로 국화과식물이다. 가을에 뿌려 여름에 피는 일년초지만 원산지에서는 반관목성 다년초로 야생한다. 최근에 자가불화합성을 이용한 F1 품종의 개량이 진행되어 재배가 성행하고 있다.",
            type: "원산지는 멕시코, 페루로써 국화과 식물이다. 가을에 뿌려 여름에 피는 일년초로 재배되지만 원산지에서는 반관목성 다년초로 야생한다. 꽃색은 청색 계통이 많으며 연분홍색과 흰색인 품종도 있다.",
            grow: "아게라텀은 화단용 초화로서 우리나라에서는 봄부터 가을까지 꽃이 피지만 여름철 고온기에는 꽃이 잘 피지 못하고 서리가 내리면 얼어 죽는다. 생육적온은 15∼25℃ 정도이고 10℃ 이하와 30℃ 이상이면 생육이 어렵다. 물 빠짐이 좋고 약간 그늘진 곳에서 잘 자란다. 밑거름으로 유기물을 주로 이용하고 화학비료는 생육상태를 보아가며 주는 것이 좋다. 질소 끼가 많으면 잎만 무성해지고 꽃이 불량해진다.",
            usage: "아게라텀은 줄기 아래로부터 곁가지의 발생이 많아 초형이 둥글며 키는 20∼70cm 정도이다. 줄기에 1.5cm 정도의 작은 꽃이 화방상으로 피며 꽃색은 청색 계통이 주를 이루고 연분홍색과 흰색이 있다. 화단에 심을 때는 20∼25cm 간격으로 심는다. 아게라텀만을 화단에 집단적으로 심을 수도 있지만 꽃색이 한정되어 있으므로 프렌치메리골드, 채송화, 살비아 및 백일홍 등과의 조화를 갖추어 심는 것이 좋다. 아게라텀은 서늘한 온도에서 꽃이 잘 피고 강한 직사광선에서는 꽃색이 퇴색되는데 특히 흰색 및 분홍색 품종이 심하다.",
            imageData: [
                UIImage.assetToData("sample_flower7.jpeg"),
                UIImage.assetToData("sample_flower8.jpeg"),
                UIImage.assetToData("sample_flower9.jpeg"),
            ],
            date: Date.retrieveDateFromToday(by: -2)
        ),
    ]
    static let flower: Flower = flowers.first!
}

extension Date {
    static func retrieveDateFromToday(by day: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: day, to: Date.now)!
    }
}

extension UIImage {
    static func assetToData(_ name: String) -> Data {
        UIImage(named: name)!.pngData()!
    }
}
