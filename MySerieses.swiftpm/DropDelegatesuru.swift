import SwiftUI

struct DropDelegatesuru: DropDelegate
{
    @Binding var toSeries: SeriesData
    @Binding var fromSeries: SeriesData
    @Binding var dragData: Any
    let check: Bool //toExitを確認するかどうか
    @Binding var dropNum: Int

    //手を離した時の挙動。データを更新する
    func performDrop(info: DropInfo) -> Bool
    {
        let toExit = whetherExitOrNo(checkSeries: toSeries, fibData: fromSeries, plus: true)
        //seriesが入ってきたら
        if(dragData is Binding<SeriesData>)
        {
            let series = dragData as! Binding<SeriesData>
            //行き先が自分じゃなければ
            if(series.wrappedValue != toSeries)
            {
                let exit = whetherExitOrNo(checkSeries: series.wrappedValue, fibData: fromSeries, plus: true)
                if(exit == false || (toExit == false && check))
                {
                    //ないシリーズを・に入れるとこの後の処理全キャンセル
                    print("cancell!!")
                    dropNum = -1
                    return true
                }
                
                var toInt :Int = 0
                if toSeries.datas.serieses.count != 0
                {
                    toInt = toSeries.datas.serieses[toSeries.datas.serieses.count-1].num
                }
                series.num.wrappedValue = toInt + 1 //いっちゃん最後のnum+1にする
                toSeries.datas.serieses.append(series.wrappedValue)
                //元の場所から消す
                fromSeries.datas.serieses.removeAll(where: {$0 == series.wrappedValue})
            }
        }
        //detailが入ってきたら
        else if(dragData is Binding<DetailData>)
        {
            if(toExit == false && check)
            {
                //ないシリーズに入れるとこの後の処理全キャンセル
                print("cancell!!")
                dropNum = -1
                return true
            }
            let detail = dragData as! Binding<DetailData>
            toSeries.datas.details.append(detail.wrappedValue)
            fromSeries.datas.details.removeAll(where: {$0 == detail.wrappedValue})
        }
        dropNum = -1
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        let toExit = whetherExitOrNo(checkSeries: toSeries, fibData: fromSeries, plus: true)
        if(toExit)
        {
            dropNum = toSeries.num
        }
        if(check == false)
        {
            dropNum = 0
        }
    }
    
    func dropExited(info: DropInfo)
    {
        dropNum = -1
    }
}
