# flock

Flock is a simple tool to create visual object graphs of Swift source code.

![flock](flock.png)

To create the above diagram using [Graphviz](http://graphviz.org):
```sh
$ cd <flock repo>
$ flock Source > object_graph.dot
$ dot -Tpng object_graph.dot -o flock.png
```

## Installation

```sh
$ brew tap naoty/misc
$ brew install flock
```

## Usage
```sh
$ flock [folder of swift files] > object_graph.dot
$ dot -Tpdf object_graph.dot -o object_graph.pdf
```
