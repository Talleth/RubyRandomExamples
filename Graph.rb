class Graph

    attr_reader :render_graph_center
    attr_reader :render_graph_radius

    def initialize
        @nodes = []
        @edges = []
    end

    def add_node(node)
        @nodes << node unless @nodes.include?(node)
    end

    def add_nodes(nodes)
        nodes.each { |node| add_node(node) }
    end

    def add_edge(node1, node2)
        return if node1 == node2 || !@nodes.include?(node1) || !@nodes.include?(node2) || edge_exists?(node1, node2)

        @edges << [node1, node2]
    end

    def nbr_nodes
        @nodes.size
    end

    def get_nodes
        @nodes
    end

    def nbr_edges
        @edges.size
    end

    def get_edges
        @edges
    end

    def layout_circular(center, radius)
        @render_graph_center = center
        @render_graph_radius = radius
    end

    def to_s
        result = ""
        @nodes.each do |node|
          neighbors = @edges.select { |edge| edge.include?(node) }.map { |edge| edge - [node] }
          result += "#{node} -> #{neighbors.join(',')}\n"
        end
        result.chomp
    end
    
    def render(filename, center, radius)
        layout_circular center, radius
        GraphUtils.render_graphs filename, [[self, 'red', 'blue']]
    end

    private

    def edge_exists?(node1, node2)
        @edges.include?([node1, node2]) || @edges.include?([node2, node1])
    end
end 