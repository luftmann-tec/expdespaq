function B=sortpar(A)
%SORTPAR Reordena una matriz en función de solo la primera fila 
%
%   SORTPAR Ordena ascendentemente la primera fila de una matriz
%   moviendo los elementos de las demás filas al nuevo orden controlado por
%   la primera fila ordenada.
%
%   Ejemplo:
%   Sea A=[3 8 2 3 0 3 2 9; 1 2 3 4 5 6 7 8]
%   Entonces B=[0 2 2 3 3 3 8 9 ; 5 3 7 1 4 6 2 8]

%   Ing. Rodolfo Salazar Peña M. en C.
%   Revisado: 16/Ene/2011

%Inicializaciones
[r,s]=size(A);
D=A(1,:);
G=NaN;
B=zeros(r,1);

%ordenación primera fila
for i=1:s
    [g,h]=min(D);
    G(i)=g;
    D(h)=NaN;
    B(:,i)=A(:,h);
end
