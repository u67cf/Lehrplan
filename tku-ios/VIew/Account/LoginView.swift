import SwiftUI
import WebKit
import KeychainSwift

struct LoginView: View {
    @State private var cookies: [HTTPCookie] = []
    @State private var showLoginPage : Bool = false // Renamed for Swift naming convention
    private let url = "https://sso.tku.edu.tw/ilife/CoWork/AndroidSsoLogin.cshtml" // URL as a string constant
    //private let keychain = KeychainSwift()
    
    var body: some View {
        VStack {
            // Main content of your app
            if !showLoginPage {
                ScrollView {
                    Text(cookiesDescription()) // Use a function to convert cookies to String
                        .padding()
                    Button("Fetch Data") {
                        fetchData()
                    }
                }
            } else {
               Text("LOGIN?")
            }
        }
        .onAppear{
            if let data = UserDefaults.standard.data(forKey: "savedCookies") {
                do {
                    if let loadedCookies = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, HTTPCookie.self], from: data) as? [HTTPCookie] {
                        self.cookies = loadedCookies
                    }
                } catch {
                    print("something wrong")
                }
            }
            test()
        }
        .sheet(isPresented: $showLoginPage) {
            // WebView as a sheet
            WebView(url: URL(string: url)!)
            Button("Fetch Cookies") {
                // This will show the login page
                getWebsiteCookies()
                self.showLoginPage = false
            }
        }
    }

    func getWebsiteCookies() {
        let webView = WKWebView() // No need for a frame or custom configuration here for cookie fetching
        guard let url = URL(string: url) else { return }

        webView.load(URLRequest(url: url))

        // Delay fetching cookies to give the web view time to load and process them.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 5 seconds delay for demonstration, adjust as necessary
            webView.getCookies(for: url.host) { cookieDict in
                self.cookies = cookieDict.values.compactMap { properties in
                    HTTPCookie(properties: properties as! [HTTPCookiePropertyKey: Any])
                }

                if !self.cookies.isEmpty {
                    UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: self.cookies, requiringSecureCoding: false), forKey: "savedCookies")
                    // Assuming login success if cookies were received, adjust logic as needed
                    DispatchQueue.main.async {
                        self.showLoginPage = false // Update UI on main thread
                        // Log or process cookies as needed
                        for cookie in self.cookies {
                            print("Cookie Name: \(cookie.name), Value: \(cookie.value)")
                        }
                    }
                }
            }
        }
    }
    
    func cookiesDescription() -> String {
        if let data = UserDefaults.standard.data(forKey: "savedCookies") {
            do {
                // Use the new method for unarchiving
                if let loadedCookies = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, HTTPCookie.self], from: data) as? [HTTPCookie] {
                    // Successfully loaded cookies, return their description
                    return loadedCookies.map { "\($0.name): \($0.value)" }.joined(separator: "\n")
                } else {
                    // Data exists, but couldn't be cast to [HTTPCookie]
                    return "No valid cookies found."
                }
            } catch {
                // Error during unarchiving
                print("Couldn't read file: \(error)")
                return "Failed to read cookies data."
            }
        }
        // No data found for key "savedCookies"
        return "No cookies data stored."
    }


    
    func fetchData() {
        guard let url = URL(string: "https://sso.tku.edu.tw/ePortfolio/ilifeStuClass.cshtml") else { return } // Use the current URL
        makeAuthenticatedRequest(url: url, cookies: cookies) // Use the current cookies
        test()
    }
    
    func test() {
        print("test")
        guard let url = URL(string: url) else { return }
        if let data = UserDefaults.standard.data(forKey: "savedCookies") {
            do {
                if let loadedCookies = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, HTTPCookie.self], from: data) as? [HTTPCookie] {
                    isLogin(url: url, cookies: loadedCookies) { isLoggedIn in
                        if isLoggedIn {
                            self.showLoginPage = false
                        } else {
                            self.showLoginPage = true
                        }
                    }
                }
            } catch {
                self.showLoginPage = true
            }
        }

    }
}
