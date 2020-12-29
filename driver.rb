require "./node.rb"
require "./tree.rb"

values = Array.new(15) { rand(1..100) }
tree = Tree.new(values)
tree.balanced?
tree.level_order
tree.preorder
tree.postorder
tree.inorder
tree.insert(4)
tree.insert(3)
tree.insert(2)
tree.insert(1)
tree.insert(1)
tree.balanced?
tree.rebalance
tree.balanced?
tree.level_order
tree.preorder
tree.postorder
tree.inorder
