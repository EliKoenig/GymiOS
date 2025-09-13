//
//  ContentView.swift
//  GymiOS
//
//  Created by lending on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var workouts: [Workout] = []
    @State private var showingNewWorkout = false

    init() {
        // Debug: Print all available font family and font names
        for family in UIFont.familyNames.sorted() {
            print("\(family): \(UIFont.fontNames(forFamilyName: family))")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color(red: 0.08, green: 0.08, blue: 0.10)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("PR")
                        .font(.custom("Darkcastle", size: 56))
                        .foregroundColor(.accentColor)
                        .padding(.top, 20)
                    Text("My Workouts")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    // Replace VStack with List for workouts
                    List {
                        Button(action: { showingNewWorkout = true }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.accentColor)
                                    .font(.system(size: 20, weight: .bold))
                                Text("New Workout")
                                    .foregroundColor(.accentColor)
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                            }
                            .padding(.vertical, 6) // Reduced from 12
                            .padding(.leading, 16)
                            .padding(.trailing, 8)
                        }
                        .listRowBackground(Color(red: 0.20, green: 0.20, blue: 0.22))
                        ForEach($workouts) { $workout in
                            NavigationLink(destination: ExerciseListView(workout: $workout)) {
                                HStack {
                                    ZStack {
                                        // Fixed-size container for icon
                                        Color.clear
                                            .frame(width: 32, height: 32)
                                        Image(systemName: workout.iconName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.accentColor)
                                    }
                                    .padding(.leading, 16)
                                    Text(workout.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(white: 0.6))
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.trailing, 16)
                                }
                                .frame(height: 32) // Reduced from 44
                            }
                            .listRowBackground(Color(red: 0.20, green: 0.20, blue: 0.22))
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.10))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.top, 4)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .padding()
                }
                .accessibilityLabel("Settings")
            }
        }
        .fullScreenCover(isPresented: $showingNewWorkout) {
            NewWorkoutView { newWorkout in
                workouts.append(newWorkout)
            }
            .presentationBackground(Color(red: 0.08, green: 0.08, blue: 0.10))
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
