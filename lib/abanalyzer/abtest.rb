require 'statistics2'

module ABAnalyzer
  class ABTest
    # values should be hash of hashes, with top level hash the group names:
    # { :groupa => { :yes => 20, :no => 10 }, :groupb => { :yes => 18, :no => 8 } }
    def initialize(values)
      @values = Matrix.new values
    end

    def different?(sig = 0.05)
      gtest_p < sig
    end

    def chisquare_score
      sum = 0
      @values.each_cell do |colname, rowname, value|
        ex = expected(colname, rowname)
        test_sufficient_data(colname, rowname, ex, value)
        sum += ((value - ex)**2) / ex
      end
      sum
    end

    def gtest_score
      sum = 0
      @values.each_cell do |colname, rowname, value|
        ex = expected(colname, rowname)
        test_sufficient_data(colname, rowname, ex, value)
        sum += value * Math.log(value / ex)
      end
      sum
    end

    def chisquare_p
      1 - Statistics2.chi2dist(df, chisquare_score)
    end

    def gtest_p
      1 - Statistics2.chi2dist(df, 2 * gtest_score)
    end

    private

    def test_sufficient_data(colname, rowname, expected, value)
      msg = "Insufficient data size for column #{colname} row #{rowname}.  Expected value must be >= 5, and value must be > 0."
      raise InsufficientDataError, msg if (expected < 5) || (value <= 0)
    end

    def expected(colname, rowname)
      (@values.row_sum(rowname) * @values.column_sum(colname)).to_f / @values.total_sum.to_f
    end

    def df
      (@values.columns.length - 1) * (@values.rows.length - 1)
    end
  end
end
