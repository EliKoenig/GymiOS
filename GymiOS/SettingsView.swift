//
//  SettingsView.swift
//  GymiOS
//
//  Created by lending on 9/11/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedUnit: String = "Imperial (lb/mi)"
    @State private var isUnitDropdownOpen: Bool = false
    var unitOptions = ["Imperial (lb/mi)", "Metric (kg/km)"]
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.16, blue: 0.18)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .font(.system(size: 24, weight: .bold))
                    }
                    .padding(.leading, 8)
                    Spacer()
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .semibold))
                        .padding(.trailing, 32)
                    Spacer()
                }
                .frame(height: 52)
                .padding(.top, 8)
                // Grouped settings style
                VStack(spacing: 0) {
                    ForEach([
                        "Account",
                        "Unit",
                        "Display",
                        "Reminders",
                        "Interset Rest",
                        "Help"
                    ].enumerated().map({ $0 }), id: \.offset) { index, title in
                        if title == "Unit" {
                            Button(action: { withAnimation { isUnitDropdownOpen.toggle() } }) {
                                HStack {
                                    Text(title)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                        .padding(.leading, 16)
                                    Spacer()
                                    Text(selectedUnit)
                                        .foregroundColor(Color(white: 0.7))
                                        .font(.system(size: 15))
                                        .padding(.trailing, 8)
                                    Image(systemName: isUnitDropdownOpen ? "chevron.up" : "chevron.down")
                                        .foregroundColor(Color(white: 0.6))
                                        .font(.system(size: 15, weight: .semibold))
                                        .padding(.trailing, 16)
                                }
                                .frame(height: 44)
                                .contentShape(Rectangle())
                                .background(Color.clear)
                            }
                            if isUnitDropdownOpen {
                                VStack(spacing: 0) {
                                    ForEach(unitOptions, id: \.self) { option in
                                        Button(action: {
                                            selectedUnit = option
                                            withAnimation { isUnitDropdownOpen = false }
                                        }) {
                                            HStack {
                                                Text(option)
                                                    .foregroundColor(selectedUnit == option ? .accentColor : .white)
                                                    .font(.system(size: 16))
                                                    .padding(.leading, 32)
                                                Spacer()
                                                if selectedUnit == option {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.accentColor)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .padding(.trailing, 16)
                                                }
                                            }
                                            .frame(height: 40)
                                            .background(Color(red: 0.20, green: 0.20, blue: 0.22))
                                        }
                                        if option != unitOptions.last {
                                            Divider()
                                                .background(Color(red: 0.25, green: 0.25, blue: 0.28))
                                                .padding(.leading, 32)
                                        }
                                    }
                                }
                                .background(Color(red: 0.20, green: 0.20, blue: 0.22))
                            }
                            if index < 5 {
                                Divider()
                                    .background(Color(red: 0.25, green: 0.25, blue: 0.28))
                                    .padding(.leading, 16)
                            }
                        } else {
                            NavigationLink(destination: EmptyView()) {
                                HStack {
                                    Text(title)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                        .padding(.leading, 16)
                                    Spacer()
                                    if title != "Unit" {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color(white: 0.6))
                                            .font(.system(size: 15, weight: .semibold))
                                            .padding(.trailing, 16)
                                    }
                                }
                                .frame(height: 44)
                                .contentShape(Rectangle())
                                .background(Color.clear)
                            }
                            if index < 5 {
                                Divider()
                                    .background(Color(red: 0.25, green: 0.25, blue: 0.28))
                                    .padding(.leading, 16)
                            }
                        }
                    }
                }
                .background(Color(red: 0.20, green: 0.20, blue: 0.22))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 12)
                Spacer(minLength: 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView()
}
