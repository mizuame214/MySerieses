import Foundation
import SwiftUI

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

//fibNumsにある以外の数字の羅列を返す。plusがtrueならfibNums+1の羅列、falseならfibNumsまでの羅列
func makeNoNumList(fibData: SeriesData, plus: Bool) -> [Int]
{
    let fibNums = numberSort(fibData: fibData)
    var fibNoNumList: [Int] = []
    var p = 0
    if(plus)
    {
        p = 1
    }
    if fibNums != []
    {
        //1~最終巻+plusのIntリストから実際にあるリストを引く。
        fibNoNumList = Array(1...fibNums[fibNums.count - 1] + p).filter
        {
            v in return !fibNums.contains(v)
        }
    }
    else if(plus)
    {
        fibNoNumList.append(1)
    }
    return fibNoNumList
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

func whetherExitOrNo(checkSeries: SeriesData, fibData: SeriesData, plus: Bool) -> Bool
{
    let noNumList = makeNoNumList(fibData: fibData, plus: plus)
    for i in noNumList
    {
        //もし無いリストにあるseriesだったら
        if(checkSeries.num == i)
        {
            return false
        }
    }
    return true
}
