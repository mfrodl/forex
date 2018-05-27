class Instrument < ApplicationRecord
    has_many :candles, dependent: :destroy
end
