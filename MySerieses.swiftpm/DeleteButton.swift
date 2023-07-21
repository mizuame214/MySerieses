import SwiftUI

struct DeleteButton: View
{
    let data: Any
    @State var isPresentShown : Bool = false
    @Binding var thisBooks: SeriesData
    @Binding var allSerieses: [Binding<SeriesData>]
    
    var body: some View
    {
        VStack
        {
            Button
            {
                isPresentShown = true
            }
            label:
            {
                ZStack
                {
                    Circle()
                    .fill(.red)
                    .frame(width:20, height:20)
                    .shadow(radius: 1)
                    
                    Text("ー")
                    .font(.system(size:12))
                    .foregroundColor(.white)
                }
            }
            .alert(isPresented: $isPresentShown)
            {
                Alert(title: Text("削除しますか？"),
                    primaryButton: .cancel(Text("いいえ")),
                    secondaryButton: .destructive(Text("はい"),
                        action:
                        {
                    if(data is DetailData)
                    {
                        let detail = data as! DetailData
                        thisBooks.datas.details.removeAll(where: {$0 == detail})
                    }
                    else if(data is SeriesData)
                    {
                        let series = data as! SeriesData
                        //削除します
                        let exit = whetherExitOrNo(checkSeries: series, fibData: thisBooks, plus: true)
                        if(exit)
                        {
                            thisBooks.datas.serieses.removeAll(where: {$0 == series})
                        }
                        else
                        {
                            if(series.num != thisBooks.datas.serieses[thisBooks.datas.serieses.count-1].num+1)
                            {
                                allSerieses.remove(atOffsets: [series.num-1])
                                adjustSeriesesNum(fibAllSerieses: allSerieses)
                            }
                        }
                    }
                        }
                    )
                )
            }
        }
    }
}
