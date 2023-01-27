import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    
    @State var editMode: EditMode = .active
    @State var isPre: Bool
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    var body: some View
    {
        var nums: [Int] = FirstView(thisBooks: $thisBooks).numberSort(fibData: thisBooks)
        
        ZStack
        {
            List
            {
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        Button(action:
                        {
                            isPre = true
                        },
                        label:
                        {
                            InfoView(title: detail.title.wrappedValue, mainText: detail.message.wrappedValue)
                        })
                        .sheet(isPresented: $isPre)
                        {
                            //一つ一つリストの編集画面
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
                }
                //シリーズ部分の表示
                Section
                {
                    ForEach(nums, id: \.self)
                    { num in
                        ForEach($thisBooks.datas.serieses)
                        { series in
                            if num == series.num.wrappedValue
                            {
                                Button( action:
                                {
                                    isPre = true
                                },
                                label:
                                {
                                    AList(data: series.wrappedValue)
                                })
                                .sheet(isPresented: $isPre)
                                {
                                    //一つ一つリストの編集画面
                                }
                            }
                        }
                    }
                    .onMove
                    { from, to in
                        thisBooks.datas.serieses.move(fromOffsets: from, toOffset: to)
                    }
                    .onDelete
                    { indexSet in
                        //indexSetより後ろのnumsのシリーズnumを-1
                        thisBooks.datas.serieses.remove(atOffsets: indexSet)
                    }
                    .onChange(of: thisBooks)
                    { thisBooks in
                        
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(thisBooks.title)
            //.onMoveがEditMode無しで動くならいらないとこ
            .navigationBarBackButtonHidden(true)
            .toolbar
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button
                    {
                        dismiss()
                    }
                    label:
                    {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .environment(\.editMode, self.$editMode)
        }
    }
}
