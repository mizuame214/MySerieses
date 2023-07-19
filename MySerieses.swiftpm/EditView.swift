import SwiftUI

struct EditView: View
{
    @State var color: Color = .mint
    
    @Binding var thisBooks: SeriesData
    @Binding var upBooks: SeriesData
    
    //@State var editMode: EditMode = .active
    @State var isPreDet: Bool = false
    @State var isPreSer: Bool = false
    
    @State var detailData: Binding<DetailData>
    @State var seriesData: Binding<SeriesData>
    @State var allNumList: [Int] = []
    @State var allSerieses: [Binding<SeriesData>] = []
    //@State var detailList: [DetailData] = []
    
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
            //仮の場所
            if(thisBooks.title != "Top")
            {
                DragAndDrop2UpView(upBooksTitle: $upBooks.title.wrappedValue)
                .padding()
                .onDrop(of: [""], delegate:  DropDelegatesuru(toSeries: $upBooks, fromSeries: $thisBooks, dragData: $dragData, viewColor: $dragColor, check: false))
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
                        Rectangle()
                        .frame(height: 10)
                        .foregroundColor(.mint)
                        .onDrop(of: [""], delegate: DropDelegateDetail(details: $thisBooks.datas.details, i: 0, dragData: dragData))
                        ForEach($thisBooks.datas.details)
                        { detail in
                            HStack
                            {
                                DeleteButton(detailData: detail.wrappedValue, detailOrSeries: true, data: SeriesData(title: "", num: -1, datas: SeriesesAndDetailsData(serieses: [], details: [])), thisBooks: $thisBooks, allNumList: $allNumList, allSerieses: $allSerieses)
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
                                preview:
                                {
                                    //ドラッグ中の見た目
                                }
                            }
                            //隙間で.onMove
                            Rectangle()
                            .frame(height: 10)
                            .foregroundColor(.mint)
                            .onDrop(of: [""], delegate: DropDelegateDetail(details: $thisBooks.datas.details, i: thisBooks.datas.details.firstIndex(of: detail.wrappedValue)!+1, dragData: dragData))
                        }
                    }
                }
                
                //シリーズ部分の表示
                Section
                {
                    VStack(spacing: 0)
                    {
                        Rectangle()
                        .frame(maxHeight: 20)
                        .foregroundColor(.mint)
                        .onDrop(of: [""], delegate: DropDelegateSurutoMove(allSerieses: $allSerieses, i: 0, dragData: dragData))
                        ForEach(allSerieses)
                        { series in
                            HStack
                            {
                                DeleteButton(detailData: DetailData(title: "", message: ""), detailOrSeries: false, data: series.wrappedValue, thisBooks: $thisBooks, allNumList: $allNumList, allSerieses: $allSerieses)
                                Button
                                {
                                    seriesData = series
                                    isPreSer = true
                                }
                                label:
                                {
                                    AList(data: series.wrappedValue, edit: true, thisBooks: $thisBooks)
                                        .foregroundColor(.black)
                                }
                                .onDrag
                                {
                                    dragData = series
                                    //こいつのせいでプレビューが使えないドラッグもプレビューで使えなくなったカス
                                    return NSItemProvider(object: NSString())
                                }
                                preview:
                                {
                                    //もしないシリーズをリストの中に入れようとしてたら見た目も変えたいよね。そうなると判定方法別にとった方がいいよね。
                                    //ドラッグ中の見た目
                                    Rectangle()
                                        .frame(width : 100, height: 100)
                                    .foregroundColor(dragColor)
                                }
                                //seriesはBinding<SeriesData>、toSeriesはSeriesDataなの問題ありそう。今のところ問題ない。toSeriesをBinding<>にして、別の変数に一回コピってそいつにappendして、そいつをtoSeriesに入れる方法があるけどようわからん。
                                .onDrop(of: [""], delegate:  DropDelegatesuru(toSeries: series, fromSeries: $thisBooks, dragData: $dragData, viewColor: $dragColor, check: true))
                            }
                            //隙間で.onMove
                            Rectangle()
                            .frame(height: 10)
                            .foregroundColor(.mint)
                            .onDrop(of: [""], delegate: DropDelegateSurutoMove(allSerieses: $allSerieses, i: series.num.wrappedValue, dragData: dragData))
                        }
                    }
                }
                .onChange(of: thisBooks)
                { thisBooks in
                    allNumList = makeAllNumList(fibData: $thisBooks)
                    allSerieses = makeAllSeriesesList(allList: allNumList, fibData: $thisBooks)
                    noNumList = makeNoNumList(fibData: thisBooks, plus: false)                }
            }
            .onAppear
            {
                allNumList = makeAllNumList(fibData: $thisBooks)
                allSerieses = makeAllSeriesesList(allList: allNumList,fibData: $thisBooks)
                noNumList = makeNoNumList(fibData: thisBooks, plus: false)
            }
            .padding(.horizontal, 20)
            //.listStyle(.insetGrouped)
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
