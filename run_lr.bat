ocamlc str.cma train.ml read_tools.ml maths.ml main.ml -o logreg.exe

logreg.exe
del *.cmi
del *.cmo

pause