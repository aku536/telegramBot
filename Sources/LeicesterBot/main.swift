import Foundation
import TelegramBotSDK

let token = readToken(from: "LEICESTER_BOT_TOKEN")
let bot = TelegramBot(token: token)
bot.autoReconnect = true

while let update = bot.nextUpdateSync() {
    if let message = update.message, let from = message.from, let text = message.text {
        bot.sendMessageAsync(chatId: .chat(from.id),
                             text: "Hi \(from.firstName)! You said: \(text).\n")
        if update.message?.text == "Опрос" {
            bot.sendPollAsync(chatId: .chat(from.id),
                              question: "Буду на игре:",
                              options: ["Да", "Нет"],
                              isAnonymous: false)
        }
    }
}

fatalError("Server stopped due to error: \(String(describing: bot.lastError))")
