import SwiftUI

struct ForOnMoveBetweenView: View
{
    @Binding var canDrop: Bool
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            Rectangle()
            .frame(height: 5)
            .foregroundColor(.mint)
            Rectangle()
            .frame(height: 1)
            .foregroundColor(canDrop ? .red : .mint)
            Rectangle()
            .frame(height: 5)
            .foregroundColor(.mint)
        }
    }
}
