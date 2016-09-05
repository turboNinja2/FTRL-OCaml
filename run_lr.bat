ocamlc bigarray.cma str.cma train.ml read_tools.ml maths.ml ftrl.ml -o ftrl.exe

ftrl.exe
del *.cmi
del *.cmo

ocamlc bigarray.cma str.cma train.ml read_tools.ml maths.ml main.ml -o logreg.exe


pause