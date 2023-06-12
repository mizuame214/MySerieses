import SwiftUI

struct EditSeriesSettingView: View
{
    @Binding var series: SeriesData  //変更するデータ
    @Binding var isPresentShown: Bool
    
    @State var fibTitle: String = ""
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text("タイトル")
                Spacer()
            }
            .onAppear
            {
                fibTitle = series.title
            }
            TextField("タイトル", text: $fibTitle)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            .padding(.bottom, 15)
            
            //作成ボタン
            HStack
            {
                Button
                {
                    series = SeriesData(title: fibTitle, num: series.num, datas: series.datas)
                    isPresentShown = false
                }
                label:
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius:8)
                        .frame(maxWidth:200, maxHeight:60)
                        .foregroundColor(.teal)
                        .shadow(radius: 3)
                        .padding(.vertical, 25)
                        //あとで「更新」だけにする。
                        Text("シリーズ更新")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(40)
    }
}
