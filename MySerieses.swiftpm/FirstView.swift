import SwiftUI

struct FirstView: View
{
    @Binding var thisBooks: SeriesData
    @State var editMode: EditMode = .inactive
    
    //画面に映ってるシリーズのnumたちをappendしてソートする。
    func numberSort(fibData: SeriesData) -> [Int]
    {
        var fibNums: [Int] = []
        for series in fibData.datas.serieses
        {
            fibNums.append(series.num)
        }
        fibNums.sort{$0 < $1}
        return fibNums
    }
    
    func makeNoNumList(fibNums: [Int]) -> [Int]
    {
        var fibNoNumList: [Int] = []
        if fibNums != []
        {
            //1~最終巻のIntリストから実際にあるリストを引く。
            fibNoNumList = Array(1...fibNums[fibNums.count - 1]).filter
            {
                v in return !fibNums.contains(v)
            }
        }
        return fibNoNumList
    }
    
    var body: some View
    {
        var nums: [Int] = numberSort(fibData: thisBooks)
        var noNumList: [Int] = makeNoNumList(fibNums: nums)
        
        ZStack
        {
            List
            {
                //※無い巻の表示どうしよう
                if noNumList != []
                {
                    let noNumStr = noNumList.map {String($0)}
                    let text: String = noNumStr.joined(separator: ", ")
                    InfoView(title: "無い巻", mainText: text)
                }
                
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        InfoView(title: detail.title.wrappedValue, mainText: detail.message.wrappedValue)
                    }
                }
                //シリーズ部分の表示
                Section
                {
                    ForEach($thisBooks.datas.serieses)
                    { series in
                        NavigationLink( destination:
                        {
                            FirstView(thisBooks: series)
                        },
                        label:
                        {
                            AList(data: series.wrappedValue)
                        })
                    }
                    
                }
            }
            .listStyle(.insetGrouped)
            .onAppear
            {
                //データ削除
                //SeriesData.clear(path: seriesJsonPath)
            }
            .onChange(of: thisBooks)
            { thisBooks in
                nums = numberSort(fibData: thisBooks)
                noNumList = makeNoNumList(fibNums: nums)
                
                self.thisBooks.datas.serieses = thisBooks.datas.serieses.sorted { $0.num < $1.num }
            }
            .navigationTitle(thisBooks.title)
            
            //編集モード用
            .navigationBarItems(trailing:
                NavigationLink(
                    destination:
                        {
                            EditView(thisBooks: $thisBooks, isPre: false)
                        },
                        label:
                        {
                            Image.init(systemName: "square.and.pencil")
                        }
                )
            )
            .environment(\.editMode, self.$editMode)
            
            PlusButton(thisBooks: $thisBooks, noNumList: noNumList, nums: nums)
        }
    }
}

