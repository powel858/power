//
//  profile.swift
//  C2-CARD
//
//  Created by Powel on 4/18/25.
//

import SwiftUI
//SwiftUI에 넣어준다
//SwiftUI는 아이폰 앱의 화면(UI)을 쉽게 만들어주는 프레임워크
extension UIApplication {
    // 앱 전체에 새로운 기능을 넣어준다.
    // extension -> 이미 있는 클래스에 새로운 기능을 추가하는 문법
    //UIApplication에게 키보드를 내려달라고 명령하는 기능을 추가하는 코드
    func endEditing() {
        // 이 함수는 편집을 끝내는 함수이다.
        // endEditing -> 편집을 끝낸다.
        sendAction(#selector(UIResponder.resignFirstResponder),
                   //"입력중인 객체가 입력을 포기한다"(키보드를 내림)
                   // sendAction -> UIKit에서 제공하는 메서드
                   // sendAction -> 특정 액션(동작)을 앱 내부에 전달해 실행하는 역활을 함
                   // (#selector(UIResponder.resignFirstResponder) -> 현재 입력을 받고 있는 키보드가 입력을 더 이상 받지 않도록 내려가게 하는 액션
                   // FirstResponder -> 사용자가 입력하는 UI요소(예시: TextField, TextView)가 첫번쨰 응답자가 됩니다.
                   // FirstResponder -> 현재 키보드 입력을 받고 있는 객체를 의미합니다.
                   // resignFirstResponder란? -> "나는 더 이상 입력을 받지 않겠다"라고 선언하는 메서드입니다. -> 만약 이 메서드를 호출하면 해당 객체는 포커스를 잃고, 키보드가 내려갑니다.
                   // UIResponder.resignFirstResponder -> "입력중인 객체가 입력을 포기한다"는 메서드(즉, 키보드를 내림)
                   // sendAction(#selector(UIResponder.resignFirstResponder) -> objective-c 스타일로 메서드(동작)을 지정하는 방법
                   to: nil, from: nil, for: nil)
        //to: nil -> 특정 대상을 지정하지 않고 "앱 안의 모든 객체"에게 전달
        //앱 전체에 전달한다
    }
    // endEditing 호출 -> 앱 전체에 "입력 중단" 명령 ->현재 입력중인 객체가 신호수신 -> resignFirstResponder란? -> "나는 더 이상 입력을 받지 않겠다"라고 선언하는 메서드 실행 -> 키보드가 자동으로 내려감
}

extension String { // 사용자가 입력한 값에서/ 불필요한 공백이나 줄바꿈을/ 자동으로 제거할 수 있고,/ 입력값이 진짜로 비어있는지(공백만 있는지)/ 쉽게 검사할 수 있습니다. 입력 검증후 입력이 감지되면 -> 저장 버튼 활성화?
    // 공백·줄바꿈을 제거한 문자열 / extension -> 기존 타입에 새로운 기능을 추가한다는 의미/ String -> 문자열 타입(글자들의 집합) / { -> 여기부터 새로운 기능을 쓴다.
    var trimmed: Self { trimmingCharacters(in: .whitespacesAndNewlines) }
    /// 내용이 있는지 여부 (양쪽 공백을 제외하고)
    /// var -> 새로운 속성을 만든다는 뜻
    /// trimmed -> 속성이름 "다듬어진"(공백이 제거된)이라는 뜻
    /// :  Self -> 이 속성의 타입이 String이라는 뜻(자기자신)
    /// {...}  -> 속성의 실제 동작(코드)를 정의
    /// { trimmingCharacters(in: .whitespacesAndNewlines) } -> 문자열 양쪽 끝에 있는 "공백과 줄바꿈" 문자를 모두 잘라낸 새 문자열을 반환
    var isNotEmpty: Bool { !trimmed.isEmpty }
    /// 문자열이 비어있지 않으면 "참", 비어있으면 "거짓"
    /// isNotEmpty ->  속성이름 "비어있지 않다"는 의미
    ///  :Bool -> true/false중 하나를 반환.(참/거짓)
    ///  여기서 "!"의 의미 -> 뒤에 나오는 값을 반대로 뒤집는 역활
    /// trimmed -> 문자열이 비어있으면 "trud", 비어있지 않으면"false"
    /// !trimmed -> 문자열이 비어있지 않으면"trud", 문자열이 비어있으면 "false"
    
}

struct PressableButtonStyle: ButtonStyle {
    // 이 구조체는 버튼이 눌릴때의 스타일 값을 담고있다.
    func makeBody(configuration: Configuration) -> some View {
        // 이 함수는 버튼을 만들때의 값을 담고 있고 ~ : ~ 으로 눌렸을때와 안눌렸을때의 모습을 보여준다.
        configuration.label
        // 버튼 안에 들어갈 텍스트, 이미지
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        // 크기 변화를 조절하는 수정 뷰
            .opacity(configuration.isPressed ? 0.8 : 1.0)
        // 투명도를 조절하는 수정 뷰
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2),
                    // 그림자의 색깔, 투명도, 번짐, x축 이동거리, y축 이동거리
                    radius: configuration.isPressed ? 0 : 4,
                    x: 0, y: configuration.isPressed ? 0 : 2)
    }
}

struct LabeledTextEditor: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.body)
                .fontWeight(.semibold)
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color.white)
                    .frame(minHeight: 88)
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)

                TextEditor(text: $text)
                    .padding(8)

                if text.isEmpty {
                    Text(placeholder)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

enum Domain: String, CaseIterable, Identifiable {
    case designer = "designer (디자인)"
    case developer = "developer (개발)"
    case planner  = "domain (기획)"
    var id: String { rawValue }
    
    var chipColor: Color {
        switch self {
        case .designer:
            return Color(hex: "E7AAE9")
        case .developer:
            return Color(hex: "B2E9AA")
        case .planner:
            return Color(hex: "AAE9E5")
        }
    }
}

struct ChipPickerView: View {
    let title: String
    let placeholder: String
    let options: [Domain]
    @Binding var selection: Domain?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.body)
            Menu {
                ForEach(options) { option in
                    Button {
                        selection = option
                    } label: {
                        Text(option.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 13)
                                    .fill(option.chipColor)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Text(selection?.rawValue ?? placeholder)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 13)
                                .fill(selection != nil ? selection!.chipColor : Color(hex: "F5F5F5"))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(8)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 13))
            }
        }
    }
}

struct ContentView2: View {
    @State private var nickname: String = ""
    @State private var supportSelection: Domain? = nil
    @State private var hopeSelection: Domain? = nil
    @State private var showSupportPicker: Bool = false
    @State private var showHopePicker: Bool = false
    @State private var learningText: String = ""
    @State private var goalText: String = ""
    @AppStorage("hasProfile") private var hasProfile: Bool = false

    // MARK: - Convenience trimmed strings
    private var trimmedNickname: String { nickname.trimmed }
    private var trimmedLearning: String { learningText.trimmed }
    private var trimmedGoal: String    { goalText.trimmed }

    private var isFormComplete: Bool {
        trimmedNickname.isNotEmpty &&
        trimmedLearning.isNotEmpty &&
        trimmedGoal.isNotEmpty
    }
    
    private var hasInput: Bool {
        trimmedNickname.isNotEmpty ||
        trimmedLearning.isNotEmpty ||
        trimmedGoal.isNotEmpty
    }

    private var hasChanges: Bool {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "nickname_key") != nickname { return true }
        if defaults.string(forKey: "support_key") != supportSelection?.rawValue { return true }
        if defaults.string(forKey: "hope_key") != hopeSelection?.rawValue { return true }
        if defaults.string(forKey: "learning_key") != learningText { return true }
        if defaults.string(forKey: "goal_key") != goalText { return true }
        return false
    }

    init() {
        let defaults = UserDefaults.standard
        _nickname = State(initialValue: defaults.string(forKey: "nickname_key") ?? "")
        if let supportRaw = defaults.string(forKey: "support_key"),
           let savedSupport = Domain(rawValue: supportRaw) {
            _supportSelection = State(initialValue: savedSupport)
        } else {
            _supportSelection = State(initialValue: nil)
        }
        if let hopeRaw = defaults.string(forKey: "hope_key"),
           let savedHope = Domain(rawValue: hopeRaw) {
            _hopeSelection = State(initialValue: savedHope)
        } else {
            _hopeSelection = State(initialValue: nil)
        }
        _learningText = State(initialValue: defaults.string(forKey: "learning_key") ?? "")
        _goalText = State(initialValue: defaults.string(forKey: "goal_key") ?? "")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "nickname_key")
                        defaults.removeObject(forKey: "support_key")
                        defaults.removeObject(forKey: "hope_key")
                        defaults.removeObject(forKey: "learning_key")
                        defaults.removeObject(forKey: "goal_key")
                        defaults.set(true, forKey: "resetProfileOnNextLaunch")
                        nickname = ""
                        supportSelection = nil
                        hopeSelection = nil
                        learningText = ""
                        goalText = ""
                    }) {
                        Text("초기화")
                            .font(Font.custom("Nunito", size: 18).weight(.bold))
                            .foregroundColor(hasInput ? Color.blue : Color.gray)
                    }
                    .disabled(!hasInput)
                    
                    Spacer()
                    
                    Button(action: {
                        let defaults = UserDefaults.standard
                        defaults.set(nickname, forKey: "nickname_key")
                        defaults.set(supportSelection?.rawValue, forKey: "support_key")
                        defaults.set(hopeSelection?.rawValue, forKey: "hope_key")
                        defaults.set(learningText, forKey: "learning_key")
                        defaults.set(goalText, forKey: "goal_key")
                        hasProfile = true
                        print("✅ 저장 완료")
                    }) {
                        Text("저장")
                            .font(Font.custom("Nunito", size: 18).weight(.bold))
                            .foregroundColor(hasChanges ? Color.white : Color.blue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(hasChanges ? Color.blue : Color.clear)
                            .cornerRadius(16)
                    }
                    .buttonStyle(PressableButtonStyle())
                    .disabled(!isFormComplete)
                }
                .padding(.horizontal, 16)
                
                // 프로필 이미지
                Group {
                    Image("PATH_TO_IMAGE")
                        .resizable()
                    //.aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 105.5)
                        .clipped()
                        .background(Color(red: 232/255, green: 242/255, blue: 254/255)) // HEX: E8F2FE
                        .cornerRadius(60)
                    
                        .padding(.top, 45)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)

                        Divider()
                            .frame(height: 24)
                            .background(Color.gray.opacity(0.7))

                        TextField("닉네임", text: $nickname)
                            .foregroundColor(.black)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.gray.opacity(0.7), lineWidth: 1)
                    )
                    .padding(.horizontal, 40)
                    .padding(.top, 40)
                    
                    // MARK: - Domain Chips
                    HStack(spacing: 12) {
                        ChipPickerView(title: "지원 분야", placeholder: "지원 분야 선택", options: Domain.allCases, selection: $supportSelection)
                        ChipPickerView(title: "희망 분야", placeholder: "희망 분야 선택", options: Domain.allCases, selection: $hopeSelection)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 25)
                    
                    LabeledTextEditor(title: "현재 학습 분야", placeholder: "Learning Point", text: $learningText)
                        .padding(.horizontal, 40)
                        .padding(.top, 16)

                    LabeledTextEditor(title: "ADA에서 9개월간의 최종 목표", placeholder: "Goal of ADA", text: $goalText)
                        .padding(.horizontal, 40)
                        .padding(.top, 8)
                }
                
                Spacer()
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview{
    ContentView2()
}
