import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    @Binding var upBooks: SeriesData
    
    //@State var editMode: EditMode = .active
    @State var isPreDet: Bool = false
    @State var isPreSer: Bool = false
    
    @State var detailData: Binding<DetailData>
    @State var seriesData: Binding<SeriesData>
    @State var allNumList: [Int] = []
    @State var allSerieses: [Binding<SeriesData>] = []
    
    @State var dropNum: Int = -1
    @State var irekoNum: Int = -1
    
    @State var nums: [Int] = []
    @State var noNumList: [Int] = []
    
    @State var dragData: Any
    @State var dragColor: Color = .white
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    func makeAllNumList(fibData: Binding<SeriesData>) -> [Int]
    {
        self.thisBooks.datas.serieses = thisBooks.datas.serieses.sorted { $0.num < $1.num }
        var max: Int = 1
        if(fibData.datas.serieses.count != 0)
        {
            max = fibData.datas.serieses[fibData.datas.serieses.count - 1 ].num.wrappedValue + 1
        }
        let nums: [Int] = Array(1...max)
        return nums
    }

    func makeAllSeriesesList(allList: [Int], fibData: Binding<SeriesData>) -> [Binding<SeriesData>]
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
                        break
                    }
                }
            }
            if(exit == false)
            {
                @State var noSeries: SeriesData = SeriesData(title: "-------------------------", num: i, datas: SeriesesAndDetailsData(serieses: [], details: []))
                fibAllList.append($noSeries)
            }
        }
        return fibAllList
    }
    
    var body: some View
    {
        VStack
        {
            if(thisBooks.title != "Top")
            {
                DragAndDrop2UpView(upBooksTitle: $upBooks.title.wrappedValue)
                    .onDrop(of: [""], delegate:  DropDelegatesuru(toSeries: $upBooks, fromSeries: $thisBooks, dragData: $dragData, check: false, dropNum: $irekoNum))
                    .background(0 == irekoNum ? .teal.opacity(0.5) : .white)
            }
            
            ScrollView
            {
                //無い巻の表示
                if noNumList != []
                {
                    let noNumStr = noNumList.map {String($0)}
                    let text: String = noNumStr.joined(separator: ", ")
                    InfoView(title: "無い巻", mainText: text)
                }
                
                //詳細部分の表示
                Section
                {
                    VStack(spacing: 0)
                    {
                        ForOnMoveBetweenView(i: 0, dropNum: $dropNum, dragData: $dragData, detailOrSeries: true)
                        .onDrop(of: [""], delegate: DropDelegateDetail(details: $thisBooks.datas.details, i: 0, dragData: dragData, dropNum: $dropNum))
                        ForEach($thisBooks.datas.details)
                        { detail in
                            HStack
                            {
                                DeleteButton(data: detail.wrappedValue, thisBooks: $thisBooks, allSerieses: $allSerieses)
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
                                .onDrag
                                {
                                    dragData = detail
                                    return NSItemProvider(object: NSString())
                                }
                            }
                            //隙間で.onMove
                            let i = thisBooks.datas.details.firstIndex(of: detail.wrappedValue)!+1
                            ForOnMoveBetweenView(i: i, dropNum: $dropNum, dragData: $dragData, detailOrSeries: true)
                            .onDrop(of: [""], delegate: DropDelegateDetail(details: $thisBooks.datas.details, i: i, dragData: dragData, dropNum: $dropNum))
                        }
                    }
                }
                
                //シリーズ部分の表示
                Section
                {
                    VStack(spacing: 0)
                    {
                        ForOnMoveBetweenView(i: 0, dropNum: $dropNum, dragData: $dragData, detailOrSeries: false)
                        .onDrop(of: [""], delegate: DropDelegateSurutoMove(allSerieses: $allSerieses, i: 0, dragData: dragData, dropNum: $dropNum))
                        ForEach(allSerieses)
                        { series in
                            HStack
                            {
                                DeleteButton(data: series.wrappedValue, thisBooks: $thisBooks, allSerieses: $allSerieses)
                                Button
                                {
                                    seriesData = series
                                    isPreSer = true
                                }
                                label:
                                {
                                    AList(data: series.wrappedValue, edit: true, thisBooks: $thisBooks)
                                    .foregroundColor(.black)
                                    .background(series.num.wrappedValue == irekoNum ? .teal.opacity(0.5) : .white)
                                    //まずはあるシリーズに入れようとするとあるシリーズの色がうっすら青くなるのを作りましょう
                                }
                                .onDrag
                                {
                                    dragData = series
                                    return NSItemProvider(object: NSString())
                                }
                                //seriesはBinding<SeriesData>、toSeriesはSeriesDataなの問題ありそう。今のところ問題ない。toSeriesをBinding<>にして、別の変数に一回コピってそいつにappendして、そいつをtoSeriesに入れる方法があるけどようわからん。
                                .onDrop(of: [""], delegate:  DropDelegatesuru(toSeries: series, fromSeries: $thisBooks, dragData: $dragData, check: true, dropNum: $irekoNum))
                            }
                            //隙間で.onMove
                            let i = series.num.wrappedValue
                            ForOnMoveBetweenView(i: i, dropNum: $dropNum, dragData: $dragData, detailOrSeries: false)
                            .onDrop(of: [""], delegate: DropDelegateSurutoMove(allSerieses: $allSerieses, i: i, dragData: dragData, dropNum: $dropNum))
                        }
                    }
                }
                .onChange(of: thisBooks)
                { thisBooks in
                    allNumList = makeAllNumList(fibData: $thisBooks)
                    allSerieses = makeAllSeriesesList(allList: allNumList, fibData: $thisBooks)
                    noNumList = makeNoNumList(fibData: thisBooks, plus: false)
                }
            }
            .onAppear
            {
                allNumList = makeAllNumList(fibData: $thisBooks)
                allSerieses = makeAllSeriesesList(allList: allNumList,fibData: $thisBooks)
                noNumList = makeNoNumList(fibData: thisBooks, plus: false)
            }
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
            //.environment(\.editMode, self.$editMode)
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $isPreSer)
        {
            EditSeriesSettingView(thisBooks: $thisBooks, series: $seriesData, isPresentShown: $isPreSer)
        }
        .sheet(isPresented: $isPreDet)
        {
            EditDetailSettingView(detail: detailData, isPresentShown: $isPreDet)
        }
    }
}
