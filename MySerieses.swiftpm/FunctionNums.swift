import Foundation

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
func makeNoNumList(fibNums: [Int], plus: Bool) -> [Int]
{
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
