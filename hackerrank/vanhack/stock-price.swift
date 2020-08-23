import Foundation

let stringDateFormat = "d-MMMM-yyyy"

extension Date {
    static func from(string: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }

    func getWeekdayNumber() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

enum StockError: Error {
    case NoStockError
    case InvalidParameterError
    case InvalidData
}

extension StockError {
    var localizedDescription: String {
        switch self {
            case .NoStockError: return "Stock not found."
            case .InvalidParameterError: return "Invalid parameter."
            case .InvalidData: return "Invalid data provided."
        }
    }
}

enum Weekday: String {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"

    static func from(weekdayNumber: Int) -> Weekday {
        switch weekdayNumber {
            case 1: return .sunday
            case 2: return .monday
            case 3: return .tuesday
            case 4: return .wednesday
            case 5: return .thursday
            case 6: return .friday
            default: return .saturday
        }
    }
}

struct StockInfo {
    var date: Date
    var rawDate: String
    var weekday: Weekday
    var open: Double
    var close: Double
}

extension StockInfo: Decodable {

    enum CodingKeys: String, CodingKey {
        case open, close
        case rawDate = "date"
    }

    /// This method decodes StockInfo from the json dictionary
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let dateString = try values.decode(String.self, forKey: .rawDate)
        guard let stockDate = Date.from(string: dateString, format: stringDateFormat) else {
            throw StockError.InvalidData
        }

        guard let weekdayNumber = stockDate.getWeekdayNumber() else {
            throw StockError.InvalidData
        }

        date = stockDate
        rawDate = try values.decode(String.self, forKey: .rawDate)
        weekday = Weekday.from(weekdayNumber: weekdayNumber)
        open = try values.decode(Double.self, forKey: .open)
        close = try values.decode(Double.self, forKey: .close)
    }
}

class Stock {
    private var jsonData: Data

    init(jsonData: Data) {
        self.jsonData = jsonData
    }

    ///
    ///  This method gets the stock information from the json data
    ///
    /// - Returns
    ///     An array of _StockInfo_ of the stocks prices from the json data
    ///
    func getStockInfo() throws -> [StockInfo] {
        let decoder = JSONDecoder()
        guard let stocksInfo = try? decoder.decode([StockInfo].self, from: jsonData) else {
            throw StockError.InvalidData
        }
        return stocksInfo
    }
}

protocol StockProtocol {
    func openAndClosePrices(firstDate: String, lastDate: String, weekDay: String) throws -> [StockInfo]
}

///
/// I made a slight change to this class from what it was mentioned in the problem description, see method _openAndClosePrices_
///
class StockPrice: StockProtocol {

    private var stockData: Stock

    init(stockData: Stock) {
        self.stockData = stockData
    }

    ///
    ///  This method gets the stock information between _firstDate_ and _lastDate_ when the weekday is _weekday_
    ///
    ///  The method does not return an array of _Stock_, but of _StockInfo_ as stated in the description.
    ///  The reason behind this alteration is because _Stock_ is a class used to parse the entire json data, hence it
    ///  handles *all* stock prices. An array of _Stock_ won't be the proper return type because _Stock_ would be handling
    ///  both the stock prices from the json data and each stock price information.
    ///
    ///
    /// - Parameters
    ///     - firstDate: lower bound of the date range to look for
    ///     - lastDate: upper bound of the date range to look for
    ///     - weekday: weekday
    ///
    /// - Returns
    ///     An array of _StockInfo_ of the stocks prices between _firstDate_ and _lastDate_ when the weekday is _weekday_
    ///
    func openAndClosePrices(firstDate: String, lastDate: String, weekDay: String) throws -> [StockInfo] {
        guard let firstDate = Date.from(string: firstDate, format: stringDateFormat) else {
            throw StockError.InvalidParameterError
        }

        guard let lastDate = Date.from(string: lastDate, format: stringDateFormat) else {
            throw StockError.InvalidParameterError
        }

        var filteredStocks = [StockInfo]()
        let stocks = try stockData.getStockInfo()
        for stockInfo in stocks {
            let stockDate = stockInfo.date
            if stockDate >= firstDate && stockDate <= lastDate && stockInfo.weekday.rawValue == weekDay {
                filteredStocks.append(stockInfo)
            }

            // Stop when stock date is greater than the lastDate (upperBound) to avoid unnecessary iterations
            // All dates from this point forward won't be in the date range
            if lastDate < stockDate {
                break
            }
        }

        return filteredStocks
    }
}

func processStockPrices(firstDate: String, lastDate: String, weekDay: String) throws -> [StockInfo] {
    // Read json file
    let urlstring = URL(fileURLWithPath: "data.json")
    let jsonData = try Data(contentsOf: urlstring)

    // Initialize classes
    let stock = Stock(jsonData: jsonData)
    let stockPrice = StockPrice(stockData: stock)

    // Get open and close prices
    let results = try stockPrice.openAndClosePrices(firstDate: firstDate, lastDate: lastDate, weekDay: weekDay)
    if results.count <= 0 {
        throw StockError.NoStockError
    }

    return results
}

// STDIN
guard let firstDate = readLine() else {
    fatalError(StockError.InvalidParameterError.localizedDescription)
}

guard let lastDate = readLine() else {
    fatalError(StockError.InvalidParameterError.localizedDescription)
}

guard let weekDay = readLine() else {
    fatalError(StockError.InvalidParameterError.localizedDescription)
}

// STDOUT
let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

do {
    let results = try processStockPrices(firstDate: firstDate, lastDate: lastDate, weekDay: weekDay)
    fileHandle.write(results.map{ "\($0.rawDate) \($0.open) \($0.close)" }.joined(separator: "\n").data(using: .utf8)!)
    fileHandle.write("\n".data(using: .utf8)!)

} catch let error as StockError {
    fileHandle.write("\(error.localizedDescription)".data(using: .utf8)!)
} catch {
    print("Something went wrong")
}