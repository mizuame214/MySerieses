import SwiftUI

struct DropDelegatesuru: DropDelegate
{
    @Binding var toSeries: SeriesData
    @Binding var fromSeries: SeriesData
    @Binding var series: Binding<SeriesData>

    //手を離した時の挙動。データを更新する
    func performDrop(info: DropInfo) -> Bool
    {
        var toInt :Int = 0
        if toSeries.datas.serieses.count != 0
        {
            toInt = toSeries.datas.serieses[toSeries.datas.serieses.count-1].num
        }
        series.num.wrappedValue = toInt + 1   //いっちゃん最後のnum+1にする
        toSeries.datas.serieses.append(series.wrappedValue)
        //元の場所から消す
        fromSeries.datas.serieses.removeAll(where: {$0 == series.wrappedValue})
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        
    }
}
