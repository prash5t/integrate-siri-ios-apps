import AppIntents

struct AllAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: OpenProfileIntent(),
                phrases: [
                    "Open my profile in \(.applicationName)",
                    "Open my profile in \(.applicationName) app"
                ]
            ),
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
            )
        ]
    }
}

