

//
// This program is an educational tool for learning JSON parsing and decoding in SwiftUI.
// It allows users to enter JSON, clean it, decode it, and see the parsed result.
//

import SwiftUI

struct ContentView: View {
    
    // ----------- AUTO LIGHT/DARK MODE -----------
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var cleanedJSON: String = ""     // cleaned JSON after replacing invalid quotes
    @State private var inputJSON: String = ""       // raw JSON entered by the user
    @State private var decodedResult: String = ""   // decoded/parsed JSON result
    @State private var jsonError: String = ""       // JSON error message
    @State private var showHint: Bool = false       // toggle to show JSON example hint
    @State private var hintText = """
    {"Name": "John", "age": 30}
    """
    
    enum JsonError: Error {
        case Decoding
    }
    
    // ---------- JSON DECODING FUNCTION ----------
    func decodeJSON(_ text: String) throws -> String {
        guard let data = text.data(using: .utf8) else {
            throw JsonError.Decoding
        }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let parsedJSON = jsonObject else {
                throw JsonError.Decoding
            }
            return parsedJSON.map { " \($0.key): \($0.value)" }.joined(separator: "\n")
        } catch {
            throw JsonError.Decoding
        }
    }
    
    // ---------- USER INTERFACE ----------
    var body: some View {
        VStack(spacing: 12) {
            
            Image("logo")
                .resizable()
                .frame(width: 160, height: 160)
                .padding(.top, 10)
            
            ZStack(alignment: .topLeading) {
                TextField(showHint ? "\(hintText)" : "Enter JSON here...", text: $inputJSON)
                    .frame(width: 360, height: 140)
                    .padding(8)
                    .background(
                        colorScheme == .dark
                        ? Color.black.opacity(0.2)
                        : Color.white
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .padding(.horizontal, 16)
            
            
            HStack(spacing: 4) {
                Text("JSON Example")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Toggle("", isOn: $showHint)
                    .labelsHidden()
                
            }
            .padding(.leading, 180)
            .padding(.trailing, 25)
            
            
            if !decodedResult.isEmpty {
                Text("Result \n\(decodedResult)")
                    .foregroundColor(.green)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if !jsonError.isEmpty {
                Text("Please check your \(jsonError)")
                    .foregroundColor(.red)
            }
            
            
            HStack(spacing: 20) {
                
                // ---------- RUN ----------
                Button {
                    cleanedJSON = inputJSON
                        .replacingOccurrences(of: "“", with: "\"")
                        .replacingOccurrences(of: "”", with: "\"")
                        .replacingOccurrences(of: "„", with: "\"")
                        .replacingOccurrences(of: "«", with: "\"")
                        .replacingOccurrences(of: "»", with: "\"")
                        .replacingOccurrences(of: "’", with: "\"")
                        .replacingOccurrences(of: "‘", with: "\"")
                    
                    do {
                        decodedResult = try decodeJSON(cleanedJSON)
                        jsonError = ""
                    } catch {
                        decodedResult = ""
                        jsonError = "JSON syntax"
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "doc.text")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34, height: 34)
                            .foregroundColor(.green)
                        Text("Run")
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
                .frame(width: 150, height: 60)
                .background(
                    colorScheme == .dark
                    ? Color.black.opacity(0.2)
                    : Color.white
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                
                
                // ---------- CLEAR ----------
                Button {
                    decodedResult = ""
                    jsonError = ""
                    cleanedJSON = ""
                    inputJSON = ""
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34, height: 34)
                            .foregroundColor(.red)
                        Text("Clear")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .frame(width: 150, height: 60)
                .background(
                    colorScheme == .dark
                    ? Color.black.opacity(0.2)
                    : Color.white
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            .padding(.top, 4)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            colorScheme == .dark
            ? Color.black.opacity(0.9)
            : Color.white
        )
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ContentView()
}
