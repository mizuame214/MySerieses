import SwiftUI

//八日以前
struct DeleteButton: View
{
    let detailData: DetailData
    
    let detailOrSeries: Bool
    
    @State var isPresentShown : Bool = false
    let data: SeriesData
    @Binding var thisBooks: SeriesData
    @Binding var allNumList: [Int]
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
                    if(detailOrSeries)
                    {
                        thisBooks.datas.details.removeAll(where: {$0 == detailData})
                    }
                    else
                    {
                        //削除します
                        let exit = whetherExitOrNo(checkSeries: data, fibData: thisBooks, plus: true)
                        if(exit)
                        {
                            thisBooks.datas.serieses.removeAll(where: {$0 == data})
                        }
                        else
                        {
                            if(data.num != thisBooks.datas.serieses[thisBooks.datas.serieses.count-1].num+1)
                            {
                                allSerieses.remove(atOffsets: [data.num-1])
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
