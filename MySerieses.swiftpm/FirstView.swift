import SwiftUI

struct FirstView: View {
    @Binding var thisBooks: SeriesData
    var noNumList: [Int] = []
    
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
    
    func noNumList(fibNums: [Int]) -> [Int]
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
        let noNumList: [Int] = noNumList(fibNums: nums)
        
        ZStack
        {
            List
            {
                //無い巻の表示
                if noNumList != []
                {
                    let noNumStr = noNumList.map {String($0)}
                    Text(noNumStr.joined(separator: ", "))
                }
                
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        InfoView(title: detail.title.wrappedValue, mainText: detail.message.wrappedValue)
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.details.remove(atOffsets:indexSet)
                    }
                }
                //シリーズ部分の表示
                Section
                {
                    ForEach(nums, id: \.self)
                    { num in
                        ForEach($thisBooks.datas.serieses)
                        { series in
                            //ソートできたけど同じシリーズ番号があると増殖する
                            if num == series.num.wrappedValue
                            {
                                NavigationLink( destination:
                                {
                                    FirstView(thisBooks: series)
                                },
                                label:
                                {
                                    AList(data:series.wrappedValue)
                                })
                            }
                        }
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.serieses.remove(atOffsets:indexSet)
                        //これより下のnumを-1する
                    }
                    .onChange(of: thisBooks)
                    {thisBooks in
                        nums = numberSort(fibData: thisBooks)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(thisBooks.title)
            .onAppear
            {
                //データ削除
                //SeriesData.clear(path: seriesJsonPath)
            }
            
            PlusButton(thisBooks: $thisBooks, noNumList: noNumList, nums: nums)
        }
    }
}
