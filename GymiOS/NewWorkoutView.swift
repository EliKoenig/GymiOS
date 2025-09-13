import SwiftUI
import Foundation

struct NewWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedIcon: String = "star"
    @State private var showIconPicker: Bool = false
    @State private var selectedExercises: Set<Exercise> = []
    @State private var showExercisePicker: Bool = false
    var onDone: (Workout) -> Void
    
    let iconOptions = ["star", "flame", "bolt", "heart", "leaf", "hare", "tortoise", "bicycle", "figure.walk", "figure.run"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea(.all)
                VStack(alignment: .leading, spacing: 24) {
                    // Icon Picker Circle
                    Button(action: { showIconPicker = true }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.22, green: 0.22, blue: 0.25))
                                .frame(width: 80, height: 80)
                            Image(systemName: selectedIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    // Workout Name Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Workout Name")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                        ZStack(alignment: .leading) {
                            if name.isEmpty {
                                Text("Enter Name")
                                    .foregroundColor(Color(white: 0.6))
                                    .padding(.horizontal, 10)
                                    .allowsHitTesting(false)
                            }
                            TextField("", text: $name)
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.clear)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.default)
                        }
                        .background(Color(red: 0.22, green: 0.22, blue: 0.25))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.35, green: 0.35, blue: 0.38), lineWidth: 1)
                        )
                        .frame(height: 40)
                    }
                    // Workout Description Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Workout Description")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                        ZStack(alignment: .topLeading) {
                            if description.isEmpty {
                                Text("Enter description")
                                    .foregroundColor(Color(white: 0.6))
                                    .padding(.horizontal, 14)
                                    .padding(.top, 14)
                                    .allowsHitTesting(false)
                            }
                            TextEditor(text: $description)
                                .padding(10)
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.default)
                        }
                        .background(Color(red: 0.22, green: 0.22, blue: 0.25))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.35, green: 0.35, blue: 0.38), lineWidth: 1)
                        )
                        .frame(height: 100)
                    }
                    // Add Exercise Picker Button
                    Button(action: { showExercisePicker = true }) {
                        HStack {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.accentColor)
                            Text(selectedExercises.isEmpty ? "Add Exercises" : "Exercises: \(selectedExercises.count)")
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                        .padding()
                        .background(Color(red: 0.20, green: 0.20, blue: 0.22))
                        .cornerRadius(8)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
            }
            .navigationTitle("New Workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 0.08, green: 0.08, blue: 0.10), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Workout")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.accentColor)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let workout = Workout(
                            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
                            iconName: selectedIcon,
                            exercises: Array(selectedExercises)
                        )
                        onDone(workout)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(isPresented: $showIconPicker) {
                VStack(spacing: 24) {
                    Text("Choose an Icon")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 24) {
                        ForEach(iconOptions, id: \.self) { icon in
                            Button(action: {
                                selectedIcon = icon
                                showIconPicker = false
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(selectedIcon == icon ? Color.accentColor : Color(red: 0.22, green: 0.22, blue: 0.25))
                                        .frame(width: 48, height: 48)
                                    Image(systemName: icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(selectedIcon == icon ? .white : .accentColor)
                                }
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
                .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
            }
            .sheet(isPresented: $showExercisePicker) {
                ExercisePickerView(selectedExercises: $selectedExercises, allExercises: [
                    Exercise(name: "Bench Press"),
                    Exercise(name: "Squat"),
                    Exercise(name: "Deadlift"),
                    Exercise(name: "Pull Up"),
                    Exercise(name: "Push Up")
                ])
            }
        }
        .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea(.all))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NewWorkoutView { _ in }
}
