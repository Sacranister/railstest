class Graph
  attr_reader :graph, :nodes, :previous, :distance
  INFINITY = 1 << 64

  def initialize
    @graph = {}
    @nodes = Array.new
  end

  def connect_graph(source, target, weight)
    if (!graph.has_key?(source))
      graph[source] = {target => weight}
    else
      graph[source][target] = weight
    end
    if (!nodes.include?(source))
      nodes << source
    end
  end

  def add_edge(source, target, weight)
    connect_graph(source, target, weight)
    connect_graph(target, source, weight)
  end


  def dijkstra(source)
    @distance={}
    @previous={}
    nodes.each do |node|
     @distance[node] = INFINITY
     @previous[node] = -1
    end
    @distance[source] = 0
    unvisited_node = nodes.compact
    while (unvisited_node.size > 0)
     u = nil;
     unvisited_node.each do |min|
       if (not u) or (@distance[min] and @distance[min] < @distance[u])
         u = min
       end
     end
     if (@distance[u] == INFINITY)
       break
     end
     unvisited_node = unvisited_node - [u]
     graph[u].keys.each do |vertex|
       alt = @distance[u] + graph[u][vertex]
       if (alt < @distance[vertex])
         @distance[vertex] = alt
         @previous[vertex] = u  #A shorter path to v has been found
       end
     end
    end
  end

  def find_path(dest)
    if @previous[dest] != -1
      find_path @previous[dest]
    end
    @path << dest
  end

  def shortest_paths(source)
    @graph_paths=[]
    @source = source
    dijkstra source
    nodes.each do |dest|
      @path=[]

      find_path dest

      actual_distance=if @distance[dest] != INFINITY
                      @distance[dest]
                    else
                      "no path"
                    end
      @graph_paths<< "Target(#{dest})  #{@path.join("-->")} : #{actual_distance}"
    end
    @graph_paths
  end

  def print_result
    @graph_paths.each do |graph|
      puts graph
    end
  end
end

if __FILE__ == $0
  gr = Graph.new
  gr.add_edge("a", "c", 7)
  gr.add_edge("a", "e", 14)
  gr.add_edge("a", "f", 9)
  gr.add_edge("c", "d", 15)
  gr.add_edge("c", "f", 10)
  gr.add_edge("d", "f", 11)
  gr.add_edge("d", "b", 6)
  gr.add_edge("f", "e", 2)
  gr.add_edge("e", "b", 9)
  gr.shortest_paths("a")
  gr.print_result

end
