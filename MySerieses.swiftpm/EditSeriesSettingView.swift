import SwiftUI

struct EditSeriesSettingView: View
{
    @Binding var thisBooks: SeriesData  //裏で表示されてる、追加しようとしてるシリーズデータ
    
    @Binding var series: SeriesData  //変更するデータ
    @Binding var isPresentShown: Bool
    
    @State var fibTitle: String = ""
    @State var textFieldText = "タイトル"
    
    @State var exit:Bool = true
    
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
                //持ってないよ　っていうシリーズが作れなくなっちゃうから、条件変えたい
                //noNumListにあったらたしかfor使えたよねこの中
                if(series.title == "持ってないよ")
                {
                    exit = false
                    textFieldText = "持ってないよ"
                }
                else
                {
                    fibTitle = series.title
                }
            }
            TextField(textFieldText, text: $fibTitle)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            .padding(.bottom, 15)
            
            //作成ボタン
            HStack
            {
                Button
                {
                    if(exit)
                    {
                        series = SeriesData(title: fibTitle, num: series.num, datas: series.datas)
                    }
                    else
                    {
                        thisBooks.datas.serieses.append(SeriesData(title: fibTitle, num: series.num, datas: SeriesesAndDetailsData(serieses: [], details: [])))
                    }
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
                        Text(exit ? "シリーズ更新" : "作成")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(40)
    }
}
