ocamlc str.cma trees.ml maths.ml read_tools.ml print_tools.ml train.ml main.ml
ocamldoc -latex trees.ml maths.ml read_tools.ml print_tools.ml train.ml main.ml
pdflatex ocamldoc.out
clean.bat