require 'open-uri'

URL = 'https://www.investing.com/currencies/eur-usd-historical-data'
NAME = 'EURUSD'

if !Instrument.exists?(name: NAME)
  Instrument.create(name: NAME)
end

instrument = Instrument.find_by(name: NAME)

open(URL) do |f|
  page = Nokogiri::HTML(f)
  page.xpath('//table[@id="curr_table"]/tbody/tr').each do |tr|
    start, close, open, high, low = tr.xpath('td/text()').map &:to_s
    start = start.to_datetime
    open, high, low, close = [open, high, low, close].map &:to_f
    puts "#{start}: #{open} - #{high} - #{low} - #{close}"
    if !Candle.exists?(instrument: instrument, start: start)
      Candle.create!(
        instrument: instrument,
        start: start,
        open: open,
        high: high,
        low: low,
        close: close
      )
    end
  end
end
