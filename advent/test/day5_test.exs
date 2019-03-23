defmodule Day5Test do
  use ExUnit.Case

  describe "reacted" do
    test "it works when nothing reacts" do
      assert Day5.reacted('abc') == 'abc'
    end

    test "it removes reacting components" do
      assert Day5.reacted('abB') == 'a'
    end
  end

  describe "add_to_reacted" do
    test "it adds a string if reacted is empty" do
      assert Day5.add_to_reacted(?a, '') == 'a'
    end

    test "it adds if the new char does not react with the front of the existing list" do
      assert Day5.add_to_reacted(?a, 'b') == 'ab'
    end

    test "it removes the front if the new char reacts with it" do
      assert Day5.add_to_reacted(?a, 'Ab') == 'b'
    end

    test "it does not remove anything if the new char reacts with something not at the front" do
      assert Day5.add_to_reacted(?a, 'bA') == 'abA'
    end
  end

  describe "react?" do
    test "lowercase letters react with their capital friends" do
      assert Day5.react?(?a, ?A) == true
      assert Day5.react?(?a, ?B) == false
      assert Day5.react?(?b, ?B) == true
    end

    test "uppercase letters react with their lowercase friends" do
      assert Day5.react?(?A, ?a) == true
      assert Day5.react?(?A, ?b) == false
      assert Day5.react?(?B, ?b) == true
    end

    test "uppercase letters do not react with themselves" do
      assert Day5.react?(?A, ?A) == false
      assert Day5.react?(?B, ?B) == false
    end

    test "lowercase letters do not react with themselves" do
      assert Day5.react?(?a, ?a) == false
      assert Day5.react?(?b, ?b) == false
    end
  end
end
