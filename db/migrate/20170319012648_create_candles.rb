class CreateCandles < ActiveRecord::Migration[5.0]
  def change
    create_table :candles do |t|
      t.datetime :start
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.integer :instrument_id

      t.timestamps
    end

    add_index :candles, :instrument_id
  end
end
