import AppIntents

struct AllAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: CheckBalanceIntent(),
                phrases: [
                    "Check my balance in \(.applicationName)",
                    "Check my balance in \(.applicationName) app",
                    "Check balance in \(.applicationName) app",
                    "Whats my balance in \(.applicationName) app",
                    "Can you check my balance in \(.applicationName)",
                ],
                systemImageName: "banknote"
            ),
             AppShortcut(
                 intent: LoadBalanceIntent(),
                 phrases: [
                     "Load \(\.$amount) rupees in \(.applicationName)",
                     "Load \(\.$amount) rupees in my \(.applicationName) account",
                     "Deposit \(\.$amount) rupees in \(.applicationName)",
                     "Deposit \(\.$amount) rupees in my \(.applicationName) account",
                     "Add \(\.$amount) rupees to my \(.applicationName) account",
                 ],
                 systemImageName: "plus.circle.fill"
             ) 
        ]
    }
}

