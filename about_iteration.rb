require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutIteration < Neo::Koan

  # -- An Aside ------------------------------------------------------
  # Ruby 1.8 stores names as strings. Ruby 1.9 stores names as
  # symbols. So we use a version dependent method "as_name" to convert
  # to the right format in the koans.  We will use "as_name" whenever
  # comparing to lists of methods.

  in_ruby_version("1.8") do
    def as_name(name)
      name.to_s
    end
  end

  in_ruby_version("1.9", "2.0") do
    def as_name(name)
      name.to_sym
    end
  end

  # Ok, now back to the Koans.
  # -------------------------------------------------------------------

  def test_each_is_a_method_on_arrays
    assert_equal true, [].methods.include?(as_name(:each))
  end

  def test_iterating_with_each
    array = [1, 2, 3]
    sum = 0
    array.each do |item|
      sum += item
    end
    assert_equal 6, sum
  end

  def test_each_can_use_curly_brace_blocks_too
    array = [1, 2, 3]
    sum = 0
    array.each { |item| sum += item }
    assert_equal 6, sum
  end

  def test_break_works_with_each_style_iterations
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    sum = 0
    array.each do |item|
      break if item > 3
      sum += item
    end
    assert_equal 6, sum
  end

  def test_collect_transforms_elements_of_an_array
    array = [1, 2, 3]
    new_array = array.collect { |item| item + 10 }
    assert_equal [11, 12, 13], new_array

    # NOTE: 'map' is another name for the 'collect' operation
    another_array = array.map { |item| item + 10 }
    assert_equal [11, 12, 13], another_array
  end

  def test_select_selects_certain_items_from_an_array
    array = [1, 2, 3, 4, 5, 6]

    even_numbers = array.select { |item| (item % 2) == 0 }
    assert_equal [2, 4, 6], even_numbers

    # NOTE: 'find_all' is another name for the 'select' operation
    more_even_numbers = array.find_all { |item| (item % 2) == 0 }
    assert_equal [2, 4, 6], more_even_numbers
  end

  def test_find_locates_the_first_element_matching_a_criteria
    array = ["Jim", "Bill", "Clarence", "Doug", "Eli"]

    assert_equal "Clarence", array.find { |item| item.size > 4 }
  end

  def test_inject_will_blow_your_mind
    result = [2, 3, 4].inject(0) { |sum, item| sum + item }
    assert_equal 9, result
    # Initial: inject(0)
    # 0 + 2 = 2
    # 2 + 3 = 5
    # 5 + 4 = 9
    
    # Initial: inject (1)
    # 1 + 2 = 3
    # 3 + 3 = 6
    # 6 + 4 = 10
    # assert_equal 10, result - true

    result2 = [2, 3, 4,].inject(1) { |product, item| product * item }
    assert_equal 24, result2
    # Initial:  inject(1)
    # 1 * 2 = 2
    # 2 * 3 = 6
    # 6 * 4 = 24
    
    # inject(2)
    # 2 * 2 = 4
    # 4 * 3 = 12
    # 12 * 4 = 48
    # assert_equal 48, result - true
    
    # inject(3)
    # 3 * 2 = 6
    # 6 * 3 = 18
    # 18 * 4 = 72
    # assert_equal 72, result - true
    

    # Extra Credit:
    # Describe in your own words what inject does.
    # -- The inject method iterates each item within a block. In the previous arrays, the inject method acts
    # upon each of the 3 elements. The first element is the initial value the block function acts upon. The
    # inject method acts upon the first element of the array, assigns an accumulator value, and then acts upon
    # each subsequent value of the array in the same manner. 
    #
    # If one imagines that the argument in inject(arg) changes each time through the array, it becomes easier
    # to understand the inject method. 
    #
    # For example in -
    # result2 = [2, 3, 4].inject(3) { |product, item| product * item }
    # Consider that after inject(3) acts upon result2[0], the inject argument becomes 6, inject(6)
    # When inject(6) acts upon result2[1], the inject argument becomes 18, inject(18)
    # When inject(18) acts upon result2[2], the inject argument becomes 72, inject(72)
    # Ruby returns the final value, 72. 
    #
    # If - result2 = [2, 3, 4, 5].inject(3) { |product, item| product * item }
    #   inject(3)
    #   3 * 2 = 6
    #   6 * 3 = 18
    #   18 * 4 = 72
    #   72 * 5 = 360
    # Then - the final value becomes 360
    
  end

  def test_all_iteration_methods_work_on_any_collection_not_just_arrays
    # Ranges act like a collection
    result = (1..3).map { |item| item + 10 }
    assert_equal [11, 12, 13], result

    # Files act like a collection of lines
    File.open("example_file.txt") do |file|
      upcase_lines = file.map { |line| line.strip.upcase }
      assert_equal ["THIS", "IS", "A", "TEST"], upcase_lines
    end

    # NOTE: You can create your own collections that work with each,
    # map, select, etc.
  end

  # Bonus Question:  In the previous koan, we saw the construct:
  #
  #   File.open(filename) do |file|
  #     # code to read 'file'
  #   end
  #
  # Why did we do it that way instead of the following?
  #
  #   file = File.open(filename)
  #   # code to read 'file'
  #
  # When you get to the "AboutSandwichCode" koan, recheck your answer.
  
  # Return to this later!

end
