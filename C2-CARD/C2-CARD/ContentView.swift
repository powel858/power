import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center){
                Text("작성된 프로필이 없어요 프로필을 작성해주세요!")
                    .fontWeight(.bold)
                    .font(.title)
                
                NavigationLink(destination: ContentView2()) {
                    Text("작성하기")
                        .foregroundColor(.white)
                        .frame(width: 130, height: 50)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
            }
        }
    }
}

#Preview{
    ContentView()
}
