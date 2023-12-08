a=2
b = a+3

e = [-1 0 1 2 3 4]
e(1) = -2
#replace element

e([2 6]) = [-1 9]

a+b

##increment c=0:1:5, 0 to 5 by ones
d = (1:5)

##start, end, col size. start & end element and col size
f = linspace(0,5,6)

##col vector
v = [1;3;5;7;9]

##col_vector = row_vector'
g = f'

##MATRIX
#matrix = [row1a row1b row1c;
#          row2a row2b row2c]
ma = [3 5 -1;7 8 5;0 -1 2]
ma(1,2)
ma([1 2 3],2)
#matrix(row,col)

## n by n identity matrix: eye(n)
eye(1)

## ones(n,m) or ones(n) Matrix with ones
## Same as zeroes(n,m)
## rand(n,m) gives range 0 to 1

#reshape(matrix,n,m)
#combine matrix [C D] by row, or by column [C;D]

#Matrix add / subtract: Size must be same A+B A-B
#Matrix multip: A*scalar A*B conform rowXcol (nxm) (pxq) m=p
#Matrix element by element mult/ div: A.*B A./B A.^X
#MAtrix Transpose : A' row->columns

#PLOTTING

#fflush (stdout)
#x = input("Pick an x value:")
#fflush (stdout)
#y = input("Pick an x value:")
#plot(x, y)

##SCATTER PLOT
#plot(x,y, 'or', 'MarkerSize',12)
#grid on
#title('plot y vs x')
#set(gca, 'fontsize',24)
#xlabel('Variable x')
#ylabel('Variable y')
#axis([0 7 0 5])
#axis([xmin xmax ymin ymax])

##LINE PLOT
x1 = linspace(-2,2,5)
y1 = 0.5*x1+1

plot(x1, y1, 'bo-')
#plot(x1,y1,'bo-',x2,y2,'rx:')
##Sample plot with 2 lines

#save data.mat
#load data.mat
#save data1.mat x y %only x and y

