ocamlopt str.cmxa read_tools.ml maths.ml train.ml log_reg.ml -o log_reg
ocamldoc -latex trees.ml maths.ml read_tools.ml print_tools.ml train.ml
pdflatex ocamldoc.out

rm *.cmi
rm *.cmx
rm *.o
rm *.log
rm *.out
rm *.sty
rm *.aux
rm *.toc

