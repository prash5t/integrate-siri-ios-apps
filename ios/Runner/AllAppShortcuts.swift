import AppIntents

struct AllAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: CheckBalanceIntent(),
                phrases: [
                    "Check balance in \(.applicationName)",
                    "Check my balance in \(.applicationName)",
                    "Whats my balance in \(.applicationName)",
                    "Can you check my balance in \(.applicationName)"
                ]
            )
        ]
    }
}
