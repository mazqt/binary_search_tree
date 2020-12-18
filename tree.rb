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

  def insert(value)
    new_node = Node.new(value)
    direction = nil
    prev_node = nil
    current_node = @root

    until current_node.nil?
      if current_node > new_node
        prev_node = current_node
        current_node = current_node.left
        direction = "left"
      else
        prev_node = current_node
        current_node = current_node.right
        direction = "right"
      end
    end

    if direction == "left"
      prev_node.left = new_node
    else
      prev_node.right = new_node
    end
  end

  def delete(value)
    debugger
    current_node = @root
    prev_node = nil
    direction = nil

    until current_node.data == value
      return "Value not found" if current_node.nil?
      prev_node = current_node

      if current_node.data > value
        current_node = current_node.left
        direction = "left"
      else
        current_node = current_node.right
        direction = "right"
      end
    end

    if current_node.left.nil? && current_node.right.nil?
      if direction == "left"
        prev_node.left = nil
      else
        prev_node.right = nil
      end
    elsif current_node.left.nil? && !current_node.right.nil?
      if direction == "left"
        prev_node.left = current_node.right
      else
        prev_node.right = current_node.right
      end
    elsif !current_node.left.nil? && current_node.right.nil?
      if direction == "left"
        prev_node.left = current_node.left
      else
        prev_node.right = current_node.left
      end
    else
      replacement_node = current_node.right

      until replacement_node.left.nil?
        replacement_node = replacement_node.left
      end

      new_node = Node.new(replacement_node.data)
      delete(replacement_node.data)
      new_node.left = current_node.left
      new_node.right = current_node.right

      if direction == "left"
        prev_node.left = new_node
      elsif direction == "right"
        prev_node.right = new_node
      else
        @root = new_node
      end
    end
  end

  def find(value)
    current_node = @root

    until current_node.data == value
      prev_node = current_node

      if current_node.data > value
        current_node = current_node.left
      else
        current_node = current_node.right
      end
      return "Value not found" if current_node.nil?
    end

    return current_node
  end

  def level_order()
    queue = [@root]
    values = []
    current_node = nil

    until queue.empty?
      current_node = queue.shift
      queue << current_node.left if !current_node.left.nil?
      queue << current_node.right if !current_node.right.nil?
      values << current_node.data
    end
    values
  end

  def inorder(node = @root)
    return node if node.left.nil? && node.right.nil?
    queue = []

    queue << inorder(node.left) if !node.left.nil?
    queue << node
    queue << inorder(node.right) if !node.right.nil?

    values = []
    queue.flatten.each do |node|
      if node.is_a?(Node)
        values << node.data
      else
        values << node
      end
    end
    values
  end

  def preorder(node = @root)
    return node if node.left.nil? && node.right.nil?
    queue = []

    queue << node
    queue << inorder(node.left) if !node.left.nil?
    queue << inorder(node.right) if !node.right.nil?

    values = []
    queue.flatten.each do |node|
      if node.is_a?(Node)
        values << node.data
      else
        values << node
      end
    end
    values
  end

  def postorder(node = @root)
    return node if node.left.nil? && node.right.nil?
    queue = []

    queue << inorder(node.left) if !node.left.nil?
    queue << inorder(node.right) if !node.right.nil?
    queue << node

    values = []
    queue.flatten.each do |node|
      if node.is_a?(Node)
        values << node.data
      else
        values << node
      end
    end
    values
  end
end

array = [3, 5, 2, 4, 6, 8, 31, 536, 1233, 231, 241, 123214, 4332, 123, 354, 187]
t = Tree.new(array)
t.insert(29)
t.insert(33)
t
t.level_order
t.inorder
t.preorder
t.postorder
