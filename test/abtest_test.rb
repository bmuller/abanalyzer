# frozen_string_literal: true

require 'minitest/autorun'
require 'abanalyzer'

class ABTestTest < MiniTest::Test
  def setup
    @values = { rep: { male: 200, female: 250 }, dem: { male: 150, female: 300 }, ind: { male: 50, female: 50 } }
  end

  def test_test_creation
    assert_raises ABAnalyzer::InsufficientDataError do
      m = ABAnalyzer::ABTest.new(one: { a: 10, b: 20 }, two: { a: 5, b: 0 })
      m.gtest_p
    end

    assert_raises ABAnalyzer::InsufficientDataError do
      m = ABAnalyzer::ABTest.new(one: { a: 10, b: 20 }, two: { a: 5, b: -6 })
      m.gtest_p
    end

    assert_raises ABAnalyzer::InsufficientDataError do
      m = ABAnalyzer::ABTest.new(one: { a: 1, b: 1 }, two: { a: 1, b: 1 })
      m.gtest_p
    end
  end

  def test_results
    abt = ABAnalyzer::ABTest.new @values

    chisquare = 1 - Statistics2.chi2dist(2, 16.2037037037037)
    assert_equal abt.chisquare_p, chisquare

    gtest = 1 - Statistics2.chi2dist(2, 2 * 8.13286375180066)
    assert_equal abt.gtest_p, gtest
  end
end
