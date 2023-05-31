import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    
    @State var editMode: EditMode = .active
    @State var isPre: Bool
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    func makeAllNumList(fibData: SeriesData) -> [Int]
    {
        let max = fibData.datas.serieses[fibData.datas.serieses.count - 1].num
        let nums: [Int] = Array(1...max+1)
        return nums
    }
    
    func appendNoBooks(fibData: Binding<SeriesData>, allList: [Int]) -> [Binding<SeriesData>]
    {
        var fibAllList: [Binding<SeriesData>] = []
        for i in allList
        {
            var exit: Bool = false
            for series in fibData.datas.serieses
            {
                if(series.num.wrappedValue == i)
                {
                    fibAllList.append(series)
                    exit = true
                }
            }
            if(exit == false)
            {
                @State var noSeries: SeriesData = SeriesData(title: "持ってない", num: i, datas: SeriesesAndDetailsData(serieses: [], details: []))
                fibAllList.append($noSeries)
            }
        }
        return fibAllList
    }
    
    func adjustSeriesesNum(fibAllSerieses: [Binding<SeriesData>])
    {
        var i: Int = 1
        for series in fibAllSerieses
        {
            series.num.wrappedValue = i
            i += 1
        }
    }
    
    var body: some View
    {
        let allNumList: [Int] = makeAllNumList(fibData: thisBooks)
        var allSerieses: [Binding<SeriesData>] = appendNoBooks(fibData: $thisBooks, allList: allNumList)
        
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
                    ForEach(allSerieses)
                    { series in
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
                    .onMove
                    { from, to in
                        allSerieses.move(fromOffsets: from, toOffset: to)
                        adjustSeriesesNum(fibAllSerieses: allSerieses)
                    }
                    .onDelete
                    { indexSet in
                        allSerieses.remove(atOffsets: indexSet)
                        adjustSeriesesNum(fibAllSerieses: allSerieses)
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
