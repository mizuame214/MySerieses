import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    
    @State var editMode: EditMode = .active
    @State var isPre: Bool
    var noNumList: [Int]
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    func makeAllList(fibData: SeriesData) -> [Int]
    {
        let max = fibData.datas.serieses[fibData.datas.serieses.count - 1].num
        let nums: [Int] = Array(1...max+1)
        return nums
    }
    
    var body: some View
    {
        let allList: [Int] = makeAllList(fibData: thisBooks)
        
        ZStack
        {
            List
            {
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        //ちょっと表示方法ダサいかも
                        EditInfoView(title: detail.title, mainText: detail.message)
                    }
                    .onMove
                    { from, to in
                        thisBooks.datas.details.move(fromOffsets: from, toOffset: to)
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.details.remove(atOffsets: indexSet)
                    }
                }
                //シリーズ部分の表示
                Section
                {
                    ForEach(allList, id: \.self)
                    { num in
                        ForEach($thisBooks.datas.serieses)
                        { series in
                            if(series.num.wrappedValue == num)
                            {
                                //fibSeriesData.append(series)
                                Button
                                {
                                    isPre = true
                                }
                                label:
                                {
                                    AList(data: series.wrappedValue)
                                }
                                .sheet(isPresented: $isPre)
                                {
                                    //一つ一つリストの編集画面
                                }
                            }
                        }
                        //苦肉の策な気はする
                        ForEach(noNumList, id: \.self)
                        { noNum in
                            if(noNum == num)
                            {
                                AList(data: SeriesData(title: "持ってない", num: num, datas: SeriesesAndDetailsData(serieses: [], details: [])))
                            }
                        }
                    }
                    .onMove
                    { from, to in
                        thisBooks.datas.serieses.move(fromOffsets: from, toOffset: to)
                        //上から順にnumをallListにする
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.serieses.remove(atOffsets: indexSet)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(thisBooks.title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                Button( action:
                {
                    dismiss()
                },
                label:
                {
                    Image(systemName: "checkmark")
                })
            )
            .environment(\.editMode, self.$editMode)
        }
    }
}
