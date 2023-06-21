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
        let nums = numberSort(fibData: thisBooks)
        let noNumList = makeNoNumList(fibNums: nums, plus: true)
        
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
                    if(series.num == no)
                    {
                        exit = false
                        textFieldText = "持ってないよ"
                        break
                    }
                }
                if(exit)
                {
                    fibTitle = series.title
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
                        Text(exit ? "更新" : "作成")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(40)
    }
}
