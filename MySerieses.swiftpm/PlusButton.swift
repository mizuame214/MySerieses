import SwiftUI

struct PlusButton: View
{
    @State var isPresentShown:Bool = false
    //今表示されてるシリーズデータ
    @Binding var thisBooks: SeriesData
    
    var body: some View
    {
        HStack
        {
            Spacer()
            VStack
            {
                Spacer()
                Button
                {
                    isPresentShown = true
                }
                label:
                {
                    ZStack
                    {
                        Circle()
                        .fill(.white)
                        .frame(width:40, height:40)
                        .shadow(radius: 2)
                        
                        Text("＋")
                        .font(.system(size:30))
                        .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $isPresentShown)
                {
                    DetailSettingView(thisBooks: $thisBooks, isPresentShown: $isPresentShown)
                }
            }
            .padding()
        }
    }
}
