require_relative 'test_helper'
require_relative '../lib/merchant_report'


class MerchantReportTest < Minitest::Test
  def test_it_initializes_with_sales_analyst_loaded_with_csvs
    report = MerchantReport.new

    assert_instance_of SalesAnalyst, report.sa
    assert_instance_of Merchant, report.sa.se.merchants.all.sample
  end
end
