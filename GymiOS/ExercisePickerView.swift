import SwiftUI

struct ExercisePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedExercises: Set<Exercise>
    let allExercises: [Exercise]
    
    @State private var searchText: String = ""
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return allExercises
        } else {
            return allExercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea()
            SheetBackgroundFix(color: UIColor(red: 0.08, green: 0.08, blue: 0.10, alpha: 1.0))
                .allowsHitTesting(false)
                .frame(width: 0, height: 0)
            NavigationStack {
                List {
                    ForEach(filteredExercises) { exercise in
                        Button(action: {
                            if selectedExercises.contains(exercise) {
                                selectedExercises.remove(exercise)
                            } else {
                                selectedExercises.insert(exercise)
                            }
                        }) {
                            HStack {
                                Image(systemName: selectedExercises.contains(exercise) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(selectedExercises.contains(exercise) ? .accentColor : .gray)
                                Text(exercise.name)
                                    .foregroundColor(.white)
                            }
                            .frame(height: 32) // Add fixed, thinner row height
                        }
                        .buttonStyle(.automatic)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(red: 0.08, green: 0.08, blue: 0.10))
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("Select Exercises")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: { dismiss() }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Back")
                            }
                        }
                    }
                }
                .toolbarBackground(Color(red: 0.08, green: 0.08, blue: 0.10), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
            }
            .preferredColorScheme(.dark)
        }
        .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
    }
}

// Example preview with placeholder data
#Preview {
    ExercisePickerView(selectedExercises: .constant([]), allExercises: [
        Exercise(name: "Bench Press"),
        Exercise(name: "Squat"),
        Exercise(name: "Deadlift"),
        Exercise(name: "Pull Up"),
        Exercise(name: "Push Up")
    ])
}
