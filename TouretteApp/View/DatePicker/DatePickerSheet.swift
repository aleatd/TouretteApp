import SwiftUI

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .scaleEffect(1.25)
                .padding(.vertical, 20)
            
            Button("Done") {
                dismiss()
            }
            .frame(width: 280, height: 70)
            .background(.greenVariant)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.sand.opacity(0.65))
        .ignoresSafeArea()
        .presentationDetents([.medium])
    }
}
