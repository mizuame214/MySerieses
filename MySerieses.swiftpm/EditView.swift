import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    
    @State var editMode: EditMode = .active
    @State var isPreDet: Bool = false
    @State var isPreSer: Bool = false
    
    var noNumList: [Int]
    
    @State var detailData: Binding<DetailData>
    @State var seriesData: Binding<SeriesData>
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    func makeAllNumList(fibData: SeriesData) -> [Int]
    {
        let max = fibData.datas.serieses[fibData.datas.serieses.count - 1].num
        let nums: [Int] = Array(1...max+1)
        return nums
    }
    
    func makeAllSeriesesList(fibData: Binding<SeriesData>, allList: [Int]) -> [Binding<SeriesData>]
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
                @State var noSeries: SeriesData = SeriesData(title: "持ってないよ", num: i, datas: SeriesesAndDetailsData(serieses: [], details: []))
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
        //Stateじゃ無いとちゃんと動かないのでは？
        var allNumList: [Int] = makeAllNumList(fibData: thisBooks)
        var allSerieses: [Binding<SeriesData>] = makeAllSeriesesList(fibData: $thisBooks, allList: allNumList)
        
        ZStack
        {
            List
            {
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        Button
                        {
                            detailData = detail
                            isPreDet = true
                        }
                        label:
                        {
                            InfoView(title: detail.title.wrappedValue, mainText: detail.message.wrappedValue)
                            .foregroundColor(.black)
                        }
                    }
                    .onMove
                    { from, to in
                        thisBooks.datas.details.move(fromOffsets: from, toOffset: to)
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.details.remove(atOffsets: indexSet)
                    }
                    .sheet(isPresented: $isPreDet)
                    {
                        EditDetailSettingView(detail: detailData, isPresentShown: $isPreDet)
                    }
                }
                
                //シリーズ部分の表示
                Section
                {
                    ForEach(allSerieses)
                    { series in
                        Button
                        {
                            seriesData = series
                            isPreSer = true
                        }
                        label:
                        {
                            AList(data: series.wrappedValue)
                            .foregroundColor(.black)
                        }
                    }
                    .onMove
                    { from, to in
                        allSerieses.move(fromOffsets: from, toOffset: to)
                        adjustSeriesesNum(fibAllSerieses: allSerieses)
                        allNumList = makeAllNumList(fibData: thisBooks)
                    }
                    .onDelete
                    { indexSet in
                        //持ってるシリーズ消すと重複したシリーズが何故か増えたりすることがあるなんとかして。持ってるシリーズ消したらそのシリーズが空のデータになるようにしておきたい。勝手に詰めないで欲しい。
                        //もし持ってるシリーズなら、持ってないシリーズなら
                        //メモ
                        //self.thisBooks.datas.serieses = thisBooks.datas.serieses.sorted { $0.num < $1.num }
                        
                        //indexSetがnumと対応してないから、消すと変なとこが消えちゃう
                    }
                    .sheet(isPresented: $isPreSer)
                    {
                        //noNumListをあげたい
                        EditSeriesSettingView(thisBooks: $thisBooks, series: seriesData, isPresentShown: $isPreSer)
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
