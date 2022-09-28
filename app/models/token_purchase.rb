class TokenPurchase < ApplicationRecord
  validates :user_id, presence: true
  validates :amount, presence: true
  # validates :discount
  validates :total, presence: true
  validates :status, inclusion: { in: [0, 1, 2] }

  belongs_to :user

  #Aggregate scopes
  scope :total_sales_amount, -> { where(status: 2).calculate(:sum, :total) }
  scope :total_sales, -> { where(status: 2).calculate(:count, :total) }
  scope :total_sales_for_years, ->(years) { where(created_at: Time.now.prev_year(years)...Time.now).where(status: 2).calculate(:sum, :total) }
  scope :total_sales_for_months, ->(months) { where(created_at: Time.now.prev_month(months)...Time.now).where(status: 2).calculate(:sum, :total) }

  # Aggregate data
  def self.total_sales_amount(params)
    data = run_sql("SELECT game_id, SUM(total) as total FROM token_purchases WHERE status = 2")
  end

  def self.total_sales(params)
    data = run_sql("SELECT COUNT(total) as total_sales FROM token_purchases WHERE status = 2")
  end

  def self.total_sales_between(params)
    min = params["min"]
    max = params["max"]
    data = run_sql("SELECT game_id, SUM(total) as total FROM token_purchases WHERE total < #{max} AND total > #{min} AND status = 2")
  end

  def self.total_sales_between_dates(params)
    min_date = params["min_date"]
    max_date = params["max_date"]
    data =
      run_sql("SELECT game_id, SUM(total) as total FROM token_purchases WHERE created_at < #{max_date} AND created_at > #{min_date} AND status = 2")
  end

  private

  def self.run_sql(sql)
    data = ActiveRecord::Base.connection.execute(sql)
    return data
  end
end
