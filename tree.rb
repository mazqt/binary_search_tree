require "./node.rb"
require "byebug"

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return if array.empty?
    sorted_array = array.sort

    mid = sorted_array.length / 2

    root = Node.new(sorted_array[mid])
    root.left = build_tree(sorted_array[0...mid])
    root.right = build_tree(sorted_array[(mid + 1)..-1])

    return root
  end
end

array = [3, 5, 2, 4, 6, 8, 31, 536, 1233]
t = Tree.new(array)
t
