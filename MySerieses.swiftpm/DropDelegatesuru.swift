import SwiftUI

struct DropDelegatesuru: DropDelegate
{
    @Binding var toSeries: SeriesData
    @Binding var fromSeries: SeriesData
    @Binding var series: Binding<SeriesData>
    @Binding var viewColor: Color
    let check: Bool //toExitを確認するかどうか

    //手を離した時の挙動。データを更新する
    func performDrop(info: DropInfo) -> Bool
    {
        let exit = whetherExitOrNo(checkSeries: series.wrappedValue, fibData: fromSeries, plus: true)
        let toExit = whetherExitOrNo(checkSeries: toSeries, fibData: fromSeries, plus: true)
        if(exit == false || (toExit == false && check))
        {
            //ないシリーズを・に入れるとこの後の処理全キャンセル
            print("cancell!!")
            return true
        }
        
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
        let exit = whetherExitOrNo(checkSeries: series.wrappedValue, fibData: fromSeries, plus: true)
        if(exit)
        {
            viewColor = .blue
        }
        else
        {
            viewColor = .red
        }
    }
}
