import SwiftUI

struct ExerciseListView: View {
    @Binding var workout: Workout
    @State private var showExercisePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(workout.name)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.blue)
                .padding(.top, 32)
            if workout.exercises.isEmpty {
                Text("No exercises listed currently ):")
                    .foregroundColor(Color(white: 0.7))
                    .font(.system(size: 18))
            } else {
                List {
                    Section {
                        ForEach(workout.exercises) { exercise in
                            Button(action: {
                                print("Tapped on \\(exercise.name)")
                            }) {
                                HStack {
                                    Text(exercise.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                        .padding(.leading, 16)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(white: 0.6))
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.trailing, 16)
                                }
                                .frame(height: 32) // Reduced from 44
                            }
                            .buttonStyle(HighlightableRowButtonStyle())
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color(red: 0.20, green: 0.20, blue: 0.22))
                                    .padding(.vertical, 2)
                            )
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Color(red: 0.08, green: 0.08, blue: 0.10))
            }
            Spacer()
            VStack(spacing: 12) {
                Button(action: {
                    showExercisePicker = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 72, height: 72)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 36, weight: .bold))
                    }
                }
                Text("Add Exercise")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 24)
        .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(red: 0.08, green: 0.08, blue: 0.10), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $showExercisePicker) {
            ExercisePickerView(
                selectedExercises: Binding<Set<Exercise>>(
                    get: { Set(workout.exercises) },
                    set: { newSet in workout.exercises = Array(newSet) }
                ),
                allExercises: [
                    Exercise(name: "Bench Press"),
                    Exercise(name: "Squat"),
                    Exercise(name: "Deadlift"),
                    Exercise(name: "Pull Up"),
                    Exercise(name: "Push Up")
                ]
            )
            .presentationBackground(Color(red: 0.08, green: 0.08, blue: 0.10))
            .presentationDetents([.large])
        }
    }
}

struct HighlightableRowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(configuration.isPressed ? Color(red: 0.13, green: 0.13, blue: 0.15) : Color(red: 0.20, green: 0.20, blue: 0.22))
                }
            )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var workout = Workout(name: "Push Day", description: "Chest, Shoulders, Triceps", iconName: "flame", exercises: [])
        var body: some View {
            ExerciseListView(workout: $workout)
        }
    }
    return PreviewWrapper()
}
