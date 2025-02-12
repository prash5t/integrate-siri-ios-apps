import AppIntents

struct AllAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: TalkToVillagerIntent(),
                phrases: [
                    "Talk to villager in \(.applicationName)",
                    "Call villager in \(.applicationName)",
                    "Open villager in \(.applicationName)",
                    "Open \(.applicationName)",
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
            ),
            AppShortcut(
                intent: LoadBalanceIntent(),
                phrases: [
                    "Load money in \(.applicationName)",
                    "Deposit money in \(.applicationName)",
                    "Add money to \(.applicationName)",
                ],
                systemImageName: "plus.circle.fill"
            ),
            AppShortcut(
                intent: CheckStockPriceIntent(),
                phrases: [
                    "Check stock price in \(.applicationName)",
                    "Check stock price of \(\.$company)",
                    "Check stock price of \(\.$company) in \(.applicationName)",
                    "Check nepse in \(.applicationName)",
                    "Check company price in \(.applicationName)"
                ]
            )
        ]
    }
}

