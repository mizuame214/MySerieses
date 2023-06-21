import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    
    @State var editMode: EditMode = .active
    @State var isPreDet: Bool = false
    @State var isPreSer: Bool = false
    
    @State var detailData: Binding<DetailData>
    @State var seriesData: Binding<SeriesData>
    @State var allNumList: [Int] = []
    @State var allSerieses: [Binding<SeriesData>] = []
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    func makeAllNumList(fibData: SeriesData) -> [Int]
    {
        var max: Int = 1
        if(fibData.datas.serieses.count != 0)
        {
            max = fibData.datas.serieses[fibData.datas.serieses.count - 1 ].num + 1
        }
        let nums: [Int] = Array(1...max)
        return nums
    }

    func makeAllSeriesesList(fibData: Binding<SeriesData>, allList: [Int]) -> [Binding<SeriesData>]
    {
        var fibAllList: [Binding<SeriesData>] = []
        for i in allList
        {
            var exit: Bool = false
            if(fibData.datas.serieses.wrappedValue != [])
            {
                for series in fibData.datas.serieses
                {
                    if(series.num.wrappedValue == i)
                    {
                        fibAllList.append(series)
                        exit = true
                    }
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
                    }
                    .onDelete
                    { indexSet in
                        let fibAll = allNumList
                        allNumList.remove(atOffsets: indexSet)
                        allSerieses.remove(atOffsets: indexSet)
                        let removeNum = Array(1...fibAll[fibAll.count-1]).filter
                        {
                            v in return !allNumList.contains(v)
                        }
                        
                        for ser in $thisBooks.datas.serieses
                        {
                            if(ser.num.wrappedValue == removeNum[0])
                            {
                                thisBooks.datas.serieses.removeAll(where: {$0 == ser.wrappedValue})
                                allNumList = fibAll
                                allSerieses = makeAllSeriesesList(fibData: $thisBooks, allList: allNumList)
                                break
                            }
                        }
                        allNumList = makeAllNumList(fibData: thisBooks)
                        allSerieses = makeAllSeriesesList(fibData: $thisBooks, allList: allNumList)
                        adjustSeriesesNum(fibAllSerieses: allSerieses)
                    }
                    .sheet(isPresented: $isPreSer)
                    {
                        //noNumListをあげたいかも
                        EditSeriesSettingView(thisBooks: $thisBooks, series: seriesData, isPresentShown: $isPreSer)
                    }
                }
            }
            .onAppear
            {
                allNumList = makeAllNumList(fibData: thisBooks)
                allSerieses = makeAllSeriesesList(fibData: $thisBooks, allList: allNumList)
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
        .onChange(of: thisBooks)
        { thisBooks in
            allNumList = makeAllNumList(fibData: thisBooks)
            allSerieses = makeAllSeriesesList(fibData: $thisBooks, allList: allNumList)
        }
    }
}
