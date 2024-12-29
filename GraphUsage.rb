require './Graph'
require './GraphUtils'

=begin
***** Part 1 **************************************************************************************
A graph consists of nodes and edges. An edge is an unordered pair of two distinct nodes in the
graph. Every pair of nodes are joined by at most a single edge (these are simple graphs). We
create a new empty graph from the class Graph. We use the add_node method to add a
single node and the add_nodes method to add multiple nodes. Nodes are identified by unique
symbols. We call add_edge with two nodes to add an edge between a pair of nodes belonging
to the graph. We can ask a graph for the number of nodes and of edges it contains, and for a list
of its nodes and of its edges. The to_s method returns a string representing the graph's
adjacency lists. Methods should not change the graph if called with invalid arguments;
e.g., adding an edge that is already in the graph or that references a node that does not already
belong to the graph. Your code does not have to generate the exact transcript that follows but it
should provide this basic functionality.
***** Part 1 **************************************************************************************
=end


# g = Graph.new         # <Graph: 0, 0>
# g.add_node :a         # a
# g.add_nodes([:b, :c]) # [b, c]
# p g                   # <Graph: 3, 0>
# p g.get_nodes         # [a, b, c]
# p g.nbr_nodes         # 3
# g.add_edge(:a, :b)    # [a, b]
# g.add_edge(:b, :c)    # [b, c]
# p g                   # <Graph: 3, 2>
# p g.get_edges         # [[a, b], [b, c]]
# p g.nbr_edges         # 2
# puts g                # a -> b \n b -> a,c \n c -> b \n nil

=begin
***** Part 2 **************************************************************************************
Write a function genCompleteGraph(n, p) that takes a positive
integer n and, if argument p is not supplied, returns a complete graph on n nodes. The value of p,
a floating-point between 0.0 and 1.0, is the probability that an edge joins any given pair of nodes.
The default value of p is 1.0 indicating a complete graph with exactly [equation] edges. As the value of
p decreases, the graph becomes increasingly sparse, and for p equal to zero the graph consists of
n isolated nodes having no edges.
***** Part 2 **************************************************************************************
=end

# p c3 = GraphUtils.genCompleteGraph(3) # <Graph: 3, 3>
# p c3.get_nodes                        # [v0, v1, v2]
# p c3.get_edges                        # [[v0, v1], [v0, v2], [v1, v2]]
# p c5 = GraphUtils.genCompleteGraph(5) # <Graph: 5, 10>
# p c5.get_nodes                        # [v0, v1, v2, v3, v4]
# p c5.get_edges                        # [[v0, v1], [v0, v2], [v0, v3], [v0, v4], [v1, v2], [v1, v3], [v1, v4], [v2, v3], [v2, v4], [v3, v4]]

=begin
***** Part 3 **************************************************************************************
Add the method render(filename, center, radius) to your Graph class. This
method saves an image of this graph to filename in SVG format. The graph layout is circular,
where the layout circle's center and radius are given by the second and third arguments. Look
into using the Victor SVG image builder (https://github.com/DannyBen/victor), though you're
welcome to use a different graphics package.
***** Part 3 **************************************************************************************
=end

# c18 = GraphUtils.genCompleteGraph 18 
# c18.render 'c18.svg', [400, 400], 200

=begin
***** Part 4 **************************************************************************************
Define the utility method dfs(graph, node), a class method of GraphUtils, which
performs depth-first search in graph starting from node. The method returns an array of the
nodes reachable from node, that is, the set of nodes belonging to node's connected component.
***** Part 4 **************************************************************************************
=end

# c19 = GraphUtils.genCompleteGraph 5, 0.5
# p c19
# p GraphUtils.dfs(c19, c19.get_nodes[1])

=begin
***** Part 5 **************************************************************************************
Define the method render_graphs(filename, graphs_strokes_fills), a class
method of GraphUtils, for rendering and saving a set of graphs in SVG. The second argument is
an array of triples [g, scolor, fcolor] where g is a graph, scolor is the (stroke) color of its edges,
and fcolor is the (fill) color of its nodes. Note in the second transcript below, we use the utility
method genSubgraph(graph, nodes) which constructs a subgraph of graph on a subset
of its nodes. The subgraph's nodes inherits the properties – e.g., layout – of its parent graph.
***** Part 5 **************************************************************************************
=end

# c24 = GraphUtils.genCompleteGraph 24, 0.1
# c24.layout_circular [400, 400], 200
# c25 = GraphUtils.genCompleteGraph 10, 0.1
# c25.layout_circular [400, 400], 200
# GraphUtils.render_graphs 'c24and25.svg', [[c24, 'green', 'blue'], [c25, 'red', 'red']]