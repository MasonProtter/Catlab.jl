import CompCat.Diagram: Wiring
using CompCat.Diagram.TikZ
using Base.Test

# Pretty-print
##############

# Node statement
@test spprint(Node("f")) == "\\node (f) {};"
@test spprint(Node("f"; props=[Property("circle")])) == 
  "\\node[circle] (f) {};"
@test spprint(Node("f"; props=[Property("circle"),Property("fill","red")])) ==
  "\\node[circle,fill=red] (f) {};"
@test spprint(Node("f"; coord=Coordinate("0","1"))) ==
  "\\node (f) at (0,1) {};"
@test spprint(Node("f"; coord=Coordinate("1","0"), content="fun")) ==
  "\\node (f) at (1,0) {fun};"

# Edge statement
@test spprint(Edge("f","g")) == "\\draw (f) to (g);"
@test spprint(Edge("f","g"; props=[Property("red")])) == "\\draw[red] (f) to (g);"
@test spprint(Edge("f","g"; node=EdgeNode())) == "\\draw (f) to node (g);"
@test spprint(Edge("f","g"; node=EdgeNode(;props=[Property("circle")],content="e"))) ==
  "\\draw (f) to node[circle] {e} (g);"
@test spprint(Edge("f","g"; op=PathOperation("to"; props=[Property("out","0")]))) ==
  "\\draw (f) to[out=0] (g);"

# Picture statement
@test spprint(
Picture(
  Node("f"),
  Node("g"),
  Edge("f","g")
)) == """
\\begin{tikzpicture}
  \\node (f) {};
  \\node (g) {};
  \\draw (f) to (g);
\\end{tikzpicture}"""

@test spprint(Picture(Node("f");props=[Property("node distance","1cm")])) == """
\\begin{tikzpicture}[node distance=1cm]
  \\node (f) {};
\\end{tikzpicture}"""

# Scope statement
@test spprint(
Picture(
  Scope(Node("f"); props=[Property("red")]),
  Scope(Node("g"); props=[Property("blue")]),
  Edge("f","g")
)) == """
\\begin{tikzpicture}
  \\begin{scope}[red]
    \\node (f) {};
  \\end{scope}
  \\begin{scope}[blue]
    \\node (g) {};
  \\end{scope}
  \\draw (f) to (g);
\\end{tikzpicture}"""

# Graph, GraphScope, GraphNode, GraphEdge statements
@test spprint(
Graph(
  GraphNode("f";content="fun"),
  GraphEdge("f","g")
)) == """
\\graph{
  f/\"fun\";
  f -> g;
};"""

@test spprint(
Graph(
  GraphNode("f";props=[Property("circle")]),
  GraphEdge("f","g";props=[Property("edge label","X")])
)) == """
\\graph{
  f [circle];
  f ->[edge label=X] g;
};"""

@test spprint(
Graph(
  GraphScope(
    GraphEdge("a","b"); props=[Property("same layer")]
  ),
  GraphScope(
    GraphEdge("c","d"); props=[Property("same layer")]
  )
)) == """
\\graph{
  {[same layer]
    a -> b;
  };
  {[same layer]
    c -> d;
  };
};"""

# Matrix statement
@test spprint(
MatrixNode(
  vcat(hcat( [[Node("f")]],             [[Edge("g1","g2")]] ),
       hcat( [[Node("h1"),Node("h2")]], [[Node("i1"),Node("i2")]] )),
  props=[Property("draw","red")]
)) == """
\\matrix[draw=red]{
  \\node (f) {}; &
  \\draw (g1) to (g2); \\\\
  \\node (h1) {};
  \\node (h2) {}; &
  \\node (i1) {};
  \\node (i2) {}; \\\\
};"""