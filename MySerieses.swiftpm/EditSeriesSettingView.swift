import SwiftUI

struct EditSeriesSettingView: View
{
    @Binding var thisBooks: SeriesData  //裏で表示されてる、追加しようとしてるシリーズデータ
    
    @Binding var series: Binding<SeriesData>  //変更するデータ
    @Binding var isPresentShown: Bool
    
    @State var fibTitle: String = ""
    @State var textFieldText = "タイトル"
    
    @State var exit:Bool = true
    
    var body: some View
    {
        let noNumList = makeNoNumList(fibData: thisBooks, plus: true)
        
        VStack
        {
            HStack
            {
                Text("タイトル")
                Spacer()
            }
            .onAppear
            {
                for no in noNumList
                {
                    if(series.num.wrappedValue == no)
                    {
                        exit = false
                        textFieldText = "持ってないよ"
                        break
                    }
                }
                if(exit)
                {
                    fibTitle = series.title.wrappedValue
                }
            }
            TextField(textFieldText, text: $fibTitle)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            .padding(.bottom, 15)
            
            //更新作成ボタン
            HStack
            {
                Button
                {
                    if(exit)
                    {
                        series.wrappedValue = SeriesData(title: fibTitle, num: series.num.wrappedValue, datas: series.datas.wrappedValue)
                    }
                    else
                    {
                        thisBooks.datas.serieses.append(SeriesData(title: fibTitle, num: series.num.wrappedValue, datas: SeriesesAndDetailsData(serieses: [], details: [])))
                    }
                    isPresentShown = false
                }
                label:
                {
                    ZStack
                    {
                        DicisionButtonView(text: exit ? "更新" : "作成")
                        .foregroundColor(.teal)
                    }
                }
            }
        }
        .padding(40)
    }
}
