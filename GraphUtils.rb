require 'victor'
require 'set'
require './Graph'

class GraphUtils
    def self.genCompleteGraph(n, p = 1.0)
        # Create a new Graph instance
        graph = Graph.new

        # Add nodes to the graph
        (0..n-1).each { |node| graph.add_node(("v" + node.to_s).to_sym) }

        # Iterate through all pairs of nodes and add edges with probability p
        graph.get_nodes.combination(2).each do |pair|
            node1, node2 = pair
            if rand <= p
                graph.add_edge(node1, node2)
            end
        end

        return graph
    end

    def self.dfs(graph, node)
        visited = Set.new
        dfs_rec(graph, node, visited)
        visited.to_a
    end

    def self.render_graphs(filename, graphs_strokes_fills)
        svg = Victor::SVG.new width: 1000, height: 1000, style: { background: 'white' }

        graphs_strokes_fills.each do |graph, scolor, fcolor|
            nodes = graph.get_nodes
            edges = graph.get_edges
            center = graph.render_graph_center
            radius = graph.render_graph_radius

            svg.build do

            # This calculates the distance between nodes
            angle_step = (2 * Math::PI) / nodes.size

            # This calculates node coordinates
            # This requires a little math to figure out where the nodes should sit in the circle
            node_positions = nodes.each_with_index.map do |node, index|
                x = center[0] + radius * Math.cos(index * angle_step)
                y = center[1] + radius * Math.sin(index * angle_step)
                [node, [x, y]]
            end.to_h

            # Draw edges
            edges.each do |edge|
                node1, node2 = edge
                x1, y1 = node_positions[node1]
                x2, y2 = node_positions[node2]
                line x1: x1, y1: y1, x2: x2, y2: y2, stroke: scolor
            end

            # Draw nodes
                angle_step = (2 * Math::PI) / nodes.size
                node_positions = nodes.each_with_index.map do |node, index|
                    x = center[0] + radius * Math.cos(index * angle_step)
                    y = center[1] + radius * Math.sin(index * angle_step)
                    [node, [x, y]]
                end.to_h

                nodes.each do |node|
                    x, y = node_positions[node]
                    circle cx: x, cy: y, r: 5, fill: fcolor
                end
            end
        end

        # Save the SVG file
        svg.save(filename)
    end

    private

    # DFS Explaination
    # 1. Add current node that as visited
    # 2. Get all the neighbors of the node (minus the node itself)
    # 3. Loop through each of those neighbors
    # 4. Determine next node to visit (that isn't the current node)
    # 5. Return list of visited nodes
    
    def self.dfs_rec(graph, node, visited)
        visited.add(node)
        neighbors = graph.get_edges.select { |edge| edge.include?(node) }.map { |edge| edge - [node] }
        neighbors.each do |neighbor|
            next_node = neighbor[0] == node ? neighbor[1] : neighbor[0]
            if !visited.include?(next_node)
                dfs_rec(graph, next_node, visited)
            end
        end
    end
end 